$(THEOS_OBJ_DIR)/%.nib: %.xib
	$(ECHO_COMPILING)ibtool --compile $@ $<$(ECHO_END)
