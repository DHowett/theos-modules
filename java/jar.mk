ifeq ($(FW_INSTANCE),)
	include $(FW_MODDIR)/java/master/jar.mk
else
	ifeq ($(FW_TYPE),jar)
		include $(FW_MODDIR)/java/instance/jar.mk
	endif
endif
