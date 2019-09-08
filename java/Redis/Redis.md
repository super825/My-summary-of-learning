<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Redis](#redis)
  - [目录](#%E7%9B%AE%E5%BD%95)
  - [使用过程中发生的问题](#%E4%BD%BF%E7%94%A8%E8%BF%87%E7%A8%8B%E4%B8%AD%E5%8F%91%E7%94%9F%E7%9A%84%E9%97%AE%E9%A2%98)
  - [1.1 NOSQL简介](#11-nosql%E7%AE%80%E4%BB%8B)
  - [1.2 非关系型的数据库特点](#12-%E9%9D%9E%E5%85%B3%E7%B3%BB%E5%9E%8B%E7%9A%84%E6%95%B0%E6%8D%AE%E5%BA%93%E7%89%B9%E7%82%B9)
  - [1.3 Redis简介](#13-redis%E7%AE%80%E4%BB%8B)
  - [1.4 Redis的安装](#14-redis%E7%9A%84%E5%AE%89%E8%A3%85)
  - [2.1 String类型](#21-string%E7%B1%BB%E5%9E%8B)
  - [2.2 Hash类型](#22-hash%E7%B1%BB%E5%9E%8B)
  - [2.3 List 类型](#23-list-%E7%B1%BB%E5%9E%8B)
  - [2.4 set类型和zset类型（一）——set类型](#24-set%E7%B1%BB%E5%9E%8B%E5%92%8Czset%E7%B1%BB%E5%9E%8B%E4%B8%80set%E7%B1%BB%E5%9E%8B)
  - [2.4 set类型和zset类型（二）——zset类型](#24-set%E7%B1%BB%E5%9E%8B%E5%92%8Czset%E7%B1%BB%E5%9E%8B%E4%BA%8Czset%E7%B1%BB%E5%9E%8B)
  - [3.1 Redis高级命令及特性](#31-redis%E9%AB%98%E7%BA%A7%E5%91%BD%E4%BB%A4%E5%8F%8A%E7%89%B9%E6%80%A7)
  - [3.2 Redis的安全性](#32-redis%E7%9A%84%E5%AE%89%E5%85%A8%E6%80%A7)
  - [3.3 主从复制](#33-%E4%B8%BB%E4%BB%8E%E5%A4%8D%E5%88%B6)
  - [补充：防火墙相关操作](#%E8%A1%A5%E5%85%85%E9%98%B2%E7%81%AB%E5%A2%99%E7%9B%B8%E5%85%B3%E6%93%8D%E4%BD%9C)
  - [3.4 哨兵](#34-%E5%93%A8%E5%85%B5)
  - [3.5 Redis简单事务](#35-redis%E7%AE%80%E5%8D%95%E4%BA%8B%E5%8A%A1)
  - [3.6 持久化机制](#36-%E6%8C%81%E4%B9%85%E5%8C%96%E6%9C%BA%E5%88%B6)
  - [3.7 发布与订阅消息](#37-%E5%8F%91%E5%B8%83%E4%B8%8E%E8%AE%A2%E9%98%85%E6%B6%88%E6%81%AF)
  - [3.8 虚拟内存的使用](#38-%E8%99%9A%E6%8B%9F%E5%86%85%E5%AD%98%E7%9A%84%E4%BD%BF%E7%94%A8)
  - [4.0 Java&Redis](#40-javaredis)
  - [5.1 redis 集群的搭建](#51-redis-%E9%9B%86%E7%BE%A4%E7%9A%84%E6%90%AD%E5%BB%BA)
  - [java中操作集群](#java%E4%B8%AD%E6%93%8D%E4%BD%9C%E9%9B%86%E7%BE%A4)
  - [5.2 redis集群相关操作命令](#52-redis%E9%9B%86%E7%BE%A4%E7%9B%B8%E5%85%B3%E6%93%8D%E4%BD%9C%E5%91%BD%E4%BB%A4)
  - [5.3  redis集群水平扩展——增加主从节点](#53--redis%E9%9B%86%E7%BE%A4%E6%B0%B4%E5%B9%B3%E6%89%A9%E5%B1%95%E5%A2%9E%E5%8A%A0%E4%B8%BB%E4%BB%8E%E8%8A%82%E7%82%B9)
  - [5.4 删除主从节点](#54-%E5%88%A0%E9%99%A4%E4%B8%BB%E4%BB%8E%E8%8A%82%E7%82%B9)
  - [6.0 redis3.0集群与spring整合](#60-redis30%E9%9B%86%E7%BE%A4%E4%B8%8Espring%E6%95%B4%E5%90%88)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Redis

## 目录

1.x NOSQL（Redis）简介、Redis安装和部署

2.x Redis基础数据类型详解

3.x Redis高级命令

4.x Redis与JAVA的使用

5.x Redis集群搭建

6.x Redis集群与spring的整合/TomcatRedis的Session共享

7.x Redis与Lua

8.x SSDB使用

9.x Redis + SSDB结合

## 使用过程中发生的问题

redis保存或修改数据出现以下错误：

```bash
(error) MISCONF Redis is configured to save RDB snapshots, but it is currently not able to persist on disk. Commands that may modify the data set are disabled, because this instance is configured to report errors during writes if RDB snapshotting fails (stop-writes-on-bgsave-error option). Please check the Redis logs for details about the RDB error.
```

问题原因：可能是强制停止redis快照导致。

解决方法：打开redis-cli输入以下内容

```bash
127.0.0.1:6379> config set stop-writes-on-bgsave-error no
OK
```

如果是内存问题应该如下办法（具体查看日志）：

```bash
sysctl vm.overcommit_memory=1
```

## 1.1 NOSQL简介

**NoSQL**，泛指**非关系型的数据库**，NoSQL数据库的四大分类：

**键值( Key-Value)存储数据库**：这一类数据库主要会使用到一个哈希表，这个表中有一个特定的键和一个指针指向特定的数据。如 Redis，Voldemort，Oracle BDB。

**列存储数据库**：这部分数据库通常是用来应对分布式存储的海量数据。键仍然存在，但是它们的特点是指向了多个列。如 HBase，Riak。

**文档型数据库**：该类型的数据模型是版本化的文档，半结构化的文档以特定的格式存储，比如JSON。文档型数据库可以看作是键值数据库的升级版，允许之间嵌套键值。而且文档型数据库比键值数据库的查询效率更高。如：CouchDB，MongoDB

**图形（Graph）数据库**：图形结构的数据库同其他行列以及刚性结构的SQL数据库不同，它是使用灵活的图形模型，并且能够扩展到多个服务器上。 NOSQL数据库没有标准的查询语言（SQL），因此进行数据库查询需要制定数据模型。许多 NoSQL数据库都有REST式的数据接口或者查询API。如：Neo4J，InfoGrid，Infinite Graph。

## 1.2 非关系型的数据库特点

1、数据模型比较简单

2、需要灵活性更强的IT系统

3、对数据库性能要求较高

4、不需要高度的数据一致性

5、对于给定key，比较容易映射复杂值的环境

## 1.3 Redis简介

是以**key-value**形式存储，和传统的关系型数据库不一样，不一定遵循传统数据库的一些基本要求（非关系型的、分布式的、开源的。水平可扩展的）

**优点**：

-   对数据高并发读写

-   对海量数据的高效率存储和访问

-   对数据的可扩展性和高可用性

**缺点**：

-   Redis（ACID处理非常简单）

-   无法做到太复杂的关系数据库模型

Redis是以 key-value store存储, data structure service数据结构服务器。键可以包含：（string）字符串，哈希，（list）链表，（set）集合，（zset）有序集合。这些数据集合都支持 push/pop、 add/remove及取交集和并集以及更丰富的操作，Redis支持各种不同的方式排序，为了保证效率，数据都是缓存在内存中，它也可以周期性的把更新的数据写入磁盘或者把修改操作写入追加到文件里。

**redis应用三种形式**：主从（主写从读）、哨兵（宕机重新选举主服务器）、集群（多主从）

## 1.4 Redis的安装

**下载地址**：http://redis.io/download

**安装步骤**：

1、首先需要安装`gcc`，把下载好的redis3.0.0-rc2.tar. gz放到linux `/usr/local` 文件夹下

2、进行解压`tar -zxvf redis-3.0.0-rc2.tar.gz`

3、进入到redis-3.0.0目录下，进行编译`make`

4、进入到src下进行安装` make install`验证（查看src下的目录，有 redis-server、redis-cli即可）

5、建立两个文件夹存放redis命令和配置文件

```bash
mkdir -p /usr/local/redis/etc
mkdir -p /usr/local/redis/bin
```

6、把 redis-3.0.0下的 redis. conf移动到/usr/local/redis/etc下

```bash
cp -f redis.conf /usr/local/redis/etc/
```

7、把redis-3.0.0/src里的 mkreleasehdr. sh、redis-benchmark、redis-check-aof、 redis.check-dump、 redis-cli、 redis-server文件移动到bin下，命令:

```bash
mv mkreleasehdr.sh redis-benchmark redis-check-aof redis-check-dump redis-cli redis-server /usr/local/redis/bin
```

8、启动时并指定配置文件：`/usr/local/redis/bin/redis-server /usr/local/redis/etc/redis.conf`（注意要使用后台启动，所以修改redis.conf里的daemonize改为yes)

10、验证启动是否成功：

查看是否有redis服务：`ps -ef | grep redis`

查看端口： `netstat -tunpl | grep 6379`

进入redis客户端：`./redis-cli`

退出客户端：`quit`

退出redis服务:

-   (1) `pkill redis-server`

-   (2) `pgrep redis-server | xargs -I {} sudo kill -9 {}`

-   (3) `/usr/local/redis/bin/redis-cli shutdown`

**下载redis，编译安装，运行校验**

```bash
##提前准备etc和bin两个目录
mkdir -p /usr/local/redis/etc
mkdir -p /usr/local/redis/bin
##切换到/usr/local/softwares
cd /usr/local/softwares
##删除已有文件，如果存在的话
sudo rm -rf /usr/local/redis-3.0.0 /usr/local/softwares/redis-3.0.0.tar.gz
##下载redis-3.0.0.tar.gz到/usr/local
wget http://download.redis.io/releases/redis-3.0.0.tar.gz
##解压到/usr/local
tar -zxvf /usr/local/softwares/redis-3.0.0.tar.gz -C /usr/local
##切换到/usr/local/redis-3.0.0
cd /usr/local/redis-3.0.0
##编译源代码，开启8线程
make -j 8
##把redis.conf拷贝到/usr/local/redis/etc/
cp -f /usr/local/redis-3.0.0/redis.conf /usr/local/redis/etc/
##切换到/usr/local/redis-3.0.0/src
cd /usr/local/redis-3.0.0/src
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
	source ~/.bashrc
fi
##启动redis-server
echo "-----------redis-server start------------"
/usr/local/redis/bin/redis-server /usr/local/redis/etc/redis.conf
##校验是否存在redis-server后台进程
echo "-----------redis-server process------------"
ps -ef | grep redis
echo "-----------------------"
netstat -tunpl | grep 6379

##关闭redis-server进程
#pgrep redis-server | xargs -I {} sudo kill -9 {}
```

## 2.1 String类型

redis一共分为**五种基本数据类型**：String、Hash、List、set、ZSet 

String类型是包含很多种类型的特殊类型，并且是二进制安全的。比如序列化的对象进行存储，比如一张图片进行二进制存储，比如一个简单的字符串，数值等等。

**set和get方法**：

-   设置值： `set name bhz`（说明设置name多次会覆盖）

-   取值： `get name`
-   删除值：`del name`

**使用 setnx( nx：not exist）**

-   `setnx name`： name如果不存在进行设置，存在就不需要进行设置了，返回0

**使用 setex( ex：expired）**

-   `setex color 10 red`：设置 color的有效期为10秒，10秒后返回（在reds里nil表示空）

**使用 setrange替换字符串**：

-   `set email 174754613@qq.com`：插入email数据

-   `strange email 10 ww `  (10表示从第几位开始替换,后面跟上替换的字符串)

**使用一次性设置多个和获取多个值的mset、mget方法**：

-   `mset key1 jack key2 lili key3 28`
-   对应的`mget key1 key2 key3`方法
-   对应的也有msetnx和mget方法

**一次性设置和取值的getset方法**：

-   `set key4 cc`
-   getset key4 ch 返回旧值并设置新值的方法

**incr和decr方法**：对某一个值进行递增和递减

**incrby和decrby方法**：对某个值进行指定长度的递增和递减

**append [name]方法**：字符串追加方法

**strlen [name]方法**：获取字符串的长度

## 2.2 Hash类型

**Hash类型**是 String类型的field和value的映射表，或者说一个 String集合。它特别适合存储对象，相比较而言，将一个对象类型存储在Hash类型里要比存储在 String类型里占用更少的内存空间，并方便存取整个对象。

形如: `hset myhash field1 hello` ( 含义是**hset**是hash集合, myhash是集合名字，field1是字段名，hello为其值 ) 。也可以存储多个值。

使用 `hget myhash fleld1` **hget** 获取内容。

**hmset**可以进行批量存储多个键值对: `hmset myhash sex nan addr beijing`，也可使用 **hmget**进行批量获取多个键值对。

同样也有 **hsetnx**，和 setnx大同小异。

**hincrby** 和 **hdecrby** 集合递增和递减。

**hexists** 是否存在key，如果存在返回不存在，返回0。

**hlen** 返回hash集合里的所有的键数值。

**hdel** 删除指定hash的field。

**hkeys** 返回hash里所有的字段。

**hvals** 返回hash的所有value。

**hgetall** 返回hash里所有的key和value。

## 2.3 List 类型

**List类型**是一个链表结构的集合，其主要功能有push、pop、获取元素等。更详细的说，List类型是一个**双端链表**的结构，我们可以通过相关操作进行集合的头部或者尾部添加元素删除元素，list的设计非常简单精巧，即可以做为**栈**，又可以作为**队列**。满足绝大多数需求。

**lpush**方法：从头部加入元素（栈），先进后出

```bash
lpush list1 "hello"
lpush list1 "world"
lrange list1 0 -1 ( 表示从头取到尾 )
```

**rpush**方法：

```bash
rpush list2 "beijing"
rpush list2 "haiding"
lrange list2 0 -1
```

**linsert**方法：

```bash
linsert list3 before [集合的元素] [插入的元素]
lpush list3 "one"
lpush list3 "two"
linsert list3 before "one" "three"
lrange list3 0 -1
```

**结果**：

```
1) "two"
2) "three"
3) "one"
```

**lset**方法：将指定下标的元素替换掉

```bash
127.0.0.1:6379> rpush list4 bei
(integer) 1
127.0.0.1:6379> rpush list4 jing
(integer) 2
127.0.0.1:6379> lrange list4 0 -1
1) "bei"
2) "jing"
127.0.0.1:6379> lset list4 0 b
OK
127.0.0.1:6379> lrange list4 0 -1
1) "b"
2) "jing"
```

**lrem**方法：删除元素，返回删除的个数

```bash
127.0.0.1:6379> lrange list4 0 -1
1) "b"
2) "jing"
3) "b"
4) "jing"
5) "b"
127.0.0.1:6379> lrem list4 2 b
(integer) 2
127.0.0.1:6379> lrange list4 0 -1
1) "jing"
2) "jing"
3) "b"
```

**ltrim**方法：保留指定的key的值范围内的数据。

```bash
127.0.0.1:6379> lrange list6 0 -1
1) "one"
2) "two"
3) "three"
4) "four"
127.0.0.1:6379> ltrim list6 2 3
OK
127.0.0.1:6379> lrange list6 0 -1
1) "three"
2) "four"
```

**lpop**方法：从list的头部删除元素，并返回删除元素。

**rpop**方法：从list的尾部删除元素，并返回删除元素。

```bash
127.0.0.1:6379> lrange list7 0 -1
1) "python"
2) "php"
3) "c#"
4) "java"
127.0.0.1:6379> lpop list7
"python"
127.0.0.1:6379> rpop list7
"java"
```

**rpoplpush**方法：第一步从尾部删除元素，然后第二步从头部加入元素。

**index**方法：返回名称为key的list中index位置的元素。

**llen**方法：返回元素的个数。

```bash
127.0.0.1:6379> lrange list8 0 -1
1) "a"
2) "b"
3) "c"
4) "d"
5) "e"
127.0.0.1:6379> rpoplpush list8 list8
"e"
127.0.0.1:6379> lrange list8 0 -1
1) "e"
2) "a"
3) "b"
4) "c"
5) "d"
127.0.0.1:6379> lindex list8 1
"a"
127.0.0.1:6379> llen list8
(integer) 5
```

## 2.4 set类型和zset类型（一）——set类型

**set集合**是string类型的无序集合，set是通过**hashtable**实现的，对集合我们可以取交集、并集、差集。

**sadd**方法：向名称为key的set中添加元素。

-   **小结**：set集合不允许重复元素。

**smembers**方法：查看set集合的元素。

**srem**方法：删除set集合元素。

**spop**方法：随机返回删除的key。

**sdiff**方法：返回两个集合的不同元素（哪个集合在前面就以哪个集合为标准）。

**sdiffstore**方法：将返回的不同元素存储到另外一个集合里。

-   **小结**：这里是把set１和set２的不同元素（以set１为准）存储到set３集合里

```bash
127.0.0.1:6379> sadd set1 c
(integer) 1
127.0.0.1:6379> sadd set1 a
(integer) 1
127.0.0.1:6379> sadd set1 b
(integer) 1
127.0.0.1:6379> smembers set1
1) "c"
2) "b"
3) "a"
127.0.0.1:6379> sadd set2 d
(integer) 1
127.0.0.1:6379> sadd set2 c
(integer) 1
127.0.0.1:6379> sadd set2 b
(integer) 1
127.0.0.1:6379> smembers set2
1) "d"
2) "c"
3) "b"
127.0.0.1:6379> sdiffstore set3 set1 set2
(integer) 1
127.0.0.1:6379> smembers set3
1) "a"
```

**sinter**方法：返回集合的交集。

**sinterstore**方法：返回交集结果，存放set3 中。

```bash
127.0.0.1:6379> smembers set1
1) "a"
2) "b"
3) "c"
127.0.0.1:6379> smembers set2
1) "c"
2) "b"
3) "d"
127.0.0.1:6379> sinter set1 set2
1) "b"
2) "c"
127.0.0.1:6379> sinterstore set3 set1 set2
(integer) 2
127.0.0.1:6379> smembers set3
1) "c"
2) "b"
```

**sunion**方法：取并集。

**sunionstore**方法：取得并集，存入set3中。

```bash
127.0.0.1:6379> sunion set1 set2
1) "a"
2) "d"
3) "c"
4) "b"
127.0.0.1:6379> sunionstore set3 set1 set2
(integer) 4
127.0.0.1:6379> smembers set3
1) "a"
2) "d"
3) "c"
4) "b"
```

**smove**方法：从一个set集合移动到另一个set集合里。

-   小结：将set1中的元素移动到set2中（相当于剪切复制）。

    ```bash
    127.0.0.1:6379> smove set1 set2 a
    (integer) 1
    127.0.0.1:6379> smembers set1
    1) "b"
    2) "c"
    127.0.0.1:6379> smembers set2
    1) "b"
    2) "a"
    3) "d"
    4) "c"
    ```

**scard**方法： 查看集合里元素个数。

**sismember**方法：判断元素是否为集合中的元素

-   小结：返回1代表是集合中的元素，0代表不是。

**srandmember**方法：随机返回一个元素。

```bash
127.0.0.1:6379> scard set2
(integer) 4
127.0.0.1:6379> sismember set2 a
(integer) 1
127.0.0.1:6379> sismember set2 e
(integer) 0
127.0.0.1:6379> srandmember set2
"b"
```

## 2.4 set类型和zset类型（二）——zset类型

**zadd**向有序集合中添加一个元素，该元素如果存在，则更新顺序。

-   **小结**：在重复插入的时候，会根据顺序属性更新

```bash
127.0.0.1:6379> zadd zset1 5 five
(integer) 1
127.0.0.1:6379> zadd zset1 2 two
(integer) 1
127.0.0.1:6379> zadd zset1 3 three
(integer) 1
127.0.0.1:6379> zadd zset1 1 one
(integer) 1
127.0.0.1:6379> zadd zset1 4 four
(integer) 1
127.0.0.1:6379> zrange zset1 0 -1 withscores
 1) "one"
 2) "1"
 3) "two"
 4) "2"
 5) "three"
 6) "3"
 7) "four"
 8) "4"
 9) "five"
10) "5"
```

**zrem**：删除名称为key的zset中的元素member。

```bash
127.0.0.1:6379> zrem zset1 one
(integer) 1
127.0.0.1:6379> zrange zset1 0 -1 withscores
1) "two"
2) "2"
3) "three"
4) "3"
5) "four"
6) "4"
7) "five"
8) "5"
```

**zincrby**：以指定值去自动递增或者减少，用法与之前的incrby类似。

**zrangebyscore**：找到指定区间范围的数据进行返回。

**zremrangebyrank**：删除1到1（只删除索引1）。

**zremrangebyscore**：删除指定序号。

**zrank**：返回排序索引，从小到大顺序（升序排序之后再找索引）。

-   **注意**：一个是顺序号，一个是索引，zrank返回的是索引。

```bash
127.0.0.1:6379> zrange zset1 0 -1 withscores
1) "two"
2) "2"
3) "three"
4) "3"
5) "four"
6) "4"
7) "five"
8) "5"
127.0.0.1:6379> zrank zset1 four
(integer) 2
127.0.0.1:6379> zrank zset1 two
(integer) 0
```

**zrevrank**：返回排序索引，从大到小排序（降序排序之后再找索引）。

**zrangebyscore**：找到指定范围的数据进行返回。

```bash
127.0.0.1:6379> zrangebyscore zset1 0 3 withscores
1) "two"
2) "2"
3) "three"
4) "3"
```

**zcard**：返回集合里所有元素的个数。

```bash
127.0.0.1:6379> zrange zset1 0 -1 withscores
1) "two"
2) "2"
3) "three"
4) "3"
5) "four"
6) "4"
7) "five"
8) "5"
127.0.0.1:6379> zcard zset1
(integer) 4
```

**zcount**：返回集合中score在给定区间中的数量。

```bash
127.0.0.1:6379> zrange zset1 0 -1 withscores
1) "two"
2) "2"
3) "three"
4) "3"
5) "four"
6) "4"
7) "five"
8) "5"
127.0.0.1:6379> zcount zset1 1 4
(integer) 3
```

`zremrangebyrank zset [from] [to]` (删除索引)

```bash
127.0.0.1:6379> zrange zset1 0 -1 withscores
1) "two"
2) "2"
3) "three"
4) "3"
5) "four"
6) "4"
7) "five"
8) "5"
127.0.0.1:6379> zremrangebyrank zset1 0 1
(integer) 2
127.0.0.1:6379> zrange zset1 0 -1 withscores
1) "four"
2) "4"
3) "five"
4) "5"
```

`zremrangebyscore zset [from] [to]` (删除指定序号)

```bash
127.0.0.1:6379> zrange zset1 0 -1 withscores
1) "four"
2) "4"
3) "five"
4) "5"
127.0.0.1:6379> zremrangebyscore zset1 5 5
(integer) 1
127.0.0.1:6379> zrange zset1 0 -1 withscores
1) "four"
2) "4"
```

## 3.1 Redis高级命令及特性

**keys [pattern]**：返回满足的所有键`keys *`（可以模糊匹配）。

**exists key**：是否存在指定的key。

**expire key [n秒]**：设置某个key的过期时间，使用ttl查看剩余时间。

**persist key **：取消过期时间。

**select [数据库下标]**：选择数据库，数据库为0到15（一共16个数据库），默认进入的是0数据库。

**move [key] [数据库下标]**：将当前数据中的key转移到其他数据库中。

**randomkey**：随机返回数据库里的一个key。

**rename 旧键值 新键值**：重命名key。

**echo**：打印命令。

**dbsize**：查看数据库的key数量。

**info**：获取数据库信息。

**config get**：实时接收到的请求（返回相关的配置信息）。

**config get ***：返回所有配置。

**flushdb**：清空当前数据库。

**flushall**：清空所有数据库。

## 3.2 Redis的安全性

因为redis速度相当快，所在在一台比较好的服务器下，一个外部用户在一秒内可以进行15万次的密码尝试，这意味着你需要设定非常强大的密码来防止暴力破解。

vi编辑**redis.conf**文件，找到下面进行保存修改

```bash
#requirepass foobared
requirepass 123456
```

重启服务器：pkill redis-server，再次进入

```bash
127.0.0.1:6379> keys *
(error) NOAUTH Authentication required.
```

会发现没有权限进行查询。

```bash
127.0.0.1:6379> auth 123456
OK
```

OK，输入密码则成功进入。

每次进入的时候都要输入密码，还有种简单的方式，可以避免这种麻烦：

```bash
redis-cli -a 123456
```

**注意**：这种方式会把密码记录在history中，所以不是安全的做法，练习时可以使用，实际应用不能使用。

## 3.3 主从复制

**主从复制**：

1、Master可以拥有多个slave。

2、多个slave可以连接同一个 master外，还可以连接到其他的slave。

3、主从复制不会阻塞 master，在同步数据时，master可以继续处理client请求。

4、提供系统的伸缩性。

**主从复制过程**：

1、slave和Master建立连接，发送sync同步命令。

2、master会开启一个后台进程，将数据库快照保存到文件中，同时master主进程会开始收集新的写命令并缓存。

3、后台完成保存后，就将文件发送给slave。

4、slave将此文件保存到硬盘上。

**主从复制配置**：

-   **本地测试，要先关闭防火墙，不然设置不生效**：

```bash
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0
systemctl stop firewalld
systemctl disable firewalld
```

-   **clone服务器之后修改slave的IP地址**
    -   修改配置文件：`/usr/local/redis/etc/redis.conf`
    -   第一步：`slaveof <masterip> <masterport>`
    -   第二步：`masterauth <master-password>`
    -   使用info查看role角色可知道是主服务或从服务。

**备注：不同服务器之间远程拷贝命令**

```bash
scp -r /usr/local/redis 192.168.0.12:/usr/local
```

## 补充：防火墙相关操作

-   启动： systemctl start firewalld
-   关闭： systemctl stop firewalld
-   查看状态： systemctl status firewalld 
-   开机禁用 ： systemctl disable firewalld
-   开机启用 ： systemctl enable firewalld
-   重启防火墙： service firewalld restart

**实际生产使用则应配置服务器开放指定端口**

```bash
firewall-cmd --zone=public --add-port=6379/tcp --permanent
firewall-cmd --zone=public --add-port=4400-4600/udp --permanen(指定端口范围为4400-4600通过防火墙)
重新载入：firewall-cmd --reload（端口开启之后需重新加载）
查看：firewall-cmd --zone= public --query-port=80/tcp
关闭：firewall-cmd --zone= public --remove-port=80/tcp --permanent
查看通过的端口：firewall-cmd --zone=public --list-ports
```

## 3.4 哨兵

有了主从复制的实现以后，我们如果想对主从服务器进行监控，那么在redis2.6以后提供了一个哨兵机制，在2.6版本中的哨兵为1.0版本，并不稳定，会出现各种各样的问题。在2.8以后的版本哨兵功能才稳定下来。

顾名思义，哨兵的含义就是监控redis系统的运行状况。其**主要功能**有两点：

1、监控主数据库和从数据库是否正常运行。

2、主数据库出现故障时，可以自动将从数据库转换为主数据库， 实现自动切换。

**实现步骤**：在其中一台从服务器配置**sentinel.conf**。

1、copy文件sentinel.conf到/usr/local/redis/etc中。

```bash
cp /usr/local/redis-3.0.0/sentinel.conf /usr/local/redis/etc/
```

2、修改sentinel.conf文件

```bash
vim /usr/local/redis/etc/sentinel.conf
sentinel monitor mymaster 192.168.0.12 6379 2 #名称、IP、端口、投票选举次数
sentinel down-after-milliseconds mymaster 5000 #默认1s检测一次，这里配置超时5s为宕机
sentinel failover-timeout mymaster 180000
sentinel parallel-syncs mymaster 2
sentinel can-failover mymaster yes
```

3、启动哨兵

```bash
/usr/local/redis/bin/redis-server /usr/local/redis/etc/sentinel.conf --sentinel &
```

4、查看哨兵相关信息命令

```bash
/usr/local/redis/bin/redis-cli -h 192.168.0.12 -p 26379 info Sentinel
```

5、关闭主服务器查看集群信息

```bash
/usr/local/redis/bin/redis-cli -h 192.168.0.11 -p 6379 shutdown
```

## 3.5 Redis简单事务

redis的事物非常简单，使用方法如下：

首先是使用multi方法打开事务，然后进行设置，这时设置的数据都会放入队列里进行保存，最后使用exec执行，把数据依次存储到redis中，使用discard方法取消事务。

**示例：使用exec执行，把数据依次存储到redis中**

```bash
127.0.0.1:6379> multi
OK
127.0.0.1:6379> set p1 1
QUEUED
127.0.0.1:6379> set p2 2
QUEUED
127.0.0.1:6379> set p3 3
QUEUED
127.0.0.1:6379> exec
1) OK
2) OK
3) OK
127.0.0.1:6379> keys p*
1) "p1"
2) "p2"
3) "p3"
```

**示例：使用discard方法取消事务**

```bash
127.0.0.1:6379> multi
OK
127.0.0.1:6379> set p4 4
QUEUED
127.0.0.1:6379> set p5 5
QUEUED
127.0.0.1:6379> discard
OK
127.0.0.1:6379> keys p*
1) "p1"
2) "p2"
3) "p3"
```

**redis的事务不能保证同时成功或失败进行提交和回滚**，所以redis的事务目前还是比较简单的。

```bash
127.0.0.1:6379> get name
"jack"
127.0.0.1:6379> get age
"20"
127.0.0.1:6379> multi
OK
127.0.0.1:6379> incr age
QUEUED
127.0.0.1:6379> incr name
QUEUED
127.0.0.1:6379> exec
1) (integer) 21
2) (error) ERR value is not an integer or out of range
```

## 3.6 持久化机制

redis是一个支持持久化的内存数据库，也就是说redis需要经常将内存中的数据同步到硬盘来保证持久化。

redis持久化的两种方式：

1、**snapshotting**（快照）默认方式，交内存中以快照的方式写入到二进制文件中，默认为**dump.rdb**。可以通过配置设置自动做快照持久化的方式。我们可以配置redis在n秒内如果超过m个key则修改就会自动做快照。

**snapshotting设置**：

```bash
save 900 1 #900秒内如果超过1个key被修改，则发起快照保存
save 300 10 #300秒内如果超过10个key被修改，则发起快照保存
save 60 10000
```

2、**append-only  file**（缩写aof）的方式（有点类似oracle日志），由于快照方式是在一定时间间隔做一次，所以可能发生redis意外down的情况，就会丢失最后一次快照后的所有修改的数据，aof比快照方式有更好的持久性，是由于在使用aof时，redis会将每一个写命令都通过write函数追加到命令中，当redis重新启动时会重新执行文件中保存的写命令来在内存中重建这个数据库的内容，这个文件在bin目录下：**appendonly.aof**。aof不是立即写到硬盘上，可以通过配置文件强制写到硬盘中。

**aof设置**：

```bash
appendonly yes #启动aof持久化方式的有三种修改方式：
appendfsync always #收到写命令就立即写入磁盘，效率最慢，但是保证完全的持久化
appendfsync everysec #每秒写入磁盘一次，在性能和持久化方面做了很好的中和
appendfsync no #完全依赖os，性能最好，持久化没保证
```

## 3.7 发布与订阅消息

redis提供了简单的发布订阅功能。

使用`subscribe [频道]`进行订阅监听。

使用`publish [频道] [发布内容]`进行发布消息广播

通常用于集群时发布通知给各个机器

```bash
#假设这是在slave节点上执行
subscribe notification
#假设这是在master节点上执行，则各个slave节点会收到通知
publish notification "update after 10 minutes." 
#收到通知后的结果如下
127.0.0.1:6379> subscribe notification
Reading messages... (press Ctrl-C to quit)
1) "subscribe"
2) "notification"
3) (integer) 1
1) "message"
2) "notification"
3) "update after 10 minutes."
```

## 3.8 虚拟内存的使用

redis会暂时把不经常访问的数据从内存交换到磁盘中，腾出宝贵的空间，用于其他需要访问的数据，这需要对vm进行相关配置。（**3.0版本是不带VM特性的，配置无效！**）

修改配置文件：redis.conf

```bash
#开启vm功能
vm-enabled yes
#交换处理的value保存的文件路径
vm-swap-file /tmp/redis.swap
#redis使用的最大内存上限
vm-max-memory 1000000
#每个页面的大小32个字节
vm-page-size 32
#最多使用多少页面
vm-pages 134217728
#用于执行value对象换入缓存的工作线程数量
vm-max-threads 4
```

重新启动服务，会弹出是否启用虚拟内存。

把提示信息中的`really-use-vm yes`粘贴到redis.conf下即可，然后重启服务。

## 4.0 Java&Redis

**jedis**就是redis支持java的第三方类库，我们可以使用jedis类库操作redis数据库。大体上在3.0之前，我们使用jedis操作redis数据api比较全面，但是目前java第三方可用库更新比较慢，不太全面，目前最新的jedis2.7版本才支持集群操作，不过有些方法也不支持。

**基本操作示例**：

```java
public class testRedis {
    private static Jedis jedis = new Jedis("192.168.0.12", 6379);

    @Test
    public void test() {
        jedis.set("sex", "man");
        System.out.println(jedis);

        List<String> list = jedis.mget("name", "age", "sex");
        for (Iterator iterator = list.iterator(); iterator.hasNext();) {
            String string = (String) iterator.next();
            System.out.println(string);
        }

        Map<String, String> user = new HashMap<String, String>();
        user.put("name", "huangyuxuan");
        user.put("age", "0.5");
        user.put("sex", "男");
        jedis.hmset("user", user);
        List<String> rsmap = jedis.hmget("user", "name", "age", "sex");
        System.out.println(rsmap);

        jedis.hdel("user", "age");
        System.out.println(jedis.hmget("user", "age")); // 因为删除了，所以返回的是null
        System.out.println(jedis.hlen("user")); // 返回key为user的键中存放的值的个数2
        System.out.println(jedis.exists("user"));// 是否存在key为user的记录 返回true
        System.out.println(jedis.hkeys("user"));// 返回map对象中的所有key
        System.out.println(jedis.hvals("user"));// 返回map对象中的所有value

        Iterator<String> iter = jedis.hkeys("user").iterator();
        while (iter.hasNext()) {
            String key = iter.next();
            System.out.println(key + ":" + jedis.hmget("user", key));
        }
    }

    @Test
    public static void testStr() {
        // -----添加数据----------
        jedis.set("name", "bhz");// 向key-->name中放入了value-->xinxin
        System.out.println(jedis.get("name"));// 执行结果：xinxin

        jedis.append("name", " is my lover"); // 拼接
        System.out.println(jedis.get("name"));

        jedis.del("name"); // 删除某个键
        System.out.println(jedis.get("name"));
        // 设置多个键值对
        jedis.mset("name", "bhz", "age", "27", "qq", "174754613");
        jedis.incr("age"); // 进行加1操作
        System.out.println(jedis.get("name") + "-" + jedis.get("age") + "-" + jedis.get("qq"));

    }

    @Test
    public static void testList() {
        // 开始前，先移除所有的内容
        jedis.del("java framework");
        System.out.println(jedis.lrange("java framework", 0, -1));
        // 先向key java framework中存放三条数据
        jedis.lpush("java framework", "spring");
        jedis.lpush("java framework", "struts");
        jedis.lpush("java framework", "hibernate");
        // 再取出所有数据jedis.lrange是按范围取出，
        // 第一个是key，第二个是起始位置，第三个是结束位置，jedis.llen获取长度 -1表示取得所有
        System.out.println(jedis.lrange("java framework", 0, -1));

        jedis.del("java framework");
        jedis.rpush("java framework", "spring");
        jedis.rpush("java framework", "struts");
        jedis.rpush("java framework", "hibernate");
        System.out.println(jedis.lrange("java framework", 0, -1));
    }

    @Test
    public static void testSet() {
        // 添加
        jedis.sadd("user1", "liuling");
        jedis.sadd("user1", "xinxin");
        jedis.sadd("user1", "ling");
        jedis.sadd("user1", "zhangxinxin");
        jedis.sadd("user1", "who");
        // 移除noname
        jedis.srem("user1", "who");
        System.out.println(jedis.smembers("user1"));// 获取所有加入的value
        System.out.println(jedis.sismember("user1", "who"));// 判断 who 是否是user集合的元素
        System.out.println(jedis.srandmember("user1"));
        System.out.println(jedis.scard("user1"));// 返回集合的元素个数
    }
}
```

**单节点和共享池测试**：

```java
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.pool2.impl.GenericObjectPoolConfig;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisShardInfo;
import redis.clients.jedis.Pipeline;
import redis.clients.jedis.ShardedJedis;
import redis.clients.jedis.ShardedJedisPipeline;
import redis.clients.jedis.ShardedJedisPool;
import redis.clients.jedis.Transaction;

public class TestSingleRedis {

    // 1、单独连接一台redis服务器
    private static Jedis jedis;
    // 2、主从、哨兵用shard
    private static ShardedJedis shard;
    // 3、连接池（10 jedis）
    private static ShardedJedisPool pool;

    @BeforeClass
    public static void setUpBeforeClass() throws Exception {
        // 单个节点
        jedis = new Jedis("192.168.0.12", 6379);

        // 分片
        List<JedisShardInfo> shards = Arrays.asList(new JedisShardInfo("192.168.0.12", 6379));
        shard = new ShardedJedis(shards);

        GenericObjectPoolConfig goConfig = new GenericObjectPoolConfig();
        goConfig.setMaxTotal(100);
        goConfig.setMaxIdle(20);
        goConfig.setMaxWaitMillis(-1);
        goConfig.setTestOnBorrow(true);
        pool = new ShardedJedisPool(goConfig, shards);
    }

    @AfterClass
    public static void tearDownAfterClass() throws Exception {
        jedis.disconnect();
        shard.disconnect();
        pool.destroy();
    }

    @Test
    public void testString() {
        // -----添加数据----------
        jedis.set("name", "bhz");// 向key-->name中放入了value-->xinxin
        System.out.println(jedis.get("name"));// 执行结果：xinxin

        jedis.append("name", " is my lover"); // 拼接
        System.out.println(jedis.get("name"));

        jedis.del("name"); // 删除某个键
        System.out.println(jedis.get("name"));
        // 设置多个键值对
        jedis.mset("name", "bhz", "age", "27", "qq", "174754613");
        jedis.incr("age"); // 进行加1操作
        System.out.println(jedis.get("name") + "-" + jedis.get("age") + "-" + jedis.get("qq"));
    }

    /**
     * redis操作Map
     */
    @Test
    public void testMap() {
        // -----添加数据----------
        Map<String, String> map = new HashMap<String, String>();
        map.put("name", "xinxin");
        map.put("age", "22");
        map.put("qq", "123456");
        jedis.hmset("user", map);
        // 取出user中的name，执行结果:[minxr]-->注意结果是一个泛型的List
        // 第一个参数是存入redis中map对象的key，后面跟的是放入map中的对象的key，后面的key可以跟多个，是可变参数
        List<String> rsmap = jedis.hmget("user", "name", "age", "qq");
        System.out.println(rsmap);
        // 删除map中的某个键值
        jedis.hdel("user", "age");
        System.out.println(jedis.hmget("user", "age")); // 因为删除了，所以返回的是null
        System.out.println(jedis.hlen("user")); // 返回key为user的键中存放的值的个数2
        System.out.println(jedis.exists("user"));// 是否存在key为user的记录 返回true
        System.out.println(jedis.hkeys("user"));// 返回map对象中的所有key
        System.out.println(jedis.hvals("user"));// 返回map对象中的所有value

        Iterator<String> iter = jedis.hkeys("user").iterator();
        while (iter.hasNext()) {
            String key = iter.next();
            System.out.println(key + ":" + jedis.hmget("user", key));
        }
    }

    /**
     * jedis操作List
     */
    @Test
    public void testList() {
        // 开始前，先移除所有的内容
        jedis.del("java framework");
        System.out.println(jedis.lrange("java framework", 0, -1));
        // 先向key java framework中存放三条数据
        jedis.lpush("java framework", "spring");
        jedis.lpush("java framework", "struts");
        jedis.lpush("java framework", "hibernate");
        // 再取出所有数据jedis.lrange是按范围取出，
        // 第一个是key，第二个是起始位置，第三个是结束位置，jedis.llen获取长度 -1表示取得所有
        System.out.println(jedis.lrange("java framework", 0, -1));

        jedis.del("java framework");
        jedis.rpush("java framework", "spring");
        jedis.rpush("java framework", "struts");
        jedis.rpush("java framework", "hibernate");
        System.out.println(jedis.lrange("java framework", 0, -1));
    }

    /**
     * jedis操作Set
     */
    @Test
    public void testSet() {
        // 添加
        jedis.sadd("user", "liuling");
        jedis.sadd("user", "xinxin");
        jedis.sadd("user", "ling");
        jedis.sadd("user", "zhangxinxin");
        jedis.sadd("user", "who");
        // 移除noname
        jedis.srem("user", "who");
        System.out.println(jedis.smembers("user"));// 获取所有加入的value
        System.out.println(jedis.sismember("user", "who"));// 判断 who 是否是user集合的元素
        System.out.println(jedis.srandmember("user"));
        System.out.println(jedis.scard("user"));// 返回集合的元素个数
    }

    @Test
    public void testRLpush() throws InterruptedException {
        // jedis 排序
        // 注意，此处的rpush和lpush是List的操作。是一个双向链表（但从表现来看的）
        jedis.del("a");// 先清除数据，再加入数据进行测试
        jedis.rpush("a", "1");
        jedis.lpush("a", "6");
        jedis.lpush("a", "3");
        jedis.lpush("a", "9");
        System.out.println(jedis.lrange("a", 0, -1));// [9, 3, 6, 1]
        System.out.println(jedis.sort("a")); // [1, 3, 6, 9] //输入排序后结果
        System.out.println(jedis.lrange("a", 0, -1));
    }

    @Test
    public void testTrans() {
        long start = System.currentTimeMillis();
        Transaction tx = jedis.multi();
        for (int i = 0; i < 1000; i++) {
            tx.set("t" + i, "t" + i);
        }
        // System.out.println(tx.get("t1000").get());

        List<Object> results = tx.exec();
        long end = System.currentTimeMillis();
        System.out.println("Transaction SET: " + ((end - start) / 1000.0) + " seconds");
    }

    @Test
    public void testPipelined() {
        Pipeline pipeline = jedis.pipelined();
        long start = System.currentTimeMillis();
        for (int i = 0; i < 1000; i++) {
            pipeline.set("p" + i, "p" + i);
        }
        // System.out.println(pipeline.get("p1000").get());
        List<Object> results = pipeline.syncAndReturnAll();
        long end = System.currentTimeMillis();
        System.out.println("Pipelined SET: " + ((end - start) / 1000.0) + " seconds");
    }

    @Test
    public void testPipelineTrans() {
        long start = System.currentTimeMillis();
        Pipeline pipeline = jedis.pipelined();
        pipeline.multi();
        for (int i = 0; i < 100000; i++) {
            pipeline.set("" + i, "" + i);
        }
        pipeline.exec();
        List<Object> results = pipeline.syncAndReturnAll();
        long end = System.currentTimeMillis();
        System.out.println("Pipelined transaction SET: " + ((end - start) / 1000.0) + " seconds");
    }

    @Test
    public void testShard() {
        long start = System.currentTimeMillis();
        for (int i = 0; i < 100000; i++) {
            String result = shard.set("shard" + i, "n" + i);
        }
        long end = System.currentTimeMillis();
        System.out.println("shard SET: " + ((end - start) / 1000.0) + " seconds");
    }

    @Test
    public void testShardpipelined() {
        ShardedJedisPipeline pipeline = shard.pipelined();
        long start = System.currentTimeMillis();
        for (int i = 0; i < 100000; i++) {
            pipeline.set("sp" + i, "p" + i);
        }
        List<Object> results = pipeline.syncAndReturnAll();
        long end = System.currentTimeMillis();
        System.out.println("shardPipelined SET: " + ((end - start) / 1000.0) + " seconds");
    }

    @Test
    public void testShardPool() {
        ShardedJedis sj = pool.getResource();

        long start = System.currentTimeMillis();
        for (int i = 0; i < 100000; i++) {
            String result = sj.set("spn" + i, "n" + i);
        }
        long end = System.currentTimeMillis();
        pool.returnResource(sj);
        System.out.println("shardPool SET: " + ((end - start) / 1000.0) + " seconds");
    }

}
```

## 5.1 redis 集群的搭建

在redis3.0以前，提供了sentinel工具来监控各master的状态，如果master异常，则会做主从切换，交slave作为master，将master作为slave。其配置也是稍微的复杂，并且各方面表现一般。现在redis3.0已经支持集群的容错功能，并且非常简单。下面我们来进行学习下redis3.0如何搭建集群。

集群搭建：至少要三个master

**第一步**：创建一个文件夹redis-cluster，然后在其下面分别创建6个文件夹，如下：

```bash
mkdir -p /usr/local/redis-cluster
cd /usr/local/redis-cluster
mkdir 7001 7002 7003 7004 7005 7006
```

**第二步**：把之前的redis.conf配置文件分别copy到700x下，进行修改各个文件内容，也就是对700x下的每一个copy的redis.conf文件进行修改！如下：

1、daemonize yes

2、port 700x（分别对每个机器的端口号进行设置）

3、bind 192.168.0.12（必须要绑定当前机器的ip，不然会无限悲剧下去，深坑勿入！！！）

4、dir /usr/local/redis-cluster/700x/（指定数据文件存放位置，必须要指定不同的目录位置，不然会丢失数据，深坑勿入！！！）

5、cluster-enabled yes（启动集群模式，开始玩耍）

6、cluster-config-file nodes–700x.conf（这里700x最好和port对应上）

7、cluster-node-timeout 5000

8、appendonly yes

```bash
#7001
cp -f /usr/local/redis-3.0.0/redis.conf /usr/local/redis-cluster/7001
sed -i 's/daemonize no/daemonize yes/g' /usr/local/redis-cluster/7001/redis.conf
sed -i 's/port 6379/port 7001/g' /usr/local/redis-cluster/7001/redis.conf
sed -i 's/\# bind 127.0.0.1/bind 192.168.0.12/g' /usr/local/redis-cluster/7001/redis.conf
sed -i 's/dir \.\//dir \/usr\/local\/redis-cluster\/7001/g' /usr/local/redis-cluster/7001/redis.conf
sed -i 's/\# cluster-enabled yes/cluster-enabled yes/g' /usr/local/redis-cluster/7001/redis.conf
sed -i 's/\# cluster-config-file nodes-6379.conf/cluster-config-file nodes-7001.conf/g' /usr/local/redis-cluster/7001/redis.conf
sed -i 's/# cluster-node-timeout 15000/cluster-node-timeout 5000/g' /usr/local/redis-cluster/7001/redis.conf
sed -i 's/appendonly no/appendonly yes/g' /usr/local/redis-cluster/7001/redis.conf

#7002
cp -f /usr/local/redis-cluster/7001/redis.conf /usr/local/redis-cluster/7002
sed -i 's/7001/7002/g' /usr/local/redis-cluster/7002/redis.conf

#7003
cp -f /usr/local/redis-cluster/7001/redis.conf /usr/local/redis-cluster/7003
sed -i 's/7001/7003/g' /usr/local/redis-cluster/7003/redis.conf

#7004
cp -f /usr/local/redis-cluster/7001/redis.conf /usr/local/redis-cluster/7004
sed -i 's/7001/7004/g' /usr/local/redis-cluster/7004/redis.conf

#7005
cp -f /usr/local/redis-cluster/7001/redis.conf /usr/local/redis-cluster/7005
sed -i 's/7001/7005/g' /usr/local/redis-cluster/7005/redis.conf

#7006
cp -f /usr/local/redis-cluster/7001/redis.conf /usr/local/redis-cluster/7006
sed -i 's/7001/7006/g' /usr/local/redis-cluster/7006/redis.conf
```

**第三步**：把修改后的配置文件，分别copy到各个文件夹下，注意每个文件要修改端口号，并且nodes文件也要不相同！

**第四步**：由于redis集群需要使用ruby命令，所以我们需要安装ruby。

```bash
yum install -y ruby ruby-devel rubygems rpm-build
#安装ruby2.3版本，用yum安装的是2.0版本，执行gem install redis会报错
wget https://ruby.taobao.org/mirrors/ruby/ruby-2.3.0.tar.gz --no-check-certificate
tar zxvf ruby-2.3.0.tar.gz
cd ruby-2.3.0
./configure && make -j 4 && make install
#安装redis和ruby的接口
gem install redis
```

RVM实用指南：https://ruby-china.org/wiki/rvm-guide

**第五步**：分别启动6个实例，然后检查是否启动成功。

```bash
/usr/local/redis/bin/redis-server /usr/local/redis-cluster/7001/redis.conf
/usr/local/redis/bin/redis-server /usr/local/redis-cluster/7002/redis.conf
/usr/local/redis/bin/redis-server /usr/local/redis-cluster/7003/redis.conf
/usr/local/redis/bin/redis-server /usr/local/redis-cluster/7004/redis.conf
/usr/local/redis/bin/redis-server /usr/local/redis-cluster/7005/redis.conf
/usr/local/redis/bin/redis-server /usr/local/redis-cluster/7006/redis.conf
#检查是否启动成功
ps -ef | grep redis
```

**第六步**：首先到redis3.0的安装目录下，然后执行redis-trib.rb命令。

```bash
cd /usr/local/redis-3.0.0/src
./redis-trib.rb create --replicas 1 192.168.0.12:7001 192.168.0.12:7002 192.168.0.12:7003 192.168.0.12:7004 192.168.0.12:7005 192.168.0.12:7006
```

**执行成功后，显示结果如下**：

```bash
>>> Creating cluster
Connecting to node 192.168.0.12:7001: OK
Connecting to node 192.168.0.12:7002: OK
Connecting to node 192.168.0.12:7003: OK
Connecting to node 192.168.0.12:7004: OK
Connecting to node 192.168.0.12:7005: OK
Connecting to node 192.168.0.12:7006: OK
>>> Performing hash slots allocation on 6 nodes...
Using 3 masters:
192.168.0.12:7001
192.168.0.12:7002
192.168.0.12:7003
Adding replica 192.168.0.12:7004 to 192.168.0.12:7001
Adding replica 192.168.0.12:7005 to 192.168.0.12:7002
Adding replica 192.168.0.12:7006 to 192.168.0.12:7003
M: 2eecf57e5ac53a2e66ef17e728d91fd90e1aac2f 192.168.0.12:7001
   slots:0-5460 (5461 slots) master
M: 0e0f984050ee6e299d3da05a6692cf3091e310f9 192.168.0.12:7002
   slots:5461-10922 (5462 slots) master
M: 0b8761fa2a2504ff262570c792736cae13e6bed7 192.168.0.12:7003
   slots:10923-16383 (5461 slots) master
S: 4fb4a00c15629d4c9663a512ee62df43e25255a5 192.168.0.12:7004
   replicates 2eecf57e5ac53a2e66ef17e728d91fd90e1aac2f
S: 40694d735b2b46fd9a195e45b5f236b3f6d5ca00 192.168.0.12:7005
   replicates 0e0f984050ee6e299d3da05a6692cf3091e310f9
S: f7a141b1dca35115931869fe4250a4c766dcd88c 192.168.0.12:7006
   replicates 0b8761fa2a2504ff262570c792736cae13e6bed7
Can I set the above configuration? (type 'yes' to accept): yes
>>> Nodes configuration updated
>>> Assign a different config epoch to each node
>>> Sending CLUSTER MEET messages to join the cluster
Waiting for the cluster to join....
>>> Performing Cluster Check (using node 192.168.0.12:7001)
M: 2eecf57e5ac53a2e66ef17e728d91fd90e1aac2f 192.168.0.12:7001
   slots:0-5460 (5461 slots) master
M: 0e0f984050ee6e299d3da05a6692cf3091e310f9 192.168.0.12:7002
   slots:5461-10922 (5462 slots) master
M: 0b8761fa2a2504ff262570c792736cae13e6bed7 192.168.0.12:7003
   slots:10923-16383 (5461 slots) master
M: 4fb4a00c15629d4c9663a512ee62df43e25255a5 192.168.0.12:7004
   slots: (0 slots) master
   replicates 2eecf57e5ac53a2e66ef17e728d91fd90e1aac2f
M: 40694d735b2b46fd9a195e45b5f236b3f6d5ca00 192.168.0.12:7005
   slots: (0 slots) master
   replicates 0e0f984050ee6e299d3da05a6692cf3091e310f9
M: f7a141b1dca35115931869fe4250a4c766dcd88c 192.168.0.12:7006
   slots: (0 slots) master
   replicates 0b8761fa2a2504ff262570c792736cae13e6bed7
[OK] All nodes agree about slots configuration.
>>> Check for open slots...
>>> Check slots coverage...
[OK] All 16384 slots covered.
```

**可以看出主从关系为**：

```bash
主7001从7004
主7002从7005
主7003从7006
```

**第七步**：到此为止我们集群搭建成功！进行验证：

1、连接任意一个客户端即可：

```bash
#-c表示集群模式，-h指定ip，-p指定端口
/usr/local/redis/bin/redis-cli -c -h [ip] -p [port]

/usr/local/redis/bin/redis-cli -c -h 192.168.0.12 -p 7001
/usr/local/redis/bin/redis-cli -c -h 192.168.0.12 -p 7002
/usr/local/redis/bin/redis-cli -c -h 192.168.0.12 -p 7003
/usr/local/redis/bin/redis-cli -c -h 192.168.0.12 -p 7004
/usr/local/redis/bin/redis-cli -c -h 192.168.0.12 -p 7005
/usr/local/redis/bin/redis-cli -c -h 192.168.0.12 -p 7006
```

2、进行验证：

```bash
#查看集群信息
cluster info
#查看节点列表
cluster nodes
```

3、进行数据操作验证

4、关闭集群则需要逐个关闭，使用命令：

```
/usr/local/redis/bin/redis-cli -c -h 192.168.0.12 -p 7001 shutdown
/usr/local/redis/bin/redis-cli -c -h 192.168.0.12 -p 7002 shutdown
/usr/local/redis/bin/redis-cli -c -h 192.168.0.12 -p 7003 shutdown
/usr/local/redis/bin/redis-cli -c -h 192.168.0.12 -p 7004 shutdown
/usr/local/redis/bin/redis-cli -c -h 192.168.0.12 -p 7005 shutdown
/usr/local/redis/bin/redis-cli -c -h 192.168.0.12 -p 7006 shutdown
```

**第八步**：（补充）

友情提示：当出现集群无法启动时，删除临时的数据文件，再次重新启动每一个redis服务，然后重新构造集群环境。

redis-trib.rb官方操作命令：http://redis.io/topics/cluster-tutorial

推荐博客：http://blog.51yip.com/nosql/1726.html/comment-page-1

## java中操作集群

```java
import java.util.HashSet;
import java.util.Set;

import redis.clients.jedis.HostAndPort;
import redis.clients.jedis.JedisCluster;
import redis.clients.jedis.JedisPoolConfig;

public class TestClusterRedis {
    public static void main(String[] args) {
        Set<HostAndPort> jedisClusterNode = new HashSet<HostAndPort>();
        jedisClusterNode.add(new HostAndPort("192.168.0.12", 7001));
        jedisClusterNode.add(new HostAndPort("192.168.0.12", 7002));
        jedisClusterNode.add(new HostAndPort("192.168.0.12", 7003));
        jedisClusterNode.add(new HostAndPort("192.168.0.12", 7004));
        jedisClusterNode.add(new HostAndPort("192.168.0.12", 7005));
        jedisClusterNode.add(new HostAndPort("192.168.0.12", 7006));
        // GenericObjectPoolConfig goConfig = new GenericObjectPoolConfig();
        // JedisCluster jc = new JedisCluster(jedisClusterNode,2000,100, goConfig);
        JedisPoolConfig cfg = new JedisPoolConfig();
        cfg.setMaxTotal(100);
        cfg.setMaxIdle(20);
        cfg.setMaxWaitMillis(-1);
        cfg.setTestOnBorrow(true);
        JedisCluster jc = new JedisCluster(jedisClusterNode, 6000, 1000, cfg);

        System.out.println(jc.set("age", "20"));
        System.out.println(jc.set("sex", "男"));
        System.out.println(jc.get("name"));
        System.out.println(jc.get("name"));
        System.out.println(jc.get("name"));
        System.out.println(jc.get("name"));
        System.out.println(jc.get("name"));
        System.out.println(jc.get("name"));
        System.out.println(jc.get("name"));
        System.out.println(jc.get("name"));
        System.out.println(jc.get("age"));
        System.out.println(jc.get("sex"));
        jc.close();
    }
}
```

## 5.2 redis集群相关操作命令

```bash
//集群(cluster)  
CLUSTER INFO 打印集群的信息  
CLUSTER NODES 列出集群当前已知的所有节点（node），以及这些节点的相关信息。   
  
//节点(node)  
CLUSTER MEET <ip> <port> 将 ip 和 port 所指定的节点添加到集群当中，让它成为集群的一份子。  
CLUSTER FORGET <node_id> 从集群中移除 node_id 指定的节点。  
CLUSTER REPLICATE <node_id> 将当前节点设置为 node_id 指定的节点的从节点。  
CLUSTER SAVECONFIG 将节点的配置文件保存到硬盘里面。   
  
//槽(slot)  
CLUSTER ADDSLOTS <slot> [slot ...] 将一个或多个槽（slot）指派（assign）给当前节点。  
CLUSTER DELSLOTS <slot> [slot ...] 移除一个或多个槽对当前节点的指派。  
CLUSTER FLUSHSLOTS 移除指派给当前节点的所有槽，让当前节点变成一个没有指派任何槽的节点。  
CLUSTER SETSLOT <slot> NODE <node_id> 将槽 slot 指派给 node_id 指定的节点，如果槽已经指派给另一个节点，那么先让另一个节点删除该槽>，然后再进行指派。  
CLUSTER SETSLOT <slot> MIGRATING <node_id> 将本节点的槽 slot 迁移到 node_id 指定的节点中。  
CLUSTER SETSLOT <slot> IMPORTING <node_id> 从 node_id 指定的节点中导入槽 slot 到本节点。  
CLUSTER SETSLOT <slot> STABLE 取消对槽 slot 的导入（import）或者迁移（migrate）。   
  
//键 (key)  
CLUSTER KEYSLOT <key> 计算键 key 应该被放置在哪个槽上。  
CLUSTER COUNTKEYSINSLOT <slot> 返回槽 slot 目前包含的键值对数量。  
CLUSTER GETKEYSINSLOT <slot> <count> 返回 count 个 slot 槽中的键。 
```

## 5.3  redis集群水平扩展——增加主从节点

**1、增加7007、7008两个文件夹。**

```bash
cd /usr/local/redis-cluster
mkdir 7007 7008
```

**2、把redis.conf拷贝到相应目录下，并配置相关参数。**

```bash
#7007
cp -f /usr/local/redis-cluster/7001/redis.conf /usr/local/redis-cluster/7007
sed -i 's/7001/7007/g' /usr/local/redis-cluster/7007/redis.conf

#7008
cp -f /usr/local/redis-cluster/7001/redis.conf /usr/local/redis-cluster/7008
sed -i 's/7001/7008/g' /usr/local/redis-cluster/7008/redis.conf
```

**3、启动两个节点。**

```bash
/usr/local/redis/bin/redis-server /usr/local/redis-cluster/7007/redis.conf
/usr/local/redis/bin/redis-server /usr/local/redis-cluster/7008/redis.conf
```

检查是否启动成功

```bash
ps -ef | grep redis
```

**4、把新节点7007加入集群中。**

```bash
/usr/local/redis-3.0.0/src/redis-trib.rb add-node 192.168.0.12:7007 192.168.0.12:7001
```

redis-trib.rb相关参数：

```bash
Usage: redis-trib <command> <options> <arguments ...>

  create          host1:port1 ... hostN:portN
                  --replicas <arg>
  check           host:port
  fix             host:port
  reshard         host:port
                  --from <arg>
                  --to <arg>
                  --slots <arg>
                  --yes
  add-node        new_host:new_port existing_host:existing_port
                  --slave
                  --master-id <arg>
  del-node        host:port node_id
  set-timeout     host:port milliseconds
  call            host:port command arg arg .. arg
  import          host:port
                  --from <arg>
  help            (show this help)

For check, fix, reshard, del-node, set-timeout you can specify the host and port of any working node in the cluster.
```

**5、新加入的7007节点默认为master节点，没有槽，需要给它分配槽。**

```bash
/usr/local/redis-3.0.0/src/redis-trib.rb reshard 192.168.0.12:7007
```

过程中会访问你要分配多少槽给新节点，这里给500

```bash
How many slots do you want to move (from 1 to 16384)? 500
```

然后会访问你要分配到哪个节点上，再输入7007节点ID

```bash
What is the receiving node ID? 7f1bd58a30864de89f1606ca56fe32670219f533
```

最后访问你以哪种方式切片，再输入all（表示从所有主节点中切出500槽，done表示从7001节点中切出500槽）

```bash
Please enter all the source node IDs.
  Type 'all' to use all the nodes as source nodes for the hash slots.
  Type 'done' once you entered all the source nodes IDs.
Source node #1:all
```

确认设置

```bash
Do you want to proceed with the proposed reshard plan (yes/no)? yes
```

登陆客户端，查看集群信息

```bash
/usr/local/redis/bin/redis-cli -c -h 192.168.0.12 -p 7001
192.168.0.12:7001> cluster nodes
7f1bd58a30864de89f1606ca56fe32670219f533 192.168.0.12:7007 master - 0 1564800607148 7 connected 0-165 5461-5627 10923-11088
2eecf57e5ac53a2e66ef17e728d91fd90e1aac2f 192.168.0.12:7001 myself,master - 0 0 1 connected 166-5460
0b8761fa2a2504ff262570c792736cae13e6bed7 192.168.0.12:7003 master - 0 1564800607549 3 connected 11089-16383
f7a141b1dca35115931869fe4250a4c766dcd88c 192.168.0.12:7006 slave 0b8761fa2a2504ff262570c792736cae13e6bed7 0 1564800606644 6 connected
4fb4a00c15629d4c9663a512ee62df43e25255a5 192.168.0.12:7004 slave 2eecf57e5ac53a2e66ef17e728d91fd90e1aac2f 0 1564800607650 4 connected
0e0f984050ee6e299d3da05a6692cf3091e310f9 192.168.0.12:7002 master - 0 1564800607549 2 connected 5628-10922
40694d735b2b46fd9a195e45b5f236b3f6d5ca00 192.168.0.12:7005 slave 0e0f984050ee6e299d3da05a6692cf3091e310f9 0 1564800606142 5 connected
```

**6、增加7008从节点**

```bash
/usr/local/redis-3.0.0/src/redis-trib.rb add-node 192.168.0.12:7008 192.168.0.12:7001
```

**7、把7008作为从节点挂到7007上**

```bash
/usr/local/redis/bin/redis-cli -c -h 192.168.0.12 -p 7008
192.168.0.12:7008> cluster replicate 7f1bd58a30864de89f1606ca56fe32670219f533
OK
```

查看集群信息

```bash
192.168.0.12:7008> cluster nodes
40694d735b2b46fd9a195e45b5f236b3f6d5ca00 192.168.0.12:7005 slave 0e0f984050ee6e299d3da05a6692cf3091e310f9 0 1564801403786 2 connected
b74ad880d5ba5cd53c6bc5d1953530c0de1e5f99 192.168.0.12:7008 myself,slave 7f1bd58a30864de89f1606ca56fe32670219f533 0 0 0 connected
2eecf57e5ac53a2e66ef17e728d91fd90e1aac2f 192.168.0.12:7001 master - 0 1564801402772 1 connected 166-5460
f7a141b1dca35115931869fe4250a4c766dcd88c 192.168.0.12:7006 slave 0b8761fa2a2504ff262570c792736cae13e6bed7 0 1564801402672 3 connected
0e0f984050ee6e299d3da05a6692cf3091e310f9 192.168.0.12:7002 master - 0 1564801401762 2 connected 5628-10922
7f1bd58a30864de89f1606ca56fe32670219f533 192.168.0.12:7007 master - 0 1564801404092 7 connected 0-165 5461-5627 10923-11088
0b8761fa2a2504ff262570c792736cae13e6bed7 192.168.0.12:7003 master - 0 1564801402268 3 connected 11089-16383
4fb4a00c15629d4c9663a512ee62df43e25255a5 192.168.0.12:7004 slave 2eecf57e5ac53a2e66ef17e728d91fd90e1aac2f 0 1564801403277 1 connected
```

更多操作参考：http://blog.51yip.com/nosql/1726.html/comment-page-1

## 5.4 删除主从节点

1、**删除从节点**，因为没有分配槽，所以比较容易，只需要执行

```bash
/usr/local/redis-3.0.0/src/redis-trib.rb del-node 192.168.0.12:7008 b74ad880d5ba5cd53c6bc5d1953530c0de1e5f99
```

执行后显示如下：

```bash
>>> Removing node b74ad880d5ba5cd53c6bc5d1953530c0de1e5f99 from cluster 192.168.0.12:7008
Connecting to node 192.168.0.12:7008: OK
Connecting to node 192.168.0.12:7005: OK
Connecting to node 192.168.0.12:7001: OK
Connecting to node 192.168.0.12:7006: OK
Connecting to node 192.168.0.12:7002: OK
Connecting to node 192.168.0.12:7007: OK
Connecting to node 192.168.0.12:7003: OK
Connecting to node 192.168.0.12:7004: OK
>>> Sending CLUSTER FORGET messages to the cluster...
>>> SHUTDOWN the node.
```

2、**删除主节点**，因为分配了槽，先要将槽挂到其它主节点，再删除节点。

取消分配的槽：

```bash
/usr/local/redis-3.0.0/src/redis-trib.rb reshard 192.168.0.12:7007 #取消分配的slot,下面是主要过程  
How many slots do you want to move (from 1 to 16384)? 500 #被删除master的所有slot数量  
What is the receiving node ID? 0b8761fa2a2504ff262570c792736cae13e6bed7 #接收7007节点slot的master，这里为7003  
Please enter all the source node IDs.  
 Type 'all' to use all the nodes as source nodes for the hash slots.  
 Type 'done' once you entered all the source nodes IDs.  
Source node #1:7f1bd58a30864de89f1606ca56fe32670219f533 #被删除master的node-id(7007)  
Source node #2:done   
  
Do you want to proceed with the proposed reshard plan (yes/no)? yes #取消slot后，reshard  
```

删除节点：

```bash
/usr/local/redis-3.0.0/src/redis-trib.rb del-node 192.168.0.12:7007 7f1bd58a30864de89f1606ca56fe32670219f533
```

操作过程中，如果出现错误，可以尝试修复节点

```bash
/usr/local/redis-3.0.0/src/redis-trib.rb fix 192.168.0.12:7007
```

## 6.0 redis3.0集群与spring整合

redis3.0 Session共享插件：

http://github.com/ran-jit/TomcatRedisClusterEnabledSessionManager

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:p="http://www.springframework.org/schema/p"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:jee="http://www.springframework.org/schema/jee" xmlns:tx="http://www.springframework.org/schema/tx"
	xmlns:aop="http://www.springframework.org/schema/aop"
	xsi:schemaLocation="  
            http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd  
            http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd">

	<context:property-placeholder location="classpath:redis.properties" />
	<context:component-scan base-package="com.x.redis.dao">
	</context:component-scan>
	<bean id="jedisPoolConfig" class="redis.clients.jedis.JedisPoolConfig">
		<property name="maxIdle" value="${redis.maxIdle}" />
		<property name="maxTotal" value="${redis.maxActive}" />
		<property name="maxWaitMillis" value="${redis.maxWait}" />
		<property name="testOnBorrow" value="${redis.testOnBorrow}" />
	</bean>

	<bean id="hostport1" class="redis.clients.jedis.HostAndPort">
		<constructor-arg name="host" value="10.16.68.92" />
		<constructor-arg name="port" value="7770" />
	</bean>
	<bean id="hostport2" class="redis.clients.jedis.HostAndPort">
		<constructor-arg name="host" value="10.16.68.92" />
		<constructor-arg name="port" value="7771" />
	</bean>
	<bean id="hostport3" class="redis.clients.jedis.HostAndPort">
		<constructor-arg name="host" value="10.16.68.92" />
		<constructor-arg name="port" value="7772" />
	</bean>
	<bean id="hostport4" class="redis.clients.jedis.HostAndPort">
		<constructor-arg name="host" value="10.16.68.92" />
		<constructor-arg name="port" value="7773" />
	</bean>
	<bean id="hostport5" class="redis.clients.jedis.HostAndPort">
		<constructor-arg name="host" value="10.16.68.92" />
		<constructor-arg name="port" value="7774" />
	</bean>
	<bean id="hostport6" class="redis.clients.jedis.HostAndPort">
		<constructor-arg name="host" value="10.16.68.92" />
		<constructor-arg name="port" value="7775" />
	</bean>

	<bean id="redisCluster" class="redis.clients.jedis.JedisCluster">
		<constructor-arg name="nodes">
			<set>
				<ref bean="hostport1" />
				<ref bean="hostport2" />
				<ref bean="hostport3" />
				<ref bean="hostport4" />
				<ref bean="hostport5" />
				<ref bean="hostport6" />
			</set>
		</constructor-arg>
		<constructor-arg name="timeout" value="6000" />
		<constructor-arg name="poolConfig">
			<ref bean="jedisPoolConfig" />
		</constructor-arg>
	</bean>
</beans>
```

## 7.1 Redis与Lua

Lua是一个小巧的脚本语言。是巴西里约热内卢主教大学（Pontifical Catholic University of Rio de Janeiro）里的一个研究小组，由Reboerto Ierusalimschy、Waldemar Celes和Luiz Henrique de Figueiredo所组成并于1993年开发。其设计目的是为了嵌入应用程序中，从而为应用程序提供灵活的扩展和定制功能。Lua由标准C编写而成，几乎在所有操作系统和平台上都可以编译，运行。Lua并没有提供强大的库，这是由它的定位决定的。所以Lua不适合作为开发独立应用程序的语言。Lua有一个同时进行的JIT项目，提供在特定平台上的即时编译功能。

Lua脚本可以很容易的被C/C++代码调用，也可以反过来调用C/C++的函数，这使得Lua在应用程序中可以被广泛应用。不仅仅作为扩展脚本，也可以作为普通的配置文件，代替XML，ini等文件格式，并且更容易理解和维护。Lua由标准C编写而成，代码简洁优美，几乎在所有操作系统和平台上都可以编译，运行。一个完整的Lua解释器不过200k，在目前所有脚本引擎中，Lua的速度是最快的。这一切决定了Lua是作为嵌入式脚本的最佳选择。

## 7.2 Lua的安装

-   首先安装readline库

```
yum install -y readline readline-devel
```

-   下载Lua 5.1版本并且安装

```
cd /usr/local/softwares
wget http://www.lua.org/ftp/lua-5.1.4.tar.gz
tar -zxvf lua-5.1.4.tar.gz -C /usr/local
cd /usr/local/lua-5.1.4
make linux
make install
```

-   最后进行测试，命令行输入lua，进入lua client，编写`print(“hello lua!”)`，查看结果：

```bash
[root@rocketmq-nameserver2 html]# lua
Lua 5.1.4  Copyright (C) 1994-2008 Lua.org, PUC-Rio
> print("hello lua!")
hello lua!
```

## 7.3 Lua的使用

-   使用Lua非常的简单，既然是脚本语言，我们一定要编写以.lua后缀的脚本文件。然后使用lua命令执行即可！

```bash
vim 01.lua
```

​	脚本内容：

```lua
print("hello world!")
```

-   执行文件命令：`lua 01.lua`

```bash
[root@rocketmq-nameserver2 luadir]# lua 01.lua 
hello world!
```

-   对于lua的语法，我们参考一篇博客即可：

    http://blog.csdn.net/vboy1010/article/details/7802563

7.4 Redis与Lua结合

-   redis与lua脚本结合非常简单，如下所示：

```lua
redis.call('set', 'age', 30);
local age = redis.call('get', 'age');
return age;
```

-   我们只需要在lua脚本里编写好对应的业务逻辑，使用redis.call函数去操作对应的取值和设置值即可！如果需要脚本返回值，可以填写return，不需要则不用写 return语句内容，会返回nil，也就是空值。
-   执行redis与lua脚本命令：

```bash
/usr/local/redis/bin/redis-cli --eval ~/luadir/02.lua
```

执行结果：

```bash
vim 02.lua
/usr/local/redis/bin/redis-cli --eval ~/luadir/02.lua
"30"
```













































