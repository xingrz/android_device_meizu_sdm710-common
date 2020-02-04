#!/bin/bash
#
# Copyright (C) 2020 The MoKee Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

MOKEE_ROOT="${MY_DIR}/../../.."

HELPER="${MOKEE_ROOT}/vendor/mokee/build/tools/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

SRC=$1

# Initialize the helper
setup_vendor "${DEVICE_COMMON}" "${VENDOR}" "${MOKEE_ROOT}" true "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}"

if [ -f "${MY_DIR}/../${DEVICE}/proprietary-files.txt" ]; then
    # Reinitialize the helper for device
    setup_vendor "${DEVICE}" "${VENDOR}" "${MOKEE_ROOT}" false "${CLEAN_VENDOR}"

    extract "${MY_DIR}/../${DEVICE}/proprietary-files.txt" "${SRC}"
fi

"${MY_DIR}/setup-makefiles.sh"

BLOB_ROOT="${MOKEE_ROOT}/vendor/${VENDOR}/${DEVICE_COMMON}/proprietary"

# _ZN7android4base8EndsWithENSt3__117basic_string_viewIcNS1_11char_traitsIcEEEES5_
patchelf --add-needed libcutils-v27.so "${BLOB_ROOT}/bin/hw/android.hardware.wifi@1.0-service"
patchelf --add-needed libcutils-v27.so "${BLOB_ROOT}/bin/pm-service"
patchelf --add-needed libcutils-v27.so "${BLOB_ROOT}/bin/slim_daemon"

# _ZN7android4base10LogMessageC1EPKcjNS0_5LogIdENS0_11LogSeverityEi
# patchelf --replace-needed libbase.so libbase-v27.so "${BLOB_ROOT}/bin/hw/android.hardware.configstore@1.0-service"
patchelf --replace-needed libbase.so libbase-v27.so "${BLOB_ROOT}/bin/hw/android.hardware.drm@1.0-service.widevine"
patchelf --replace-needed libbase.so libbase-v27.so "${BLOB_ROOT}/bin/hw/android.hardware.graphics.composer@2.1-service"
patchelf --replace-needed libbase.so libbase-v27.so "${BLOB_ROOT}/bin/hw/android.hardware.wifi@1.0-service"
patchelf --replace-needed libbase.so libbase-v27.so "${BLOB_ROOT}/lib64/hw/android.hardware.bluetooth@1.0-impl-qti.so"
patchelf --replace-needed libbase.so libbase-v27.so "${BLOB_ROOT}/lib64/hw/android.hardware.graphics.composer@2.1-impl.so"
patchelf --replace-needed libbase.so libbase-v27.so "${BLOB_ROOT}/lib64/hw/android.hardware.sensors@1.0-impl.so"
patchelf --replace-needed libbase.so libbase-v27.so "${BLOB_ROOT}/lib64/hw/vendor.qti.hardware.sensorscalibrate@1.0-impl.so"
patchelf --replace-needed libbase.so libbase-v27.so "${BLOB_ROOT}/lib64/libhwminijail.so"
patchelf --replace-needed libbase.so libbase-v27.so "${BLOB_ROOT}/lib64/libsensorndkbridge.so"

# _ZN7android4base10LogMessageC1EPKcjNS0_5LogIdENS0_11LogSeverityES3_i
# patchelf --replace-needed libhidlbase.so libhidlbase-v27.so "${BLOB_ROOT}/bin/hw/android.hardware.configstore@1.0-service"
patchelf --add-needed libhidlbase-v27.so "${BLOB_ROOT}/bin/hw/android.hardware.drm@1.0-service.widevine"
patchelf --add-needed libhidlbase-v27.so "${BLOB_ROOT}/bin/hw/android.hardware.graphics.composer@2.1-service"
patchelf --add-needed libhidlbase-v27.so "${BLOB_ROOT}/bin/hw/android.hardware.wifi@1.0-service"

# _ZN7android8hardware4gnss4V1_08toStringINS2_15IGnssNiCallback17GnssNiNotifyFlagsEEENSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEj
patchelf --replace-needed android.hardware.gnss@1.0.so android.hardware.gnss@1.0-v27.so "${BLOB_ROOT}/lib64/vendor.qti.gnss@1.0_vendor.so"

# _ZN7android8hardware4wifi4V1_08toStringERKNS_2spINS2_22IWifiChipEventCallbackEEE
patchelf --replace-needed android.hardware.wifi@1.0.so android.hardware.wifi@1.0-v27.so "${BLOB_ROOT}/bin/hw/android.hardware.wifi@1.0-service"

# _ZN7android8hardware5media3omx4V1_014implementation8OmxStoreC1EPKcPKS7_S7_S7_S7_
patchelf --replace-needed libstagefright_omx.so libstagefright_omx-v27.so "${BLOB_ROOT}/bin/hw/android.hardware.media.omx@1.0-service"

# _ZN7android8hardware7sensors4V1_0eqERKNS2_10SensorInfoES5_
patchelf --replace-needed android.hardware.sensors@1.0.so android.hardware.sensors@1.0-v27.so "${BLOB_ROOT}/lib64/libsensorndkbridge.so"

# _ZN7android8hardware10IInterfaceD0Ev
patchelf --add-needed libhwbinder-v27.so "${BLOB_ROOT}/bin/hw/android.hardware.drm@1.0-service.widevine"
patchelf --add-needed libhwbinder-v27.so "${BLOB_ROOT}/bin/hw/android.hardware.graphics.composer@2.1-service"

# _ZN7android4base10LogMessageC1EPKcjNS0_5LogIdENS0_11LogSeverityEi
# _ZN7android4hidl4base4V1_05IBase11linkToDeathERKNS_2spINS_8hardware20hidl_death_recipientEEEm
# _ZN7android8hardware22configureRpcThreadpoolEjb
# _ZN7android8hardware22configureRpcThreadpoolEmb
patchelf --add-needed libhidltransport-v27.so "${BLOB_ROOT}/bin/hw/android.hardware.drm@1.0-service.widevine"
patchelf --add-needed libhidltransport-v27.so "${BLOB_ROOT}/bin/hw/android.hardware.graphics.composer@2.1-service"
patchelf --add-needed libhidltransport-v27.so "${BLOB_ROOT}/bin/hw/android.hardware.wifi@1.0-service"

# _ZN7android9HidlUtils16audioConfigToHalERKNS_8hardware5audio6common4V2_011AudioConfigEP12audio_config
patchelf --replace-needed android.hardware.audio.common@2.0-util.so android.hardware.audio.common@2.0-util-v27.so "${BLOB_ROOT}/lib/hw/android.hardware.audio@2.0-impl.so"

# _ZN7android9CallStackC1EPKci
patchelf --replace-needed libutils.so libutils-v27.so "${BLOB_ROOT}/bin/pm-service"
patchelf --replace-needed libutils.so libutils-v27.so "${BLOB_ROOT}/lib/libmms_hal_vstab.so"

# _ZN7android13GraphicBuffer4lockEjPPv
patchelf --replace-needed libui.so libui-v27.so "${BLOB_ROOT}/lib/libmms_hal_vstab.so"

# _ZN7android20MediaCodecsXmlParser17defaultSearchDirsE
patchelf --replace-needed libstagefright_xmlparser.so libstagefright_xmlparser-v27.so "${BLOB_ROOT}/bin/hw/android.hardware.media.omx@1.0-service"

# _ZN8tinyxml211XMLDocumentC1Eb
patchelf --replace-needed libtinyxml2.so libtinyxml2-v27.so "${BLOB_ROOT}/bin/mm-pp-dpps"
