#!/bin/bash
#
# Copyright (C) 2020 The MoKee Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

INITIAL_COPYRIGHT_YEAR=2020

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

# Initialize the helper
setup_vendor "${DEVICE_COMMON}" "${VENDOR}" "${MOKEE_ROOT}" true

# Copyright headers and guards
write_headers "m1852 m1872"

write_makefiles "${MY_DIR}/proprietary-files.txt"

# Finish
write_footers

if [ -f "${MY_DIR}/../${DEVICE}/proprietary-files.txt" ]; then
    # Reinitialize the helper for device
    INITIAL_COPYRIGHT_YEAR="${DEVICE_BRINGUP_YEAR}"
    setup_vendor "${DEVICE}" "${VENDOR}" "${MOKEE_ROOT}" false

    # Copyright headers and guards
    write_headers

    # The standard device blobs
    write_makefiles "${MY_DIR}/../${DEVICE}/proprietary-files.txt"

    # Finish
    write_footers
fi
