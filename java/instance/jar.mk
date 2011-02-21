ifeq ($(_THEOS_RULES_LOADED),)
include $(THEOS_MAKE_PATH)/rules.mk
endif
.PHONY: internal-jar-all_ internal-jar-stage_ internal-jar-compile

ifeq ($(_THEOS_MAKE_PARALLEL_BUILDING), no)
internal-jar-all_:: $(_OBJ_DIR_STAMPS) $(THEOS_CLASSES_DIR) $(THEOS_OBJ_DIR)/$(THEOS_CURRENT_INSTANCE).jar
else
internal-jar-all_:: $(_OBJ_DIR_STAMPS) $(THEOS_CLASSES_DIR)
	$(ECHO_NOTHING)$(MAKE) --no-print-directory --no-keep-going \
		internal-jar-compile \
		_THEOS_CURRENT_TYPE=$(_THEOS_CURRENT_TYPE) THEOS_CURRENT_INSTANCE=$(THEOS_CURRENT_INSTANCE) _THEOS_CURRENT_OPERATION=compile \
		THEOS_BUILD_DIR="$(THEOS_BUILD_DIR)" _THEOS_MAKE_PARALLEL=yes$(ECHO_END)

internal-jar-compile: $(THEOS_OBJ_DIR)/$(THEOS_CURRENT_INSTANCE).jar
endif

_RESOURCE_DIRS := $(or $($(THEOS_CURRENT_INSTANCE)_JAR_RESOURCE_DIRS),$($(THEOS_CURRENT_INSTANCE)_RESOURCE_DIRS))

_MAIN_CLASS=$(or $($(THEOS_CURRENT_INSTANCE)_MAIN_CLASS),$(patsubst %.java,%,$(firstword $($(THEOS_CURRENT_INSTANCE)_FILES))))

# $(THEOS_OBJ_DIR)/$(THEOS_CURRENT_INSTANCE).manifest
$(THEOS_OBJ_DIR)/$(THEOS_CURRENT_INSTANCE).jar: $(OBJ_FILES_TO_LINK)
	$(ECHO_JARRING)jar cfe $@ $(_MAIN_CLASS) -C $(THEOS_CLASSES_DIR) .$(ECHO_END)
ifneq ($(_RESOURCE_DIRS),)
	$(ECHO_COPYING_RESOURCE_DIRS)for d in $(_RESOURCE_DIRS); do \
		if [ -d "$$d" ]; then \
			( cd $$d; jar uf ../$@ .; ); \
		else \
			echo "Warning: ignoring missing bundle resource directory $$d."; \
		fi; \
	done$(ECHO_END)
endif


internal-jar-stage_::
	$(ECHO_NOTHING)cp $(THEOS_OBJ_DIR)/$(THEOS_CURRENT_INSTANCE).jar "$(THEOS_STAGING_DIR)"$(ECHO_END)
