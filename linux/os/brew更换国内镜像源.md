# brew更换国内镜像源

homebrew主要分两部分： git repo（位于GitHub）和二进制bottle（位于binary）， 这两者在国内访问不太顺畅。 其实可以替换成国内的镜像， git repo国内镜像就比较多了， 可以自行查找， 如： 中科大镜像…

##### 替换homebrew默认源

```bash
替换brew.git:
cd "$(brew --repo)"
git remote set-url origin https://mirrors.ustc.edu.cn/brew.git

替换homebrew-core.git:
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git
```

如果替换源之后brew update 没反应

```bash
cd "$(brew --repo)"
git pull origin master
```

##### 切回官方源

```bash
重置brew.git:
cd "$(brew --repo)"
git remote set-url origin https://github.com/Homebrew/brew.git

重置homebrew-core.git:
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://github.com/Homebrew/homebrew-core.git
```

> 掉bash配置文件里的有关Homebrew Bottles即可恢复官方源。 重启bash或让bash重读配置文件。 

##### 替换Homebrew Bottles源

Homebrew Bottles是Homebrew提供的二进制代码包， 目前镜像站收录了以下仓库： 

对于bash用户

```bash
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.bash_profile
source ~/.bash_profile
```

对于zsh用户

```bash
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.zshrc
source ~/.zshrc
```

centos7安装brew

```bash
#linuxbrew
#sudo yum groupinstall -y 'Development Tools'
# sudo yum install curl git irb python-setuptools ruby
# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"

# echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >>~/.profile
# echo 'export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"' >>~/.profile
# echo 'export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"' >>~/.profile

# echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >>~/.bashrc
# echo 'export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"' >>~/.bashrc
# echo 'export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"' >>~/.bashrc

# echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >>~/.zshrc
# echo 'export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"' >>~/.zshrc
# echo 'export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"' >>~/.zshrc

#替换brew.git:
# cd "$(brew --repo)"
# git remote set-url origin https://mirrors.ustc.edu.cn/brew.git

#替换homebrew-core.git:
# cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
# git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git

#如果替换源之后brew update 没反应
# cd "$(brew --repo)"
# git pull origin master

#切回官方源
#重置brew.git:
# cd "$(brew --repo)"
# git remote set-url origin https://github.com/Homebrew/brew.git

#重置homebrew-core.git:
# cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
# git remote set-url origin https://github.com/Homebrew/homebrew-core.git

#注释掉bash配置文件里的有关Homebrew Bottles即可恢复官方源。 重启bash或让bash重读配置文件。

#替换Homebrew Bottles源
#Homebrew Bottles是Homebrew提供的二进制代码包，目前镜像站收录了以下仓库：

#对于bash用户
# echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.bash_profile
# source ~/.bash_profile

#对于zsh用户
# echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.zshrc
# source ~/.zshrc

#常用工具
#brew install python ipython
#brew install glances
#brew upgrade gcc
```

ubuntu安装brew

```bash
#linuxbrew
# sudo apt install -y build-essential curl git python-setuptools ruby
# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"

# echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >>~/.profile
# echo 'export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"' >>~/.profile
# echo 'export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"' >>~/.profile

# echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >>~/.bashrc
# echo 'export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"' >>~/.bashrc
# echo 'export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"' >>~/.bashrc

# echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >>~/.zshrc
# echo 'export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"' >>~/.zshrc
# echo 'export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"' >>~/.zshrc
```

##  Alternative Installation

```bash
git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
mkdir ~/.linuxbrew/bin
ln -s ../Homebrew/bin/brew ~/.linuxbrew/bin
eval $(~/.linuxbrew/bin/brew shellenv)
```

