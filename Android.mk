# external/alsa-lib/Android.mk
#
# Copyright 2008 Wind River Systems
#

ifeq ($(BOARD_USES_ALSA_AUDIO),true)

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

##
## Copy ALSA configuration files to rootfs
##
TARGET_ALSA_CONF_DIR := $(TARGET_OUT)/usr/share/alsa
LOCAL_ALSA_CONF_DIR  := $(LOCAL_PATH)/src/conf

copy_from := \
	alsa.conf \
	pcm/dsnoop.conf \
	pcm/modem.conf \
	pcm/dpl.conf \
	pcm/default.conf \
	pcm/surround51.conf \
	pcm/surround41.conf \
	pcm/surround50.conf \
	pcm/dmix.conf \
	pcm/center_lfe.conf \
	pcm/surround40.conf \
	pcm/side.conf \
	pcm/iec958.conf \
	pcm/rear.conf \
	pcm/surround71.conf \
	pcm/front.conf \
	cards/aliases.conf

copy_to   := $(addprefix $(TARGET_ALSA_CONF_DIR)/,$(copy_from))
copy_from := $(addprefix $(LOCAL_ALSA_CONF_DIR)/,$(copy_from))

$(copy_to) : $(TARGET_ALSA_CONF_DIR)/% : $(LOCAL_ALSA_CONF_DIR)/% | $(ACP)
	$(transform-prebuilt-to-target)

ALL_PREBUILT += $(copy_to)

include $(CLEAR_VARS)

LOCAL_MODULE := libasound

LOCAL_ARM_MODE := arm

LOCAL_C_INCLUDES += $(LOCAL_PATH)/include

# libasound must be compiled with -fno-short-enums, as it makes extensive
# use of enums which are often type casted to unsigned ints.
LOCAL_CFLAGS := \
	-fno-short-enums -fPIC \
	-DALSA_CONFIG_DIR=\"/system/usr/share/alsa\" \
	-DALSA_PLUGIN_DIR=\"/system/usr/lib/alsa-lib\" \
	-DALSA_DEVICE_DIRECTORY=\"/dev/snd/\"

LOCAL_SRC_FILES := $(addprefix src/, \
	conf.c \
	confmisc.c \
	input.c \
	output.c \
	async.c \
	error.c \
	dlmisc.c \
	socket.c \
	shmarea.c \
	userfile.c \
	names.c \
	hwdep/hwdep.c \
	hwdep/hwdep_hw.c \
	hwdep/hwdep_symbols.c \
	mixer/bag.c \
	mixer/mixer.c \
	mixer/simple.c \
	mixer/simple_abst.c \
	mixer/simple_none.c \
	pcm/atomic.c \
	pcm/mask.c \
	pcm/interval.c \
	pcm/pcm.c \
	pcm/pcm_params.c \
	pcm/pcm_simple.c \
	pcm/pcm_hw.c \
	pcm/pcm_misc.c \
	pcm/pcm_mmap.c \
	pcm/pcm_symbols.c \
	pcm/pcm_generic.c \
	pcm/pcm_plugin.c \
	pcm/pcm_copy.c \
	pcm/pcm_linear.c \
	pcm/pcm_plug.c \
	pcm/pcm_null.c \
	pcm/pcm_empty.c \
	pcm/pcm_hooks.c \
	pcm/pcm_asym.c \
	pcm/pcm_extplug.c \
	pcm/pcm_ioplug.c \
	control/cards.c \
	control/tlv.c \
	control/namehint.c \
	control/hcontrol.c \
	control/control.c \
	control/control_hw.c \
	control/setup.c \
	control/control_symbols.c \
	control/control_ext.c \
	timer/timer.c \
	timer/timer_hw.c \
	timer/timer_query.c \
	timer/timer_query_hw.c \
	timer/timer_symbols.c \
	)

include $(BUILD_STATIC_LIBRARY)

endif

