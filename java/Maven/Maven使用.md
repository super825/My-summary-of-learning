# Maven使用

## maven简介

Apache Maven 是一套软件工程管理和整合工具。基于工程对象模型（POM）的概念，通过一个中央信息管理模块，Maven 能够管理项目的构建、报告和文档。 

推荐教程：

https://www.w3cschool.cn/maven/

## maven安装

#### 1、官网下载

https://maven.apache.org/download.cgi

下载完成后解压到指定目录，如d:\maven

#### 2、配置环境变量

##### windows

我的电脑->右键->属性->高级系统设置->高级->环境变量->系统变量

新建变量`MAVEN_HOME`，值为`d:\maven\apache-maven-3.5.4`

修改`PATH`, 最后面增加 `%MAVEN_HOME%\bin`

##### linux

待完善

#### 3、查看mvn是否安装成功

打开命令窗口

`win + r`

输入`cmd`，回车

在命令窗口中输入

`mvn --version`

看到如下结果，则表示安装成功

```bash
Apache Maven 3.5.4 (1edded0938998edf8bf061f1ceb3cfdeccf443fe; 2018-06-18T02:33:14+08:00)
Maven home: G:\devTools\maven\apache-maven-3.5.4\bin\..
Java version: 1.8.0_131, vendor: Oracle Corporation, runtime: F:\Program Files\Java\jdk1.8.0_131\jre
Default locale: zh_CN, platform encoding: GBK
OS name: "windows 10", version: "10.0", arch: "amd64", family: "windows"
```

## maven配置

1、配置镜像mirror

打开d:\maven\apache-maven-3.5.4\conf\settings.xml

找到<mirrors>节点

增加如下配置

```xml
	<mirror>  
	  <id>alimaven</id>  
	  <name>aliyun maven</name>  
	  <url>http://maven.aliyun.com/nexus/content/groups/public/</url>  
	  <mirrorOf>central</mirrorOf>          
	</mirror> 
	<mirror>
		<id>ui</id>
		<mirrorOf>central</mirrorOf>
		<name>Human Readable Name for this Mirror.</name>
		<url>http://uk.maven.org/maven2/</url>
	</mirror>
	<mirror>
		<id>osc</id>
		<mirrorOf>central</mirrorOf>
		<url>http://maven.oschina.net/content/groups/public/</url>
	</mirror>
	<mirror>
		<id>osc_thirdparty</id>
		<mirrorOf>thirdparty</mirrorOf>
		<url>http://maven.oschina.net/content/repositories/thirdparty/</url>
	</mirror>
```

