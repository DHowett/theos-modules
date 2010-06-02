.SUFFIXES: .java

$(FW_OBJ_DIR)/%.java.stamp: %.java
	@touch $@
	$(ECHO_COMPILING)$(TARGET_JAVAC) $(TARGET_JAVAC_ARGS) -d $(FW_CLASSES_DIR)/ $^$(ECHO_END)

$(FW_CLASSES_DIR): $(FW_OBJ_DIR)
	@cd $(FW_OBJ_DIR); mkdir -p $(FW_CLASSES_DIR_NAME)
