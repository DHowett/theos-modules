ifeq ($(THEOS_CURRENT_INSTANCE),)
	include $(THEOS_MODULE_PATH)/java/master/jar.mk
else
	ifeq ($(_THEOS_CURRENT_TYPE),jar)
		include $(THEOS_MODULE_PATH)/java/instance/jar.mk
	endif
endif
