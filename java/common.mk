FW_CLASSES_DIR_NAME = classes
FW_CLASSES_DIR = $(FW_OBJ_DIR)/$(FW_CLASSES_DIR_NAME)

ifneq ($(messages),yes)
	ECHO_RESOURCES = @(echo " Processing Resources...";
	ECHO_RJAVA = @(echo " Compiling R.java...";
	ECHO_DEXING = @(echo " Converting to Dalvik bytecode...";
	ECHO_PACKING = @(echo " Packing $(FW_INSTANCE)...";
	ECHO_ALIGNING = @(echo " Aligning $(FW_INSTANCE)...";
else
	ECHO_RESOURCES =
	ECHO_RJAVA =
	ECHO_DEXING =
	ECHO_PACKING =
	ECHO_ALIGNING =
endif
