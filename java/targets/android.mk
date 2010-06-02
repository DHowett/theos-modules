ifeq ($(FW_TARGET_LOADED),)
FW_TARGET_LOADED := 1
FW_TARGET_NAME := android

SDK_ROOT ?= /opt/android-sdk
SDKVERSION ?= 7
PLATFORM_ROOT ?= $(SDK_ROOT)/platforms/android-$(SDKVERSION)
BOOTCLASSPATH = $(PLATFORM_ROOT)/android.jar

TARGET_JAVAC ?= javac
TARGET_JAVAC_ARGS ?= -bootclasspath $(BOOTCLASSPATH)
TARGET_JARSIGNER ?= jarsigner
TARGET_KEYTOOL ?= keytool
TARGET_AAPT ?= $(PLATFORM_ROOT)/tools/aapt
TARGET_DX ?= $(PLATFORM_ROOT)/tools/dx
TARGET_APKBUILDER ?= $(SDK_ROOT)/tools/apkbuilder
TARGET_ZIPALIGN ?= $(SDK_ROOT)/tools/zipalign

TARGET_DEBUG_KEYSTORE_DIR ?= $(HOME)/.android
TARGET_DEBUG_KEYSTORE ?= $(TARGET_DEBUG_KEYSTORE_DIR)/debug.keystore

all::

$(TARGET_DEBUG_KEYSTORE_DIR):
	@mkdir -p $@

$(TARGET_DEBUG_KEYSTORE): $(TARGET_DEBUG_KEYSTORE_DIR)
	$(ECHO_NOTHING)$(TARGET_KEYTOOL) -genkeypair -dname "CN=Android Debug,O=Android,C=US" -validity 365 -alias "androiddebugkey" -keypass "android" -keystore $@ -storepass "android"$(ECHO_END)

endif
