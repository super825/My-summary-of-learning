

### 在线帮助手册

http://man7.org/linux/man-pages/man1/top.1.html

### 查看帮助信息

```bash
#帮助手册安装
sudo yum install -y manpages-posix-dev man-pages man-db man2html help2man most
#查看命令是否为内建命令
type awk
#查看命令主要作用
whatis awk
#查找命令位置
which awk
whereis awk
#显示详细帮助文档
info awk
man awk
#浏览器中打开帮助文档
man -H awk
#快速查看命令参数
awk --help
awk -h
#命令常用方式示例
tldr awk
cheat awk
#查看一个配置文件的主要帮助信息
apropos services
```

### man命令

- 只有外部命令才可以使用man命令

- man手册的分类（一般分为九类， 但是只有前八类比较常用）

  - 1 普通的命令（外部程序或者shell命令）
  - 2 系统调用（内核提供的函数）
  - 3 库调用（库中提供的函数）
  - 4 特殊文件（经常是/dev下的设备文件）
  - 5 文件格式， 在其中会说明配置文件的格式
  - 6 游戏相关
  - 7 杂项
  - 8 管理员命令
  - 9 内核程序（非标准）

- man命令的配置文件

  - /etc/man_db.conf（Centos7）
  - 其中使用MANPATH_MAP项来说明man手册的位置
  - man手册的主要位置在/usr/share/man
  - 查看制定章节的man手册 `man 5 passwd` 
