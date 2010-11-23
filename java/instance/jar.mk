ifeq ($(FW_RULES_LOADED),)
include $(FW_MAKEDIR)/rules.mk
endif
.PHONY: internal-jar-all_ internal-jar-stage_ internal-jar-compile

ifeq ($(FW_MAKE_PARALLEL_BUILDING), no)
internal-jar-all_:: $(FW_CLASSES_DIR) $(FW_OBJ_DIR)/$(FW_INSTANCE).jar
else
internal-jar-all_:: $(FW_CLASSES_DIR)
	$(ECHO_NOTHING)$(MAKE) --no-print-directory --no-keep-going \
		internal-jar-compile \
		FW_TYPE=$(FW_TYPE) FW_INSTANCE=$(FW_INSTANCE) FW_OPERATION=compile \
		FW_BUILD_DIR="$(FW_BUILD_DIR)" _FW_MAKE_PARALLEL=yes$(ECHO_END)

internal-jar-compile: $(FW_OBJ_DIR)/$(FW_INSTANCE).jar
endif

# $(FW_OBJ_DIR)/$(FW_INSTANCE).manifest
$(FW_OBJ_DIR)/$(FW_INSTANCE).jar: $(OBJ_FILES_TO_LINK)
	@(echo " Jarring $(FW_INSTANCE).jar..."; jar cfe $@ $($(FW_INSTANCE)_MAIN_CLASS) -C $(FW_CLASSES_DIR) .)

internal-jar-stage_::
	$(ECHO_NOTHING)cp $(FW_OBJ_DIR)/$(FW_INSTANCE).jar "$(FW_STAGING_DIR)"$(ECHO_END)
