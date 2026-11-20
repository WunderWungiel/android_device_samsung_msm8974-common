# Copyright (C) 2012 The CyanogenMod Project
# Copyright (C) 2017-2021 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    device/samsung/msm8974-common/overlay \
    device/samsung/msm8974-common/overlay-lineage

# APEX
# The 3.4 kernel's dm-verity cannot parse the optional args apexd uses,
# so ship uncompressed APEXes: pre-installed ones on /system skip dm-verity.
# updatable_apex.mk sets PRODUCT_COMPRESSED_APEX := true and wins over
# inheriting makefiles; product_config.mk applies this override afterwards.
OVERRIDE_PRODUCT_COMPRESSED_APEX := false

# ART
# No userfaultfd on 3.4; without a kernel version the build assumes it exists.
PRODUCT_ENABLE_UFFD_GC := false

# USB
# Enable adb from init on debuggable builds instead of waiting for
# system_server's UsbDeviceManager (needed to debug early boot).
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.usb.config=adb
endif

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.consumerir.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.consumerir.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml

# Advanced Display
PRODUCT_PACKAGES += \
    AdvancedDisplay

# APEX
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/ld.config.txt:$(TARGET_COPY_OUT_SYSTEM)/etc/swcodec/ld.config.txt

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@7.0-impl \
    android.hardware.audio.effect@7.0-impl \
    android.hardware.audio.service.hlte \
    android.hardware.bluetooth.audio@2.0-impl \
    audio.bluetooth.default \
    audio.primary.msm8974 \
    audio.r_submix.default \
    audio.usb.default \
    libaudio-resampler \
    libqcomvisualizer \
    libqcompostprocbundle \
    libqcomvoiceprocessing

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.bluetooth@1.0-service \
    libbt-vendor

# Boot animation
TARGET_BOOTANIMATION_HALF_RES := true

# ConfigStore
# base_vendor.mk installs the HIDL configstore service for shipping API <= 29, but it is not in
# our VINTF manifest, so it aborts every 5 s. disable_configstore overrides it and installs nothing.
PRODUCT_PACKAGES += \
    disable_configstore

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.mapper@2.0-impl-2.1 \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service \
    copybit.msm8974 \
    gralloc.msm8974 \
    hwcomposer.msm8974 \
    memtrack.msm8974

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    camera.device@1.0-impl \
    camera.msm8974 \
    libxml2

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl \
    android.hardware.drm@1.0-service

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service.software

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-impl \
    android.hardware.gnss@1.0-service \
    gps.msm8974

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/gps/etc/flp.conf:system/etc/flp.conf \
    $(LOCAL_PATH)/gps/etc/gps.conf:system/etc/gps.conf \
    $(LOCAL_PATH)/gps/etc/izat.conf:system/etc/izat.conf \
    $(LOCAL_PATH)/gps/etc/sap.conf:system/etc/sap.conf

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# HIDL
PRODUCT_ENFORCE_VINTF_MANIFEST_OVERRIDE := true

# IR Blaster
PRODUCT_PACKAGES += \
    android.hardware.ir@1.0-service.samsung

# Keylayouts
PRODUCT_COPY_FILES += \
    device/samsung/msm8974-common/keylayout/Vendor_04e8_Product_7021.kl:system/usr/keylayout/Vendor_04e8_Product_7021.kl

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light-service.samsung

# LiveDisplay
PRODUCT_PACKAGES += \
    vendor.lineage.livedisplay@2.0-service.samsung-qcom

# Media
PRODUCT_COPY_FILES += \
    device/samsung/msm8974-common/configs/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml

# OMX
PRODUCT_PROPERTY_OVERRIDES += \
    media.stagefright.legacyencoder=true \
    media.stagefright.less-secure=true \
    debug.stagefright.omx_default_rank=0 \
    vendor.mediacodec.binder.size=4 \
    media.stagefright.thumbnail.prefer_hw_codecs=true

# OMX
PRODUCT_PACKAGES += \
    libc2dcolorconvert \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxCore \
    libOmxEvrcEnc \
    libOmxQcelp13Enc \
    libOmxVdec \
    libOmxVenc \
    libstagefrighthw

# Power HAL
PRODUCT_PACKAGES += \
    android.hardware.power-service-qti

# RenderScript HAL
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-impl

# Seccomp
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/seccomp/mediacodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-impl.samsung8974 \
    android.hardware.sensors@1.0-service.samsung8974

# Soong Namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(COMMON_PATH) \
    $(DEVICE_PATH) \
    device/samsung/msm8974-common \
    device/samsung/qcom-common \
    hardware/samsung
    
# TimeKeep
PRODUCT_PACKAGES += \
    timekeep \
    TimeKeep

# Touch features
PRODUCT_PACKAGES += \
    vendor.lineage.touch-service.samsung

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.3-service.basic

# VNDK
PRODUCT_PACKAGES += \
    libcutils-v29.vendor \
    libprotobuf-cpp-lite-v29

# Wifi
PRODUCT_PACKAGES += \
    android.hardware.wifi-service \
    hostapd \
    wificond \
    wpa_supplicant \
    wpa_supplicant.conf \
    android.hardware.wifi.supplicant-V1-ndk \
    android.hardware.wifi.hostapd-V1-ndk

# Get non-open-source specific aspects
$(call inherit-product, vendor/samsung/msm8974-common/msm8974-common-vendor.mk)

# common msm8974
$(call inherit-product, device/samsung/qcom-common/qcom-common.mk)
