APK_NAME := $(strip $(APK_NAME))

ifeq ($(FW_RULES_LOADED),)
include $(FW_MAKEDIR)/rules.mk
endif

internal-all:: $(APK_NAME:=.all.apk.variables);

internal-stage:: $(APK_NAME:=.stage.apk.variables);

internal-after-install::

$(APK_NAME):
	@$(MAKE) --no-print-directory --no-keep-going $@.all.apk.variables
