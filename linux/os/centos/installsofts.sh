#! /bin/bash

# sudo不输入密码
# sudo visudo
# 在最后增加
#sudo echo "super ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
#普通用户不用输入密码
sudo groupadd sudo
sudo usermod -G sudo super

#自定义别名
grep "alias cls='clear'" ~/.bashrc > /dev/null
if [ $? -eq 0 ]; then
    echo "alias was seted."
else
    echo "alias cls='clear'" >> ~/.bashrc
    echo "alias yum='sudo yum'" >> ~/.bashrc
    echo "alias yumi='yum install -y'" >> ~/.bashrc
    echo "alias yumr='yum remove -y'" >> ~/.bashrc
    echo "alias npm='sudo npm'" >> ~/.bashrc
    echo "alias cnpm='sudo cnpm'" >> ~/.bashrc
    echo "alias yarn='sudo yarn'" >> ~/.bashrc
    echo "alias pip='sudo -H pip'" >> ~/.bashrc
    echo "alias pip3='sudo -H pip3'" >> ~/.bashrc
    echo "alias vim='sudo vim'" >> ~/.bashrc
    echo "alias l='ls -al'" >> ~/.bashrc
    echo "alias ll='ls -l'" >> ~/.bashrc
    echo "alias mv='mv -i'" >> ~/.bashrc
    echo "alias cp='cp -i'" >> ~/.bashrc
    echo "alias rm='rm -i'" >> ~/.bashrc
    echo "export PAGER=most" >> ~/.bashrc
    echo "export BROWSER=firefox" >> ~/.bashrc
    echo "export EDITOR=vim" >> ~/.bashrc
    source ~/.bashrc
fi

#mirror
sudo yum install -y yum-fastestmirror
sudo yum install -y wget curl git

#使用 EPEL 源 (Extra Packages for Enterprise Linux）
sudo yum install -y epel-release
#sudo yum localinstall --nogpgcheck http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

#yum-axelget是EPEL提供的一个yum插件。使用该插件后用yum安装软件时可以并行下载，大大提高了软件的下载速度，减少了下载的等待时间
sudo yum install -y yum-axelget

#yum重新创建缓存
#sudo yum clean all
#sudo yum makecache

#输入法
sudo yum install -y ibus ibus-table-wubi 
sudo yum install -y fcitx-configtool fcitx fcitx-table-wubi

#打开输入法设置
# gsettings set org.gnome.settings-daemon.plugins.keyboard active false

#常用开发工具
sudo yum install -y chromium tree vim dos2unix
#sudo yum install -y terminator
sudo yum install -y kernel-devel
sudo yum install -y gcc cpp gcc-c++ gd-devel glibc-doc
sudo yum install -y ncurses ncurses-devel
sudo yum install -y zlib zlib-devel
sudo yum install -y freetype-devel freetype-demos freetype-utils
sudo yum install -y openssl openssl-devel
sudo yum install -y openssh-server
sudo yum install -y bzip2-devel
sudo yum install -y sqlite-devel
sudo yum install -y python-devel
# sudo yum install -y java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-devel.x86_64
sudo yum install -y java-latest-openjdk
sudo yum install -y manpages-posix-dev man-pages man-db man2html help2man most

#nodejs相关
# wget https://nodejs.org/dist/v10.16.2/node-v10.16.2-linux-x64.tar.xz
# sudo tar Jxvf node-v10.16.2-linux-x64.tar.xz -C /usr/local
# sudo ln -s /usr/local/node-v10.16.2-linux-x64/bin/node /usr/bin/node
# sudo ln -s /usr/local/node-v10.16.2-linux-x64/bin/npm /usr/bin/npm
# grep "export PATH=/usr/local/node" ~/.bashrc || echo 'export PATH=/usr/local/node-v10.16.2-linux-x64/bin:$PATH' >> ~/.bashrc
# source ~/.bashrc
sudo yum install -y nodejs npm
sudo npm config set registry https://registry.npm.taobao.org
# sudo npm i -g npm
sudo npm i -g cnpm --registry https://registry.npm.taobao.org
sudo npm i -g yarn --registry https://registry.npm.taobao.org
sudo npm i -g tldr
sudo npm i -g cheat
# sudo ln -s /usr/local/node-v10.16.2-linux-x64/bin/cnpm /usr/bin/cnpm
# sudo ln -s /usr/local/node-v10.16.2-linux-x64/bin/yarn /usr/bin/yarn
# sudo ln -s /usr/local/node-v10.16.2-linux-x64/bin/tldr /usr/bin/tldr

#python相关
sudo yum install -y python python-ipython python-pip python-setuptools
sudo yum install -y python36 python36-pip python36-setuptools
#yum --enablerepo=ius install -y python36u python36u-pip
#升级所有过期库
# sudo pip list --outdated | awk '{print "sudo pip install --upgrade "$1}' > python-upgrade.sh
# sudo sh python-upgrade.sh
#sudo yum install -y python2-numpy python2-pandas python2-matplotlib scipy python2-jupyter-core
[ -e ~/.pip ] || sudo mkdir ~/.pip
[ -e ~/.pip/pip.conf ] || sudo touch ~/.pip/pip.conf
sudo chmod a+w ~/.pip/pip.conf
sudo echo -e "[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple" > ~/.pip/pip.conf
sudo pip install --upgrade pip
#升级pip3
#sudo rm -rf /usr/bin/pip3
#sudo cp /usr/local/bin/pip3 /usr/bin/pip3
#命令行文件管理器
pip install ranger-fm
#语法检查
pip install --user flake8
#自动代码提示
pip install --user jedi
#自动导入模块
pip install --user isort
#代码格式化
pip install --user yapf
#通过安装 pygments扩展让vim支持 50+ 种语言（包括 go/rust/scala 等，基本覆盖所有主流语言
pip install pygments

#vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo yum check-update
sudo yum install -y code

#fish & oh my fish
sudo yum install -y fish
#curl -L https://get.oh-my.fish | fish

#zsh & on my zsh
sudo yum install -y zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

[ -e ~/.zshrc ] || sudo touch ~/.zshrc

#自定义别名
grep "alias cls='clear'" ~/.zshrc > /dev/null
if [ $? -eq 0 ]; then
    echo "alias was seted."
else
    echo "alias cls='clear'" >> ~/.zshrc
    echo "alias yum='sudo yum'" >> ~/.zshrc
    echo "alias yumi='yum install -y'" >> ~/.zshrc
    echo "alias yumr='yum remove -y'" >> ~/.zshrc
    echo "alias npm='sudo npm'" >> ~/.zshrc
    echo "alias cnpm='sudo cnpm'" >> ~/.zshrc
    echo "alias yarn='sudo yarn'" >> ~/.zshrc
    echo "alias pip='sudo -H pip'" >> ~/.zshrc
    echo "alias pip3='sudo -H pip3'" >> ~/.zshrc
    echo "alias vim='sudo vim'" >> ~/.zshrc
    echo "alias l='ls -al'" >> ~/.zshrc
    echo "alias ll='ls -l'" >> ~/.zshrc
    echo "alias mv='mv -i'" >> ~/.zshrc
    echo "alias cp='cp -i'" >> ~/.zshrc
    echo "alias rm='rm -i'" >> ~/.zshrc
    echo "export PAGER=most" >> ~/.zshrc
    echo "export BROWSER=firefox" >> ~/.zshrc
    echo "export EDITOR=vim" >> ~/.zshrc
    source ~/.zshrc
fi

#vim config
# wget -qO- https://raw.github.com/ma6174/vim/master/setup.sh | sh -x

#space-vim
#sudo curl -sLf https://spacevim.org/cn/install.sh | bash
#yum grouplist | more

#CentOS7升级git2.17
# 部署环境、卸载原git
# yum remove git -y
# yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel asciidoc gcc perl-ExtUtils-MakeMaker -y
# 编译libiconv
# wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz
# tar zxvf libiconv-1.15.tar.gz
# cd libiconv-1.15
# ./configure --prefix=/usr/local/libiconv
# make && make install
# 下载git源码并编译
# wget https://github.com/git/git/archive/v2.17.0.tar.gz
# tar xzvf v2.17.0.tar.gz
# cd git-2.17.0
# make configure
# ./configure --prefix=/usr/local/git --with-iconv=/usr/local/libiconv
# make install
# echo "export PATH=$PATH:/usr/local/git/bin" >> /etc/bashrc
# source /etc/bashrc
# 查看版本
# git --version

#CentOS7快速从vim7升到vim8
# sudo rpm -Uvh http://mirror.ghettoforge.org/distributions/gf/gf-release-latest.gf.el7.noarch.rpm
# sudo rpm --import http://mirror.ghettoforge.org/distributions/gf/RPM-GPG-KEY-gf.el7
# sudo yum -y remove vim-minimal vim-common vim-enhanced
# sudo yum -y --enablerepo=gf-plus install vim-enhanced

#------------以下不实用-------------
#RPMForge是CentOS系统下的软件仓库，拥有4000多种的软件包，被CentOS社区认为是最安全也是最稳定的一个软件仓库。
#sudo yum localinstall --nogpgcheck http://repository.it4i.cz/mirrors/repoforge/redhat/el7/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm

#安装 yum-priorities 插件后, 您可以给各个源设置优先级priority
#sudo yum install -y yum-plugin-priorities

#使用 Software Collections 源 （SCL）
#sudo yum install -y centos-release-scl
#sudo yum info rh-python35
#sudo yum install rh-python35
#scl enable rh-python35 bash
#scl -l

#使用 IUS 社区源
# curl 'https://setup.ius.io/' -o setup-ius.sh
# sudo sh setup-ius.sh

#Remi源大家或许很少听说，不过Remi源GoFace强烈推荐，尤其对于不想编译最新版的linux使用者，因为Remi源中的软件几乎都是最新稳定版
#wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
#sudo rpm -Uvh remi-release-7.rpm
#sudo yum --enablerepo=remi update remi-release
#sudo yum localinstall --nogpgcheck http://rpms.famillecollet.com/enterprise/remi-release-7.rpm