THEOS_CLASSES_DIR_NAME = classes
THEOS_CLASSES_DIR = $(THEOS_OBJ_DIR)/$(THEOS_CLASSES_DIR_NAME)

ifneq ($(messages),yes)
	ECHO_JARRING = @(echo " Jarring $(THEOS_CURRENT_INSTANCE)...";
	ECHO_RESOURCES = @(echo " Processing Resources...";
	ECHO_RJAVA = @(echo " Compiling R.java...";
	ECHO_DEXING = @(echo " Converting to Dalvik bytecode...";
	ECHO_PACKING = @(echo " Packing $(THEOS_CURRENT_INSTANCE)...";
	ECHO_ALIGNING = @(echo " Aligning $(THEOS_CURRENT_INSTANCE)...";
else
	ECHO_JARRING =
	ECHO_RESOURCES =
	ECHO_RJAVA =
	ECHO_DEXING =
	ECHO_PACKING =
	ECHO_ALIGNING =
endif
