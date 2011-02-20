ifeq ($(THEOS_CURRENT_INSTANCE),)
	include $(THEOS_MODULE_PATH)/java/master/apk.mk
else
	ifeq ($(_THEOS_CURRENT_TYPE),apk)
		include $(THEOS_MODULE_PATH)/java/instance/apk.mk
	endif
endif
