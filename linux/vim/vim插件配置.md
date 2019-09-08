

[TOC]

# Vim-plug：极简 Vim 插件管理器

Vim-plug 是一个自由、开源、速度非常快的、极简的 vim 插件管理器。它可以并行地安装或更新插件。你还可以回滚更新。它创建浅层克隆shallow clone最小化磁盘空间使用和下载时间。它支持按需加载插件以加快启动时间。其他值得注意的特性是支持分支/标签/提交、post-update 钩子、支持外部管理的插件等。

### 安装

安装和使用起来非常容易。你只需打开终端并运行以下命令：

```bash
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Neovim 用户可以使用以下命令安装 Vim-plug：

```bash
$ curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### 用法

#### 安装插件

要安装插件，你必须如下所示首先在 Vim 配置文件中声明它们。一般 Vim 的配置文件是 `~/.vimrc`，Neovim 的配置文件是 `~/.config/nvim/init.vim`。请记住，当你在配置文件中声明插件时，列表应该以 `call plug#begin(PLUGIN_DIRECTORY)` 开始，并以 `plug#end()` 结束。

例如，我们安装 “lightline.vim” 插件。为此，请在 `~/.vimrc` 的顶部添加以下行。

```bash
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
call plug#end()
```

在 vim 配置文件中添加上面的行后，通过输入以下命令重新加载：

```bash
:source ~/.vimrc
```

或者，只需重新加载 Vim 编辑器。

现在，打开 vim 编辑器：

```bash
$ vim
```

使用以下命令检查状态：

```bash
:PlugStatus
```

然后输入下面的命令，然后按回车键安装之前在配置文件中声明的插件。

```bash
:PlugInstall
```

#### 更新插件

要更新插件，请运行：

```bash
:PlugUpdate
```

更新插件后，按下 `d` 查看更改。或者，你可以之后输入 `:PlugDiff`。

#### 审查插件

有时，更新的插件可能有新的 bug 或无法正常工作。要解决这个问题，你可以简单地回滚有问题的插件。输入 `:PlugDiff` 命令，然后按回车键查看上次 `:PlugUpdate`的更改，并在每个段落上按 `X` 将每个插件回滚到更新前的前一个状态。

#### 删除插件

删除一个插件删除或注释掉你以前在你的 vim 配置文件中添加的 `plug` 命令。然后，运行 `:source ~/.vimrc` 或重启 Vim 编辑器。最后，运行以下命令卸载插件：

```bash
:PlugClean
```

该命令将删除 vim 配置文件中所有未声明的插件。

#### 升级 Vim-plug

要升级vim-plug本身，请输入：

```bash
:PlugUpgrade
```

如你所见，使用 Vim-plug 管理插件并不难。它简化了插件管理。现在去找出你最喜欢的插件并使用 Vim-plug 来安装它们。

#### 常用插件

```bash
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/vim-scripts/taglist.vim.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin.git'
Plug 'https://github.com/jistr/vim-nerdtree-tabs.git'
Plug 'https://github.com/vim-scripts/winmanager.git'
Plug 'https://github.com/scrooloose/nerdcommenter.git'
Plug 'https://github.com/Shougo/neocomplete.vim.git'
Plug 'https://github.com/tomasr/molokai.git'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/dkprice/vim-easygrep.git'
Plug 'https://github.com/vim-scripts/ctags.vim.git'
Plug 'https://github.com/vim-scripts/cscope.vim.git'
Plug 'https://github.com/vim-scripts/minibufexplorerpp.git'
"Plug 'tpope/vim-pathogen'
call plug#end()
```

