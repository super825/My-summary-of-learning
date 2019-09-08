[TOC]

# SpaceVim官网

https://spacevim.org/cn/

# 安装

```bash
sudo curl -sLf https://spacevim.org/cn/install.sh | bash
```

# 使用文档

https://spacevim.org/cn/documentation/

# 开发指南

https://spacevim.org/cn/development/

# SpaceVim 中文博客

SpaceVim 中文博客主要公布最新版本发布、新特性预览、以及一些 SpaceVim 及 Vim 相关的使用教程，可通过 RSS [订阅本博客](https://spacevim.org/feed.xml)：

### [使用 Vim 搭建 Python 开发环境](https://spacevim.org/cn/use-vim-as-a-python-ide/)

28 Sep 2018

这篇文章主要介绍如何使用 SpaceVim 搭建 Python 的开发环境，简介 lang#python 模块所支持的功能特性以及使用技巧

### [使用 Vim 搭建基本开发环境](https://spacevim.org/cn/use-vim-as-ide/)

27 Sep 2018

这篇文章主要介绍如何使用 SpaceVim 搭建基本的的开发环境，简介 SpaceVim 基本的使用技巧

### [使用 Vim 搭建 Java 开发环境](https://spacevim.org/cn/use-vim-as-a-java-ide/)

19 Sep 2018

如何使用 Vim 搭建 Java 的开发环境，自动补全、语法检查、代码格式化、交互式编程以及断点调试相关使用技巧

### [Vim 异步实时代码检索](https://spacevim.org/cn/grep-on-the-fly-in-spacevim/)

31 Jan 2018

异步执行 grep，根据输入内容实时展示搜索结果，支持全工程检索、检索当前文件、检索已打开的文件等

### [VIM 中 ctrl 相关的组合键的使用](https://spacevim.org/use-ctrl-in-terminal-and-vim/)

04 Nov 2017

枚举 Vim 内置的 Ctrl 组合键功能，以及终端下的一些区别

### [VIM 8 新特性之旅: 定时器 (timers)](https://spacevim.org/cn/vim8-new-feature-timers/)

11 Feb 2017

VIM 8 新特性之旅系列教程 - 定时器, 介绍定时器具体使用方法以及场景



# SpaceVim插件配置

SPC: 空格    leader: \

`SPC f v d`

```bash
#=============================================================================
# dark_powered.toml --- dark powered configuration example for SpaceVim
# Copyright (c) 2016-2017 Wang Shidong & Contributors
# Author: Wang Shidong < wsdjeg at 163.com >
# URL: https://spacevim.org
# License: GPLv3
#=============================================================================

# All SpaceVim option below [option] section
[options]
    # set spacevim theme. by default colorscheme layer is not loaded,
    # if you want to use more colorscheme, please load the colorscheme
    # layer
    colorscheme = "gruvbox"
    background = "dark"
    # Disable guicolors in basic mode, many terminal do not support 24bit
    # true colors
    enable_guicolors = true
    # Disable statusline separator, if you want to use other value, please
    # install nerd fonts
    statusline_separator = "arrow"
    statusline_inactive_separator = "arrow"
    buffer_index_type = 4
    enable_tabline_filetype_icon = true
    enable_statusline_display_mode = false

# Enable autocomplete layer
[[layers]]
name = 'autocomplete'
auto-completion-return-key-behavior = "complete"
auto-completion-tab-key-behavior = "smart"

[[layers]]
name = 'shell'
default_position = 'top'
default_height = 30

[[layers]]
  name = "VersionControl"

[[layers]]
  name = "chat"

[[layers]]
  name = "checkers"

[[layers]]
  name = "chinese"

[[layers]]
  name = "colorscheme"

[[layers]]
  name = "core#banner"

[[layers]]
  name = "core#statusline"

[[layers]]
  name = "core#tabline"

[[layers]]
  name = "core"

[[layers]]
  name = "cscope"

[[layers]]
  name = "ctrlp"

[[layers]]
  name = "debug"

[[layers]]
  name = "default"

[[layers]]
  name = "denite"

[[layers]]
  name = "edit"

[[layers]]
  name = "floobits"

[[layers]]
  name = "format"

[[layers]]
  name = "fzf"

[[layers]]
  name = "git"

[[layers]]
  name = "github"

#[[layers]]
#  name = "japanese"

[[layers]]
  name = "lang#WebAssembly"

#[[layers]]
#  name = "lang#agda"

[[layers]]
  name = "lang#asciidoc"

#[[layers]]
#  name = "lang#autohotkey"

[[layers]]
  name = "lang#c"

#[[layers]]
#  name = "lang#clojure"

#[[layers]]
#  name = "lang#csharp"

#[[layers]]
#  name = "lang#dart"

[[layers]]
  name = "lang#dockerfile"

#[[layers]]
#  name = "lang#elixir"

#[[layers]]
#  name = "lang#elm"

#[[layers]]
#  name = "lang#erlang"

#[[layers]]
#  name = "lang#extra"

#[[layers]]
#  name = "lang#fsharp"

[[layers]]
  name = "lang#go"

#[[layers]]
#  name = "lang#haskell"

[[layers]]
  name = "lang#html"

[[layers]]
  name = "lang#java"

[[layers]]
  name = "lang#javascript"

[[layers]]
  name = "lang#julia"

[[layers]]
  name = "lang#kotlin"

#[[layers]]
#  name = "lang#latex"

#[[layers]]
#  name = "lang#lisp"

[[layers]]
  name = "lang#lua"

[[layers]]
  name = "lang#markdown"

#[[layers]]
#  name = "lang#nim"

#[[layers]]
#  name = "lang#ocaml"

#[[layers]]
#  name = "lang#perl"

#[[layers]]
#  name = "lang#php"

#[[layers]]
#  name = "lang#plantuml"

#[[layers]]
#  name = "lang#puppet"

#[[layers]]
#  name = "lang#purescript"

[[layers]]
  name = "lang#python"

#[[layers]]
#  name = "lang#ruby"

#[[layers]]
#  name = "lang#rust"

[[layers]]
  name = "lang#scala"

[[layers]]
  name = "lang#sh"

[[layers]]
  name = "lang#swift"

[[layers]]
  name = "lang#typescript"

[[layers]]
  name = "lang#vim"

[[layers]]
  name = "lang#vue"

[[layers]]
  name = "lsp"

[[layers]]
  name = "leaderf"

[[layers]]
  name = "shell"

[[layers]]
  name = "sudo"

[[layers]]
  name = "tags"

[[layers]]
  name = "tmux"

[[layers]]
  name = "tools#dash"

[[layers]]
  name = "tools"

[[layers]]
  name = "ui"
```

