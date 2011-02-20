APK_NAME := $(strip $(APK_NAME))

ifeq ($(_THEOS_RULES_LOADED),)
include $(THEOS_MAKE_PATH)/rules.mk
endif

internal-all:: $(APK_NAME:=.all.apk.variables);

internal-stage:: $(APK_NAME:=.stage.apk.variables);

internal-after-install::

$(APK_NAME):
	@$(MAKE) --no-print-directory --no-keep-going $@.all.apk.variables
