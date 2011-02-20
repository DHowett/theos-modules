ifeq ($(_THEOS_RULES_LOADED),)
include $(THEOS_MAKE_PATH)/rules.mk
endif
.PHONY: internal-apk-all_ internal-apk-stage_ internal-apk-compile

ifeq ($(_THEOS_MAKE_PARALLEL_BUILDING), no)
internal-apk-all_:: $(THEOS_OBJ_DIR) $(THEOS_CLASSES_DIR) $(THEOS_OBJ_DIR)/$(THEOS_CURRENT_INSTANCE).apk
else
internal-apk-all_:: $(THEOS_OBJ_DIR) $(THEOS_CLASSES_DIR)
	$(ECHO_NOTHING)$(MAKE) --no-print-directory --no-keep-going \
		internal-apk-compile \
		_THEOS_CURRENT_TYPE=$(_THEOS_CURRENT_TYPE) THEOS_CURRENT_INSTANCE=$(THEOS_CURRENT_INSTANCE) _THEOS_CURRENT_OPERATION=compile \
		THEOS_BUILD_DIR="$(THEOS_BUILD_DIR)" _THEOS_MAKE_PARALLEL=yes$(ECHO_END)

internal-apk-compile: $(THEOS_OBJ_DIR)/$(THEOS_CURRENT_INSTANCE).apk
endif

# $(THEOS_OBJ_DIR)/$(THEOS_CURRENT_INSTANCE).manifest
$(THEOS_OBJ_DIR)/res.zip.stamp: res
	@touch $@
	$(ECHO_RESOURCES)$(TARGET_AAPT) package -f -M AndroidManifest.xml -F $(THEOS_OBJ_DIR)/res.zip -I $(BOOTCLASSPATH) -S res -J $(THEOS_OBJ_DIR)$(ECHO_END)

$(THEOS_OBJ_DIR)/R.java.stamp: $(THEOS_OBJ_DIR)/res.zip.stamp
	@touch $@
	$(ECHO_RJAVA)$(TARGET_JAVAC) $(TARGET_JAVAC_ARGS) -d $(THEOS_CLASSES_DIR)/ $(THEOS_OBJ_DIR)/R.java$(ECHO_END)

$(THEOS_OBJ_DIR)/classes.dex: $(OBJ_FILES_TO_LINK)
	$(ECHO_DEXING)$(TARGET_DX) --dex --output=$@ $(THEOS_CLASSES_DIR)$(ECHO_END)

$(THEOS_OBJ_DIR)/$(THEOS_CURRENT_INSTANCE).unsigned.apk: AndroidManifest.xml $(THEOS_OBJ_DIR)/res.zip.stamp $(THEOS_OBJ_DIR)/R.java.stamp $(THEOS_OBJ_DIR)/classes.dex
	$(ECHO_PACKING)$(TARGET_APKBUILDER) $@ -u -z $(THEOS_OBJ_DIR)/res.zip -f $(THEOS_OBJ_DIR)/classes.dex$(ECHO_END)

$(THEOS_OBJ_DIR)/$(THEOS_CURRENT_INSTANCE).apk: $(TARGET_DEBUG_KEYSTORE) $(THEOS_OBJ_DIR)/$(THEOS_CURRENT_INSTANCE).unsigned.apk
	$(ECHO_SIGNING)$(TARGET_JARSIGNER) -keystore $(TARGET_DEBUG_KEYSTORE) -storepass android -keypass android -signedjar $(THEOS_OBJ_DIR)/$(THEOS_CURRENT_INSTANCE).unaligned.apk $(THEOS_OBJ_DIR)/$(THEOS_CURRENT_INSTANCE).unsigned.apk androiddebugkey$(ECHO_END)
	$(ECHO_ALIGNING)$(TARGET_ZIPALIGN) -f 4 $(THEOS_OBJ_DIR)/$(THEOS_CURRENT_INSTANCE).unaligned.apk $@$(ECHO_END)

internal-apk-stage_::
	$(ECHO_NOTHING)cp $(THEOS_OBJ_DIR)/$(THEOS_CURRENT_INSTANCE).apk "$(THEOS_STAGING_DIR)"$(ECHO_END)
