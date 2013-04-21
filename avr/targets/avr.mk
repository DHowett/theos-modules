ifeq ($(_THEOS_TARGET_LOADED),)
_THEOS_TARGET_LOADED := 1
THEOS_TARGET_NAME := avr

_THEOS_TARGET_AVR_MCU := $(__THEOS_TARGET_ARG_1)
_THEOS_TARGET_AVR_HZ := $(__THEOS_TARGET_ARG_2)
ifeq ($(_THEOS_TARGET_AVR_MCU),)
$(error AVR MCU not specified as arg1 in $$(TARGET))
endif
ifeq ($(_THEOS_TARGET_AVR_HZ),)
$(error AVR speed in hZ not specified as arg2 in $$(TARGET))
endif

TARGET_CC ?= avr-gcc
TARGET_CXX ?= avr-g++
TARGET_LD ?= avr-g++
TARGET_OBJCOPY ?= avr-objcopy
TARGET_STRIP ?= avr-strip
TARGET_STRIP_FLAGS ?= 
TARGET_CODESIGN_ALLOCATE ?= ""
override TARGET_CODESIGN :=
TARGET_CODESIGN_FLAGS ?= 

_THEOS_TARGET_CFLAGS := -DF_CPU=$(_THEOS_TARGET_AVR_HZ)L -Os -ffunction-sections -fdata-sections -mmcu=$(_THEOS_TARGET_AVR_MCU) -DARDUINO=103 #-I$(THEOS_ARDUINO_CORE_PATH) -include $(THEOS_ARDUINO_CORE_PATH)/WProgram.h
_THEOS_TARGET_CCFLAGS := -std=c++0x -felide-constructors -fno-exceptions -fno-rtti
_THEOS_TARGET_LDFLAGS := -fdata-sections -ffunction-sections -Os -mmcu=$(_THEOS_TARGET_AVR_MCU)
_THEOS_TARGET_EEPROM_OBJCOPYFLAGS := -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0
_THEOS_TARGET_OBJCOPYFLAGS := -R .eeprom
endif
