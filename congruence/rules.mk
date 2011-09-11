$(THEOS_OBJ_DIR)/%.nib: %.xib
	$(ECHO_COMPILING)xcrun -sdk iphoneos ibtool --compile "$@" "$<"$(ECHO_END)

$(THEOS_OBJ_DIR)/%.momd: %.xcdatamodeld
	$(ECHO_COMPILING)xcrun -sdk iphoneos momc -XD_MOMC_SDKROOT="$(SYSROOT)" -XD_MOMC_IOS_TARGET_VERSION=$(_THEOS_TARGET_SDK_VERSION) -MOMC_PLATFORMS iphoneos -XD_MOMC_TARGET_VERSION="10.6" "$(shell unset CDPATH; cd $(dir $<); pwd)/$(notdir $<)" "$(shell unset CDPATH; cd $(dir $@); pwd)/$(notdir $@)"$(ECHO_END)
