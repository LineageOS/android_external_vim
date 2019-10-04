vim_src := $(call my-dir)

# ========================================================
# etc/vimrc
# ========================================================

LOCAL_PATH := $(vim_src)
include $(CLEAR_VARS)

LOCAL_MODULE := vimrc
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC

LOCAL_SRC_FILES := vimrc.android

include $(BUILD_PREBUILT)

# ========================================================
# vim
# ========================================================

LOCAL_PATH := $(vim_src)/src
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	auto/pathdef.c \
	autocmd.c \
	blob.c \
	blowfish.c \
	buffer.c \
	change.c \
	channel.c \
	charset.c \
	debugger.c \
	dict.c \
	diff.c \
	digraph.c \
	edit.c \
	eval.c \
	evalfunc.c \
	ex_cmds.c \
	ex_cmds2.c \
	ex_docmd.c \
	ex_eval.c \
	ex_getln.c \
	fileio.c \
	findfile.c \
	fold.c \
	getchar.c \
	hardcopy.c \
	hashtab.c \
	if_cscope.c \
	if_xcmdsrv.c \
	indent.c \
	json.c \
	list.c \
	main.c \
	mark.c \
	mbyte.c \
	memfile.c \
	memline.c \
	menu.c \
	message.c \
	misc1.c \
	misc2.c \
	move.c \
	normal.c \
	ops.c \
	option.c \
	os_unix.c \
	popupmnu.c \
	popupwin.c \
	pty.c \
	quickfix.c \
	regexp.c \
	screen.c \
	search.c \
	sha256.c \
	spell.c \
	syntax.c \
	tag.c \
	term.c \
	textprop.c \
	ui.c \
	undo.c \
	usercmd.c \
	userfunc.c \
	version.c \
	window.c

LOCAL_C_INCLUDES += \
	external/libselinux/include \
	external/libncurses/include \
	$(LOCAL_PATH)/proto \
	$(LOCAL_PATH)/auto

LOCAL_SHARED_LIBRARIES += \
	libselinux \
	libncurses \
	libm \
	libdl

LOCAL_CFLAGS += \
	-DHAVE_CONFIG_H \
	-DSYS_VIMRC_FILE=\"/system/etc/vimrc\"

# vim variants: TINY SMALL CM NORMAL BIG HUGE
#
# NORMAL, BIG and HUGE are almost the same (1.1M)
# TINY and SMALL are similar to busybox vi (460K)
#
# our profile is between SMALL and NORMAL (780K)
# with syntax and utf8 (mbyte) support
#
# to reduce vim size, manually define wanted features
LOCAL_CFLAGS += \
	-DFEAT_SMALL=1 \
	-DFEAT_MBYTE=1 \
	-DFEAT_SYN_HL=1 \
	-DFEAT_CINDENT=1 \
	-DFEAT_COMMENTS=1 \
	-DFEAT_EVAL=1 \
	-DFEAT_AUTOCMD=1 \
	-DFEAT_USR_CMDS=1 \
	-DFEAT_EX_EXTRA=1 \
	-DFEAT_CMDL_COMPL=1 \
	-DFEAT_LISTCMDS=1 \
	-DFEAT_CMDL_INFO=1 \
	-DFEAT_SEARCH_EXTRA=1

LOCAL_CFLAGS += -Wno-unused-variable -Wno-unused-parameter

LOCAL_MODULE := vim
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
LOCAL_REQUIRED_MODULES := vimrc
include $(BUILD_EXECUTABLE)
