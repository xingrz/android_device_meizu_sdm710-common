#
# Copyright (C) 2020 The MoKee Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
# We don't actually build vendor, but mm-core and mm-video-v4l2 depends
# on this shared vendor lib.
LOCAL_MODULE := libplatformconfig
LOCAL_SRC_FILES_64 := /dev/null
LOCAL_SRC_FILES_32 := /dev/null
LOCAL_MULTILIB := both
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_VENDOR_MODULE := true
include $(BUILD_PREBUILT)
