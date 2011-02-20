JAR_NAME := $(strip $(JAR_NAME))

ifeq ($(_THEOS_RULES_LOADED),)
include $(THEOS_MAKE_PATH)/rules.mk
endif

internal-all:: $(JAR_NAME:=.all.jar.variables);

internal-stage:: $(JAR_NAME:=.stage.jar.variables);

internal-after-install::

$(JAR_NAME):
	@$(MAKE) --no-print-directory --no-keep-going $@.all.jar.variables
