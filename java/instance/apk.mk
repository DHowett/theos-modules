ifeq ($(FW_RULES_LOADED),)
include $(FW_MAKEDIR)/rules.mk
endif
.PHONY: internal-apk-all_ internal-apk-stage_ internal-apk-compile

ifeq ($(FW_MAKE_PARALLEL_BUILDING), no)
internal-apk-all_:: $(FW_OBJ_DIR) $(FW_CLASSES_DIR) $(FW_OBJ_DIR)/$(FW_INSTANCE).apk
else
internal-apk-all_:: $(FW_OBJ_DIR) $(FW_CLASSES_DIR)
	$(ECHO_NOTHING)$(MAKE) --no-print-directory --no-keep-going \
		internal-apk-compile \
		FW_TYPE=$(FW_TYPE) FW_INSTANCE=$(FW_INSTANCE) FW_OPERATION=compile \
		FW_BUILD_DIR="$(FW_BUILD_DIR)" _FW_MAKE_PARALLEL=yes$(ECHO_END)

internal-apk-compile: $(FW_OBJ_DIR)/$(FW_INSTANCE).apk
endif

# $(FW_OBJ_DIR)/$(FW_INSTANCE).manifest
$(FW_OBJ_DIR)/res.zip.stamp: res
	@touch $@
	$(ECHO_RESOURCES)$(TARGET_AAPT) package -f -M AndroidManifest.xml -F $(FW_OBJ_DIR)/res.zip -I $(BOOTCLASSPATH) -S res -J $(FW_OBJ_DIR)$(ECHO_END)

$(FW_OBJ_DIR)/R.java.stamp: $(FW_OBJ_DIR)/res.zip.stamp
	@touch $@
	$(ECHO_RJAVA)$(TARGET_JAVAC) $(TARGET_JAVAC_ARGS) -d $(FW_CLASSES_DIR)/ $(FW_OBJ_DIR)/R.java$(ECHO_END)

$(FW_OBJ_DIR)/classes.dex: $(OBJ_FILES_TO_LINK)
	$(ECHO_DEXING)$(TARGET_DX) --dex --output=$@ $(FW_CLASSES_DIR)$(ECHO_END)

$(FW_OBJ_DIR)/$(FW_INSTANCE).unsigned.apk: AndroidManifest.xml $(FW_OBJ_DIR)/res.zip.stamp $(FW_OBJ_DIR)/R.java.stamp $(FW_OBJ_DIR)/classes.dex
	$(ECHO_PACKING)$(TARGET_APKBUILDER) $@ -u -z $(FW_OBJ_DIR)/res.zip -f $(FW_OBJ_DIR)/classes.dex$(ECHO_END)

$(FW_OBJ_DIR)/$(FW_INSTANCE).apk: $(TARGET_DEBUG_KEYSTORE) $(FW_OBJ_DIR)/$(FW_INSTANCE).unsigned.apk
	$(ECHO_SIGNING)$(TARGET_JARSIGNER) -keystore $(TARGET_DEBUG_KEYSTORE) -storepass android -keypass android -signedjar $(FW_OBJ_DIR)/$(FW_INSTANCE).unaligned.apk $(FW_OBJ_DIR)/$(FW_INSTANCE).unsigned.apk androiddebugkey$(ECHO_END)
	$(ECHO_ALIGNING)$(TARGET_ZIPALIGN) -f 4 $(FW_OBJ_DIR)/$(FW_INSTANCE).unaligned.apk $@$(ECHO_END)

internal-apk-stage_::
	$(ECHO_NOTHING)cp $(FW_OBJ_DIR)/$(FW_INSTANCE).apk "$(FW_STAGING_DIR)"$(ECHO_END)
