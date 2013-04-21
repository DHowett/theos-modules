FIRMWARE_NAME := $(strip $(FIRMWARE_NAME))

ifeq ($(_THEOS_RULES_LOADED),)
include $(THEOS_MAKE_PATH)/rules.mk
endif

internal-all:: $(FIRMWARE_NAME:=.all.firmware.variables);

internal-stage:: $(FIRMWARE_NAME:=.stage.firmware.variables);

FIRMWARES_WITH_SUBPROJECTS = $(strip $(foreach firmware,$(FIRMWARE_NAME),$(patsubst %,$(firmware),$(call __schema_var_all,$(firmware)_,SUBPROJECTS))))
ifneq ($(FIRMWARES_WITH_SUBPROJECTS),)
internal-clean:: $(FIRMWARES_WITH_SUBPROJECTS:=.clean.firmware.subprojects)
endif

$(FIRMWARE_NAME):
	@$(MAKE) -f $(_THEOS_PROJECT_MAKEFILE_NAME) $(_THEOS_NO_PRINT_DIRECTORY_FLAG) --no-keep-going $@.all.firmware.variables
