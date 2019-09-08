[TOC]

# Babun 配置总结

## 优势

`babun`集成了`cygwin`与`oh-my-zsh`，尤其是后者，意味着如果你同时拥有Win + MAC双系统的话，可以使用`babun`统一不同的系统间的开发环境。

## 下载

<http://babun.github.io/>

## 安装

- 解压缩到任意文件夹后，运行`install.bat`（需管理员权限）
- 也可以使用`/t "D:\target_folder"`的模式制定安装目录。
- 安装时如系统有安全防护等APP最好关闭。

## 配置

- 安装完毕后，一般需要以下两个命令：

  - `babun check`（用于判断环境是否正确）
  - `babun update`(用于判断是否有新的更新包)

## 默认根目录

```bash
%userprofile%\.babun\cygwin\home\username
```

## 包管理配置成国内源

`babun`自带了叫做`pact`的包管理，需要配置成国内源

```bash
echo "PACT_REPO=http://mirrors.sohu.com/cygwin/" > ~/.pact/pact.repo
```

## pact用法

```
pact: Installs and removes Cygwin packages.

Usage:
  "pact install <package names>" to install given packages
  "pact remove <package names>" to remove given packages
  "pact update <package names>" to update given packages
  "pact show" to show installed packages
  "pact find <patterns>" to find packages matching patterns
  "pact describe <patterns>" to describe packages matching patterns
  "pact packageof <commands or files>" to locate parent packages
  "pact invalidate" to invalidate pact caches (setup.ini, etc.)
Options:
  --mirror, -m <url> : set mirror
  --invalidate, -i       : invalidates pact caches (setup.ini, etc.)
  --force, -f : force the execution
  --help
  --version
```

## babun常用配置

### 常用插件

```bash
pact install autojump colored-man zsh_reload zsh-syntax-highlighting git ruby gem python pip node npm bower
```

### 安装编译环境

```bash
pact install gcc-core gcc-g++ gdb make autoconf automake libboost-devel
```

### 安装系统管理工具

```
pact install openssh openssl binutils util-linux bash-completion procps inetutils bind-utils
```
### 安装常用工具

```bash
pact install git wget curl vim tree
```

### 安装python

```bash
pact install python python-ipython python-pip python-setuptools
pact install python3 python3-ipython python3-pip python3-setuptools

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

### 安装帮助手册

```bash
pact install help2man man-db man-pages-posix
```

### 安装nodejs

```bash
npm config set registry https://registry.npm.taobao.org
npm i -g tldr
tldr --update
npm i -g cnpm --registry=https://registry.npm.taobao.org
npm i -g yarn
yarn config set registry https://registry.npm.taobao.org
```

### [超强vim配置文件](https://github.com/ma6174/vim)

```bash
wget -qO- https://raw.github.com/ma6174/vim/master/setup.sh | sh -x
```

## SpaceVim

```bash
curl -sLf https://spacevim.org/cn/install.sh | bash
```

