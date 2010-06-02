JAVA_CLASSES = $(patsubst %.java,$(FW_OBJ_DIR)/%.java.stamp,$($(FW_INSTANCE)_JAVA_FILES))
OBJ_FILES_TO_LINK += $(JAVA_CLASSES)
