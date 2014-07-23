LOCAL_PATH := $(call my-dir)

# ========================================================
# vim
# ========================================================
include $(CLEAR_VARS)

# vim variants: TINY SMALL NORMAL BIG HUGE
#
# NORMAL, BIG and HUGE are almost the same (1.1M)
# TINY and SMALL are similar to busybox vi (450K)
#
vim_variant := BIG

LOCAL_SRC_FILES := \
	blowfish.c \
	buffer.c \
	charset.c \
	diff.c \
	digraph.c \
	edit.c \
	eval.c \
	ex_cmds.c \
	ex_cmds2.c \
	ex_docmd.c \
	ex_eval.c \
	ex_getln.c \
	fileio.c \
	fold.c \
	getchar.c \
	hardcopy.c \
	hashtab.c \
	if_cscope.c \
	if_xcmdsrv.c \
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
	auto/pathdef.c \
	popupmnu.c \
	quickfix.c \
	regexp.c \
	screen.c \
	search.c \
	sha256.c \
	spell.c \
	syntax.c \
	tag.c \
	term.c \
	ui.c \
	undo.c \
	version.c \
	window.c

# Unused in our config
#LOCAL_SRC_FILES += \
#	netbeans.c pty.c

LOCAL_C_INCLUDES += \
	external/libselinux/include \
	external/libncurses/include \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/proto \
	$(LOCAL_PATH)/auto

LOCAL_SHARED_LIBRARIES += \
	libselinux \
	libncurses \
	libm \
	libdl

LOCAL_CFLAGS += \
	-DFEAT_$(vim_variant)=1 \
	-DHAVE_CONFIG_H \
	-DSYS_VIMRC_FILE=\"/system/etc/vimrc\"

LOCAL_MODULE := vim
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
LOCAL_ADDITIONAL_DEPENDENCIES := vimrc
include $(BUILD_EXECUTABLE)

# ========================================================
# vim runtime files
# ========================================================
vim_runtime_path := $(LOCAL_PATH)/../runtime

vim_runtime_files := \
	scripts.vim \
	indent.vim \
	indoff.vim \
	filetype.vim \
	ftoff.vim

vim_colors_files := \
	default.vim \
	desert.vim

vim_doc_files := \
	help.txt intro.txt tags \
	motion.txt editing.txt scroll.txt \
	options.txt term.txt

vim_syntax_files := \
	logcat.vim \
	awk.vim \
	config.vim \
	conf.vim \
	cpp.vim \
	c.vim \
	css.vim \
	diff.vim \
	doxygen.vim \
	html.vim vb.vim \
	xml.vim dtd.vim \
	context.vim \
	gitcommit.vim \
	help.vim \
	javascript.vim \
	java.vim \
	manual.vim \
	sh.vim \
	syncolor.vim \
	synload.vim \
	syntax.vim \
	vim.vim

vim_plugin_files := \
	matchparen.vim \

vim_autoload_files :=
ifneq ($(vim_variant),SMALL)
  vim_autoload_files += spacehi.vim
endif

VIM_SHARED := $(TARGET_OUT)/usr/share/$(LOCAL_MODULE)

VIM_RUNTIME_R := \
	$(addprefix $(vim_runtime_path)/,$(vim_runtime_files))
$(VIM_RUNTIME_R): VIM_BINARY := $(LOCAL_MODULE)
$(VIM_RUNTIME_R): $(LOCAL_INSTALLED_MODULE)
	@echo "Install: $@ -> $(VIM_SHARED)/"
	@mkdir -p $(VIM_SHARED)
	$(hide) cp $@ $(VIM_SHARED)/

ALL_DEFAULT_INSTALLED_MODULES += $(VIM_RUNTIME_R)


VIM_RUNTIME_C := \
	$(addprefix $(vim_runtime_path)/colors/,$(vim_colors_files))
$(VIM_RUNTIME_C): VIM_BINARY := $(LOCAL_MODULE)
$(VIM_RUNTIME_C): $(LOCAL_INSTALLED_MODULE)
	@echo "Install: $@ -> $(VIM_SHARED)/colors/"
	@mkdir -p $(VIM_SHARED)/colors
	$(hide) cp $@ $(VIM_SHARED)/colors/

ALL_DEFAULT_INSTALLED_MODULES += $(VIM_RUNTIME_C)


VIM_RUNTIME_D := \
	$(addprefix $(vim_runtime_path)/doc/,$(vim_doc_files))
$(VIM_RUNTIME_D): VIM_BINARY := $(LOCAL_MODULE)
$(VIM_RUNTIME_D): $(LOCAL_INSTALLED_MODULE)
	@echo "Install: $@ -> $(VIM_SHARED)/doc/"
	@mkdir -p $(VIM_SHARED)/doc
	$(hide) cp $@ $(VIM_SHARED)/doc/

ALL_DEFAULT_INSTALLED_MODULES += $(VIM_RUNTIME_D)


VIM_RUNTIME_S := \
	$(addprefix $(vim_runtime_path)/syntax/,$(vim_syntax_files))
$(VIM_RUNTIME_S): VIM_BINARY := $(LOCAL_MODULE)
$(VIM_RUNTIME_S): $(LOCAL_INSTALLED_MODULE)
	@echo "Install: $@ -> $(VIM_SHARED)/syntax/"
	@mkdir -p $(VIM_SHARED)/syntax
	$(hide) cp $@ $(VIM_SHARED)/syntax/

ALL_DEFAULT_INSTALLED_MODULES += $(VIM_RUNTIME_S)


VIM_RUNTIME_P := \
	$(addprefix $(vim_runtime_path)/plugin/,$(vim_plugin_files))
$(VIM_RUNTIME_P): VIM_BINARY := $(LOCAL_MODULE)
$(VIM_RUNTIME_P): $(LOCAL_INSTALLED_MODULE)
	@echo "Install: $@ -> $(VIM_SHARED)/plugin/"
	@mkdir -p $(VIM_SHARED)/plugin
	$(hide) cp $@ $(VIM_SHARED)/plugin/

ALL_DEFAULT_INSTALLED_MODULES += $(VIM_RUNTIME_P)


VIM_RUNTIME_A := \
	$(addprefix $(vim_runtime_path)/autoload/,$(vim_autoload_files))
$(VIM_RUNTIME_A): VIM_BINARY := $(LOCAL_MODULE)
$(VIM_RUNTIME_A): $(LOCAL_INSTALLED_MODULE)
	@echo "Install: $@ -> $(VIM_SHARED)/autoload/"
	@mkdir -p $(VIM_SHARED)/autoload
	$(hide) cp $@ $(VIM_SHARED)/autoload/

ALL_DEFAULT_INSTALLED_MODULES += $(VIM_RUNTIME_A)


ALL_MODULES.$(LOCAL_MODULE).INSTALLED := \
	$(ALL_MODULES.$(LOCAL_MODULE).INSTALLED) \
	$(VIM_RUNTIME_R) $(VIM_RUNTIME_C) $(VIM_RUNTIME_D) \
	$(VIM_RUNTIME_S) $(VIM_RUNTIME_P) $(VIM_RUNTIME_A)


