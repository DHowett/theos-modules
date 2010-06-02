ifeq ($(FW_INSTANCE),)
	include $(FW_MODDIR)/java/master/apk.mk
else
	ifeq ($(FW_TYPE),apk)
		include $(FW_MODDIR)/java/instance/apk.mk
	endif
endif
