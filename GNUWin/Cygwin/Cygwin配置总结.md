[TOC]

# Cygwin配置总结

## Cygwin是

- 大量GNU和开放源码工具的集合，它们提供了类似于Windows上的Linux发行版的功能

- DLL（cygwin1.dll），它提供了大量的POSIX API功能。

## Cygwin不是

- 一种在Windows上运行本地Linux应用程序的方法。如果希望应用程序在Windows上运行，则必须从源代码重新构建应用程序。

- 一种神奇地使本机Windows应用程序知道UNIX∈功能（如信号、ptys等）的方法。同样，如果想利用Cygwin功能，需要从源代码构建应用程序。

## 安装Cygwin

- 通过运行[setup-x86_64.exe（64位安装）](https://cygwin.com/setup-x86_64.exe)或[setup-x86.exe（32位安装）](https://cygwin.com/setup-x86.exe)安装Cygwin

- 使用安装程序执行[新安装](https://cygwin.com/install.html)或[更新现有安装](https://cygwin.com/install.html)。

- 请记住，发行版中的单个包是与DLL分开更新的，所以Cygwin DLL版本对于一般的Cygwin发行版本号来说没有用。

## 国内源地址

- 网易 http://mirrors.163.com/cygwin/

- 中科大 http://mirrors.ustc.edu.cn/cygwin/
- 搜狐 http://mirrors.sohu.com/cygwin/

> 安装过程中选择站点时一定要自己添加国内源，不然下载会很慢，推荐搜狐

## 安装第三方包管理工具apt-cyg

```bash
wget https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg
mv apt-cyg /bin/apt-cyg
chmod +x /bin/apt-cyg
apt-cyg mirror http://mirrors.sohu.com/cygwin/
```

## [apt-cyg用法](https://github.com/transcode-open/apt-cyg)

```
install
  Install package(s).

remove
  Remove package(s) from the system.

update
  Download a fresh copy of the master package list (setup.ini) from the
  server defined in setup.rc.

download
  Retrieve package(s) from the server, but do not install/upgrade anything.

show
  Display information on given package(s).

depends
  Produce a dependency tree for a package.

rdepends
  Produce a tree of packages that depend on the named package.

list
  Search each locally-installed package for names that match regexp. If no
  package names are provided in the command line, all installed packages will
  be queried.

listall
  This will search each package in the master package list (setup.ini) for
  names that match regexp.

category
  Display all packages that are members of a named category.

listfiles
  List all files owned by a given package. Multiple packages can be specified
  on the command line.

search
  Search for downloaded packages that own the specified file(s). The path can
  be relative or absolute, and one or more files can be specified.

searchall
  Search cygwin.com to retrieve file information about packages. The provided
  target is considered to be a filename and searchall will return the
  package(s) which contain this file.
```
## 安装编译环境

```bash
apt-cyg install gcc-core gcc-g++ gdb make autoconf automake libboost-devel
```

## 安装系统管理工具

```
apt-cyg install openssh openssl binutils util-linux bash-completion procps inetutils bind-utils
```
## 安装常用工具

```bash
apt-cyg install git wget curl vim tree
```

## 安装python

```bash
apt-cyg install python python-ipython python-pip python-setuptools
apt-cyg install python3 python3-ipython python3-pip python3-setuptools

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

## 安装帮助手册

```bash
apt-cyg install help2man man-db man-pages-posix
```

## 安装zsh

```bash
apt-cyg install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
## 安装fish

```bash
apt-cyg install fish
curl -L https://get.oh-my.fish | fish
#用git安装
git clone https://github.com/oh-my-fish/oh-my-fish
cd oh-my-fish
bin/install --offline
```

## 安装nodejs

```bash
npm config set registry https://registry.npm.taobao.org
npm i -g tldr
tldr --update
npm i -g cnpm --registry=https://registry.npm.taobao.org
npm i -g yarn
yarn config set registry https://registry.npm.taobao.org
```

## [超强vim配置文件](https://github.com/ma6174/vim)

```bash
wget -qO- https://raw.github.com/ma6174/vim/master/setup.sh | sh -x
```

## SpaceVim

```bash
curl -sLf https://spacevim.org/cn/install.sh | bash
```

