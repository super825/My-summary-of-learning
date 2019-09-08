##提前准备etc和bin两个目录
mkdir -p /usr/local/redis/etc
mkdir -p /usr/local/redis/bin
##切换到/usr/local
cd /usr/local
##删除已有文件，如果存在的话
sudo rm -rf /usr/local/redis-5.0.4 /usr/local/redis-5.0.4.tar.gz
##下载redis-5.0.4.tar.gz到/usr/local
wget http://download.redis.io/releases/redis-5.0.4.tar.gz
##解压到/usr/local
tar -zxvf redis-5.0.4.tar.gz
##切换到/usr/local/redis-5.0.4
cd /usr/local/redis-5.0.4
##编译源代码，开启8线程
make -j 16
##把redis.conf拷贝到/usr/local/redis/etc/
cp /usr/local/redis-5.0.4/redis.conf /usr/local/redis/etc/
##切换到/usr/local/redis-5.0.4/src
cd /usr/local/redis-5.0.4/src
##把编译生成的可执行文件放到/usr/local/redis/bin中
sudo mv mkreleasehdr.sh redis-benchmark redis-check-aof redis-check-rdb redis-cli redis-server redis-sentinel /usr/local/redis/bin
##修改文件权限为666
sudo chmod 666 /usr/local/redis/etc/redis.conf
##开启redis后台运行
sudo sed -i -e 's/daemonize no/daemonize yes/g' -e 's/dir \.\//dir \/usr\/local\/redis\/etc/g' /usr/local/redis/etc/redis.conf
##把redis-server等常用命令加入到PATH中
grep "export PATH=/usr/local/redis/bin:\$PATH" ~/.bashrc > /dev/null
if [ $? -eq 0 ]; then
    echo "redis path was seted."
else
	echo "export PATH=/usr/local/redis/bin:\$PATH" >> ~/.bashrc
fi
##启动redis-server
echo "-----------redis-server start------------"
/usr/local/redis/bin/redis-server /usr/local/redis/etc/redis.conf
##校验是否存在redis-server后台进程
echo "-----------redis-server process------------"
ps -ef | grep redis
echo "-----------------------"
netstat -tunpl | grep 6379