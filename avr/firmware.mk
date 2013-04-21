ifeq ($(THEOS_CURRENT_INSTANCE),)
	include $(THEOS_MODULE_PATH)/avr/master/firmware.mk
else
	ifeq ($(_THEOS_CURRENT_TYPE),firmware)
		include $(THEOS_MODULE_PATH)/avr/instance/firmware.mk
	endif
endif
