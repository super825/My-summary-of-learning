#! /bin/bash

#sudo apt update
#sudo apt upgrade -y

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
    echo "alias apt='sudo apt'" >> ~/.bashrc
    echo "alias apti='apt install -y'" >> ~/.bashrc
    echo "alias aptr='apt remove -y'" >> ~/.bashrc
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

#系统管理工具
#sudo apt install -y unity-tweak-tool

#输入法
sudo apt install -y ibus ibus-table-wubi
sudo apt install -y fcitx fcitx-table-wubi

#常用开发工具
sudo apt install -y chromium-browser
#sudo apt install -y terminator
sudo apt install -y wget curl git tree
sudo apt install -y vim tofrodoc
#sudo apt install -y vim-scripts vim-doc vim-addon-manager
sudo apt install -y cpp gcc g++ gdb glibc-doc
sudo apt install -y openssh-server
sudo apt install -y default-jdk
sudo apt install -y manpages manpages-dev manpages-posix manpages-posix-dev manpages-zh most

#nodejs相关
sudo apt install -y nodejs npm
sudo npm config set registry https://registry.npm.taobao.org
sudo npm i -g npm
sudo npm i -g cnpm --registry=https://registry.npm.taobao.org
sudo npm i -g yarn --registry=https://registry.npm.taobao.org
sudo npm i -g tldr
sudo npm i -g cheat

#python相关
sudo apt install -y python python-pip python-setuptools ipython python3 python3-pip python3-setuptools ipython3
[ -e ~/.pip ] || sudo mkdir ~/.pip
[ -e ~/.pip/pip.conf ] || sudo touch ~/.pip/pip.conf
sudo chmod a+w ~/.pip/pip.conf
sudo echo -e "[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple" > ~/.pip/pip.conf
sudo pip install --upgrade pip
#sudo pip install pipenv
#sudo pip install numpy scipy matplotlib pandas scikit-learn
sudo pip3 install --upgrade pip
#sudo pip3 install pipenv
#sudo pip3 install numpy scipy matplotlib pandas scikit-learn
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
sudo apt install -y code

#fish & oh my fish
sudo apt install -y fish
#curl -L https://get.oh-my.fish | fish

#zsh & oh my zsh
sudo apt install -y zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

[ -e ~/.zshrc ] || sudo touch ~/.zshrc
#自定义别名
grep "alias cls='clear'" ~/.zshrc > /dev/null
if [ $? -eq 0 ]; then
    echo "alias was seted."
else
    echo "alias cls='clear'" >> ~/.zshrc
    echo "alias apt='sudo apt'" >> ~/.zshrc
    echo "alias apti='apt install -y'" >> ~/.zshrc
    echo "alias aptr='apt remove -y'" >> ~/.zshrc
    echo "alias npm='sudo npm'" >> ~/.zshrc
    echo "alias cnpm='sudo cnpm'" >> ~/.zshrc
    echo "alias yarn='sudo yarn'" >> ~/.zshrc
    echo "alias pip='sudo -H pip'" >> ~/.zshrc
    echo "alias pip3='sudo -H pip3'" >> ~/.zshrc
    echo "alias vim='sudo vim'" >> ~/.
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

#超好用的vim配置
#wget -qO- https://raw.github.com/ma6174/vim/master/setup.sh | sh -x

#space-vim
#sudo curl -sLf https://spacevim.org/cn/install.sh | bash

#手动安装deb包
#sudo apt-get install -f
#sudo dpkg -i deb文件名

#升级所有过期库
#pip list --outdated | awk '{print "pip install --upgrade "$1}' > python-upgrade.sh
#sh python-upgrade.sh

#重新安装pip
#https://www.imooc.com/article/31953?block_id=tuijian_wz
#sudo python3 -m pip uninstall pip && sudo apt install python3-pip --reinstall