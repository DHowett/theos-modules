NIB_FILES = $(strip $(patsubst %.xib,%.nib,$($(THEOS_CURRENT_INSTANCE)_XIBS)))
NIB_FILES_TO_USE = $(strip $(addprefix $(THEOS_OBJ_DIR)/,$(NIB_FILES)))
_NIB_DIR_STAMPS = $(sort $(foreach o,$(filter $(THEOS_OBJ_DIR)%,$(NIB_FILES_TO_USE)),$(dir $o).stamp))

ifneq ($(NIB_FILES_TO_USE),)
after-$(THEOS_CURRENT_INSTANCE)-all:: $(_XIB_DIR_STAMPS) $(NIB_FILES_TO_USE)
after-$(THEOS_CURRENT_INSTANCE)-stage:: $(NIB_FILES_TO_USE)
	@cp $(NIB_FILES_TO_USE) $(THEOS_SHARED_BUNDLE_RESOURCE_PATH)/
endif
