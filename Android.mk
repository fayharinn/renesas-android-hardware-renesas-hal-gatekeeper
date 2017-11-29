#
# Copyright (C) 2017 GlobalLogic
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

# Include only for Renesas ones.
ifneq (,$(filter $(TARGET_PRODUCT), salvator ulcb kingfisher))
LOCAL_PATH:= $(call my-dir)

################################################################################
# Build gatekeeper HAL                                                         #
################################################################################
include $(CLEAR_VARS)

LOCAL_MODULE := android.hardware.gatekeeper@1.0-service.renesas
LOCAL_INIT_RC := android.hardware.gatekeeper@1.0-service.renesas.rc
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MODULE_TAGS := optional
LOCAL_VENDOR_MODULE := true

LOCAL_CFLAGS = -Wall -Werror
LOCAL_CFLAGS += -DANDROID_BUILD

LOCAL_SRC_FILES := \
	service.cpp \
	optee_gatekeeper_device.cpp \
	optee_ipc.cpp

LOCAL_C_INCLUDES := \
	hardware/renesas/optee-client/public \
	$(LOCAL_PATH)/ta/include

LOCAL_SHARED_LIBRARIES := \
	liblog \
	libcutils \
	libteec \
	libhardware \
	libhidlbase \
	libhidltransport \
	libutils \
	android.hardware.gatekeeper@1.0

LOCAL_MULTILIB := 64

include $(BUILD_EXECUTABLE)

################################################################################
# Build gatekeeper HAL TA                                                      #
################################################################################
include $(TARGET_DEVICE_DIR)/build/ta_clear_vars.mk

# Please keep this variable consistent with TA_GATEKEEPER_UUID define that
# defined in gatekeeper_ipc.h file
TA_UUID:=4d573443-6a56-4272-ac6f2425af9ef9bb
TA_SRC:=$(LOCAL_PATH)/ta

include $(TARGET_DEVICE_DIR)/build/ta_build_executable.mk
endif # Include only for Renesas ones.
