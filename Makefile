TARGET := iphone:clang:latest:14.0
ARCHS := arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME := CopsModMenu

CopsModMenu_FILES := Tweak.mm
CopsModMenu_CFLAGS := -fobjc-arc
CopsModMenu_LDFLAGS := -fuse-ld=lld
CopsModMenu_FRAMEWORKS := UIKit Foundation CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk
