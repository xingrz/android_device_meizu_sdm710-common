#
# Copyright (C) 2020 The MoKee Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

$(call inherit-product, vendor/meizu/sdm710-common/sdm710-common-vendor.mk)

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-mokee

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Properties
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/handheld_core_hardware.xml

# ANT+
PRODUCT_PACKAGES += \
    AntHalService

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    libaacwrapper \
    libaudioroute

# Display
PRODUCT_PACKAGES += \
    libdisplayconfig \
    libqdMetaData.system \
    libvulkan \
    vendor.display.config@1.0

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0

# Init
PRODUCT_PACKAGES += \
    init.qcom.rc

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.meizu_sdm710

# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/media_profiles_vendor.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/media_profiles_vendor.xml

# Net
PRODUCT_PACKAGES += \
    netutils-wrapper-1.0

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# VNDK-SP
PRODUCT_PACKAGES += \
    vndk-sp

PRODUCT_PACKAGES += \
    android.hardware.audio.common-util \
    android.hardware.audio.common@2.0-util \
    android.hardware.audio.effect@2.0 \
    android.hardware.audio@2.0 \
    android.hardware.biometrics.fingerprint@2.1 \
    android.hardware.soundtrigger@2.0 \
    android.hardware.usb@1.0 \
    android.hardware.wifi@1.0 \
    android.hardware.wifi@1.1

PRODUCT_COPY_FILES += \
    prebuilts/vndk/v27/arm64/arch-arm-armv7-a-neon/shared/vndk-core/android.hardware.audio.common@2.0-util.so:$(TARGET_COPY_OUT_SYSTEM)/lib/android.hardware.audio.common@2.0-util-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm-armv7-a-neon/shared/vndk-core/libstagefright_omx.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libstagefright_omx-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm-armv7-a-neon/shared/vndk-core/libstagefright_xmlparser.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libstagefright_xmlparser-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm-armv7-a-neon/shared/vndk-core/libui.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libui-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm-armv7-a-neon/shared/vndk-sp/libbase.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libbase-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm-armv7-a-neon/shared/vndk-sp/libhidlbase.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libhidlbase-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm-armv7-a-neon/shared/vndk-sp/libhidltransport.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libhidltransport-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm-armv7-a-neon/shared/vndk-sp/libutils.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libutils-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm-armv7-a-neon/shared/vndk-sp/libhwbinder.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libhwbinder-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm64-armv8-a/shared/vndk-core/android.hardware.gnss@1.0.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/android.hardware.gnss@1.0-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm64-armv8-a/shared/vndk-core/android.hardware.sensors@1.0.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/android.hardware.sensors@1.0-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm64-armv8-a/shared/vndk-core/android.hardware.wifi@1.0.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/android.hardware.wifi@1.0-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm64-armv8-a/shared/vndk-core/libstagefright_xmlparser.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libstagefright_xmlparser-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm64-armv8-a/shared/vndk-core/libtinyxml2.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libtinyxml2-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm64-armv8-a/shared/vndk-sp/libbase.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libbase-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm64-armv8-a/shared/vndk-sp/libcutils.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libcutils-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm64-armv8-a/shared/vndk-sp/libhidlbase.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libhidlbase-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm64-armv8-a/shared/vndk-sp/libhidltransport.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libhidltransport-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm64-armv8-a/shared/vndk-sp/libhwbinder.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libhwbinder-v27.so \
    prebuilts/vndk/v27/arm64/arch-arm64-armv8-a/shared/vndk-sp/libutils.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libutils-v27.so \
