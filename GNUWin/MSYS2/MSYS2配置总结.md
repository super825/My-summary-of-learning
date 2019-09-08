[TOC]

MSYS2下载：http://www.msys2.org/

# MSYS2是什么

* MSYS2 （Minimal SYStem 2） 是一个MSYS的独立改写版本，主要用于 shell 命令行开发环境。同时它也是一个在Cygwin （POSIX 兼容性层） 和 MinGW-w64（从"MinGW-生成"）基础上产生的，追求更好的互操作性的 Windows 软件。
* MSYS2 [1]  是MSYS的一个升级版, 准确的说是集成了pacman和Mingw-w64的Cygwin升级版, 提供了bash shell等linux环境、版本控制软件（git/hg）和MinGW-w64 工具链。与MSYS最大的区别是移植了 Arch Linux的软件包管理系统 Pacman(其实是与Cygwin的区别)。

# 特点

* 安装方便
* 自带 pacman 管理，可以使用 pkgtool 来 makepkg
* 较快的源速度（可以修改源地址）
* 自带软件和库较全而且比较新
* 使用mingw-w64工具链, 可以编译32位或64位代码（需要自行安装）
* 中文支持好, 可以直接输入和浏览中文目录

# 一、MSYS2的MirrorList配置

## 1、修改msys2安装目录下的/etc/pacman.d文件夹里面的3个mirrorlist.*文件

**mirrorlist.mingw32** ( /etc/pacman.d/mirrorlist.mingw32 )

``` bash
#中国科学技术大学开源软件镜像
Server = http://mirrors.ustc.edu.cn/msys2/mingw/i686/
#清华大学开源软件镜像
Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/i686
#北京理工大学开源软件镜像
Server = http://mirror.bit.edu.cn/msys2/REPOS/MINGW/i686
#日本北陆先端科学技术大学院大学 sourceforge 镜像
Server = http://jaist.dl.sourceforge.net/project/msys2/REPOS/MINGW/i686
Server = ftp://ftp.jaist.ac.jp/pub/sourceforge/m/ms/msys2/REPOS/MINGW/i686
```

**mirrorlist.mingw64**( /etc/pacman.d/mirrorlist.mingw64 )

``` bash
#中国科学技术大学开源软件镜像
Server = http://mirrors.ustc.edu.cn/msys2/mingw/x86_64/
#清华大学开源软件镜像
Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/x86_64
#北京理工大学开源软件镜像
Server = http://mirror.bit.edu.cn/msys2/REPOS/MINGW/x86_64
#日本北陆先端科学技术大学院大学 sourceforge 镜像
Server = http://jaist.dl.sourceforge.net/project/msys2/REPOS/MINGW/x86_64
Server = ftp://ftp.jaist.ac.jp/pub/sourceforge/m/ms/msys2/REPOS/MINGW/x86_64
```

**mirrorlist.msys**( /etc/pacman.d/mirrorlist.msys )

``` bash
#中国科学技术大学开源软件镜像
Server = http://mirrors.ustc.edu.cn/msys2/msys/$arch
#清华大学开源软件镜像
Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/msys/$arch
#北京理工大学开源软件镜像
Server = http://mirror.bit.edu.cn/msys2/REPOS/MSYS2/$arch
#日本北陆先端科学技术大学院大学 sourceforge 镜像
Server = http://jaist.dl.sourceforge.net/project/msys2/REPOS/MSYS2/$arch
Server = ftp://ftp.jaist.ac.jp/pub/sourceforge/m/ms/msys2/REPOS/MSYS2/$arch
```

## 2、修改/etc/pacman.conf，把下面注释行放开

``` bash
XferCommand = /usr/bin/wget --passive-ftp -c -O %o %u
```

## 3、更新软件包

``` bash
pacman -Syu
```

# 二、常用工具安装

## 1、查看工具套件

``` bash
pacman -Sg
```

得到结果如下：

``` bash
kf5
mingw-w64-i686-toolchain
mingw-w64-i686
mingw-w64-i686-gimp-plugins
mingw-w64-i686-qt4
mingw-w64-i686-qt
mingw-w64-i686-qt5
mingw-w64-i686-vulkan-devel
tesseract-data
mingw-w64-x86_64-toolchain
mingw-w64-x86_64
mingw-w64-x86_64-gimp-plugins
mingw-w64-x86_64-qt4
mingw-w64-x86_64-qt
mingw-w64-x86_64-qt5
mingw-w64-x86_64-vulkan-devel
libraries
development
base-devel
base
msys2-devel
compression
VCS
sys-utils
Database
net-utils
editors
python-modules
mingw-w64-cross-toolchain
mingw-w64-cross
MSYS2-devel
perl-modules
```

自行根据需要安装，一般较常用安装

``` bash
pacman -S --noconfirm mingw-w64-x86_64-toolchain libraries development base-devel msys2-devel compression VCS sys-utils net-utils editors python-modules
pacman -S --noconfirm mingw-w64-cross mingw-w64-cross-toolchain
```

## 2、常用工具

* 查看可安装软件列表

``` bash
pacman -Sl
```

* 为了让安装起作用，需要修改~/.bashrc，在最后面加上

``` bash
export PATH=~/.local/bin:/bin:/sbin/:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/mingw64/bin:/mingw64/sbin:/mingw64/usr/bin:/mingw64/usr/sbin/:/mingw64/usr/local/bin:/mingw64/usr/local/sbin:$PATH
```

* 安装python

``` bash
pacman -S --noconfirm python2 mingw-w64-x86_64-python2-setuptools mingw-w64-x86_64-python2-pip mingw-w64-x86_64-python2-ipython
pacman -S --noconfirm python3 python3-setuptools python3-pip mingw-w64-x86_64-python3-ipython

#pip配置
mkdir ~/.pip
touch ~/.pip/pip.conf
echo -e "[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple" > ~/.pip/pip.conf
python -m pip install --upgrade pip

#语法检查
pip install --user flake8
#自动代码提示
pip install --user jedi
#自动导入模块
pip install --user isort
#代码格式化
pip install --user yapf
```

* 安装python科学计算库

``` bash
pacman -S --noconfirm python2-numpy python2-scipy python2-matplotlib python2-pandas
pacman -S --noconfirm python3-numpy python3-scipy python3-matplotlib python3-pandas
```

* 安装所有python工具

``` bash
pacman -Sl | grep python2 | awk '{print "pacman -S --noconfirm "$2}' > python2-all.sh
sh python2-all.sh
pacman -Sl | grep python3 | awk '{print "pacman -S --noconfirm "$2}' > python3-all.sh
sh python3-all.sh
```

* 安装nodejs

``` bash
pacman -S --noconfirm mingw-w64-x86_64-nodejs
npm config set registry https://registry.npm.taobao.org
npm i -g tldr
#tldr --update
npm i -g cnpm --registry=https://registry.npm.taobao.org
npm i -g yarn --registry=https://registry.npm.taobao.org
```

* 安装帮助手册

``` bash
pacman -S --noconfirm help2man man-db man-pages-posix
```

* 安装zsh和git

``` bash
pacman -S --noconfirm zsh git
```

* [安装oh my zsh](https://github.com/robbyrussell/oh-my-zsh)

``` bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

* 启动打开zsh

``` bash
vim .bashrc
```

* 在文件最后一行添加，当然也可以直接在命令行中执行

``` bash
exec zsh
```

* 安装fish和oh my fish

``` bash
pacman -S --noconfirm fish
curl -L https://get.oh-my.fish | fish
#用git安装
git clone https://github.com/oh-my-fish/oh-my-fish
cd oh-my-fish
bin/install --offline
```

* 安装vim

``` bash
pacman -S --noconfirm vim
```

* [超强vim配置文件](https://github.com/ma6174/vim)

``` bash
wget -qO- https://raw.github.com/ma6174/vim/master/setup.sh | sh -x
```

*  SpaceVim

``` bash
curl -sLf https://spacevim.org/cn/install.sh | bash
```

* 其他

``` bash
pacman -S --noconfirm zip tree sqlite markdown moreutils
```

# 三、Pacman 命令详解

Pacman 是一个命令行工具，这意味着当你执行下面的命令时，必须在终端或控制台中进行。

## 1、更新系统

* 在 Arch Linux 中，使用一条命令即可对整个系统进行更新：

``` bash
pacman -Syu
```

* 如果你已经使用 pacman -Sy 将本地的包数据库与远程的仓库进行了同步，也可以只执行：

``` bash
pacman -Su
```

## 2、安装包

``` bash
pacman -S 包名 例如，执行 pacman -S firefox 将安装 Firefox。你也可以同时安装多个包，只需以空格分隔包名即可。
pacman -Sy 包名 与上面命令不同的是，该命令将在同步包数据库后再执行安装。
pacman -Sv 包名 在显示一些操作信息后执行安装。
pacman -U 安装本地包，其扩展名为 pkg.tar.gz。
```

## 3、删除包

``` bash
pacman -R 包名 该命令将只删除包，不包含该包的依赖。
pacman -Rs 包名 在删除包的同时，也将删除其依赖。
pacman -Rd 包名 在删除包时不检查依赖。
```

## 4、搜索包

``` bash
pacman -Ss 关键字 这将搜索含关键字的包。
pacman -Qi 包名 查看有关包的信息。
pacman -Ql 包名 列出该包的文件。
```

## 5、其他用法

``` bash
pacman -Sw 包名 只下载包，不安装。
pacman -Sc Pacman 下载的包文件位于 /var/cache/pacman/pkg/ 目录。该命令将清理未安装的包文件。
pacman -Scc 清理所有的缓存文件。
```

关于 Pacman 更加详细的用法，可以阅读[Pacman 的手册页](https://www.archlinux.org/pacman/pacman.8.html)

