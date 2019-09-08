<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [第一章 走进Python](#%E7%AC%AC%E4%B8%80%E7%AB%A0-%E8%B5%B0%E8%BF%9Bpython)
  - [目标](#%E7%9B%AE%E6%A0%87)
  - [案例](#%E6%A1%88%E4%BE%8B)
  - [第一节 Python简史](#%E7%AC%AC%E4%B8%80%E8%8A%82-python%E7%AE%80%E5%8F%B2)
    - [什么是Python](#%E4%BB%80%E4%B9%88%E6%98%AFpython)
    - [Python编程](#python%E7%BC%96%E7%A8%8B)
    - [Python简史](#python%E7%AE%80%E5%8F%B2)
    - [里程碑](#%E9%87%8C%E7%A8%8B%E7%A2%91)
  - [第二节 Python特征](#%E7%AC%AC%E4%BA%8C%E8%8A%82-python%E7%89%B9%E5%BE%81)
    - [Python编程语言中的定位](#python%E7%BC%96%E7%A8%8B%E8%AF%AD%E8%A8%80%E4%B8%AD%E7%9A%84%E5%AE%9A%E4%BD%8D)
    - [简单易学](#%E7%AE%80%E5%8D%95%E6%98%93%E5%AD%A6)
    - [解释性&编译性](#%E8%A7%A3%E9%87%8A%E6%80%A7%E7%BC%96%E8%AF%91%E6%80%A7)
    - [面向对象](#%E9%9D%A2%E5%90%91%E5%AF%B9%E8%B1%A1)
    - [高级语言](#%E9%AB%98%E7%BA%A7%E8%AF%AD%E8%A8%80)
    - [可扩展性及可嵌入性](#%E5%8F%AF%E6%89%A9%E5%B1%95%E6%80%A7%E5%8F%8A%E5%8F%AF%E5%B5%8C%E5%85%A5%E6%80%A7)
    - [免费、开源](#%E5%85%8D%E8%B4%B9%E5%BC%80%E6%BA%90)
    - [可移植性](#%E5%8F%AF%E7%A7%BB%E6%A4%8D%E6%80%A7)
    - [丰富的库](#%E4%B8%B0%E5%AF%8C%E7%9A%84%E5%BA%93)
    - [总结](#%E6%80%BB%E7%BB%93)
  - [第三节 Python的应用](#%E7%AC%AC%E4%B8%89%E8%8A%82-python%E7%9A%84%E5%BA%94%E7%94%A8)
    - [Google](#google)
    - [Yahoo](#yahoo)
    - [NASA](#nasa)
    - [YouTube](#youtube)
    - [豆瓣在Python和Ruby之间为何选择前者？](#%E8%B1%86%E7%93%A3%E5%9C%A8python%E5%92%8Cruby%E4%B9%8B%E9%97%B4%E4%B8%BA%E4%BD%95%E9%80%89%E6%8B%A9%E5%89%8D%E8%80%85)
  - [第四节 搭建Python环境](#%E7%AC%AC%E5%9B%9B%E8%8A%82-%E6%90%AD%E5%BB%BApython%E7%8E%AF%E5%A2%83)
    - [Linux环境](#linux%E7%8E%AF%E5%A2%83)
    - [Windows环境](#windows%E7%8E%AF%E5%A2%83)
- [第二章 开始编程吧](#%E7%AC%AC%E4%BA%8C%E7%AB%A0-%E5%BC%80%E5%A7%8B%E7%BC%96%E7%A8%8B%E5%90%A7)
  - [第一节 Python文件类型](#%E7%AC%AC%E4%B8%80%E8%8A%82-python%E6%96%87%E4%BB%B6%E7%B1%BB%E5%9E%8B)
    - [源代码](#%E6%BA%90%E4%BB%A3%E7%A0%81)
    - [字节代码](#%E5%AD%97%E8%8A%82%E4%BB%A3%E7%A0%81)
    - [优化代码](#%E4%BC%98%E5%8C%96%E4%BB%A3%E7%A0%81)
    - [以上三种均可直接运行](#%E4%BB%A5%E4%B8%8A%E4%B8%89%E7%A7%8D%E5%9D%87%E5%8F%AF%E7%9B%B4%E6%8E%A5%E8%BF%90%E8%A1%8C)
  - [第二节 Python变量](#%E7%AC%AC%E4%BA%8C%E8%8A%82-python%E5%8F%98%E9%87%8F)
    - [变量的定义](#%E5%8F%98%E9%87%8F%E7%9A%84%E5%AE%9A%E4%B9%89)
    - [变量的命名](#%E5%8F%98%E9%87%8F%E7%9A%84%E5%91%BD%E5%90%8D)
    - [变量的赋值](#%E5%8F%98%E9%87%8F%E7%9A%84%E8%B5%8B%E5%80%BC)
  - [第三节 运算符与表达式](#%E7%AC%AC%E4%B8%89%E8%8A%82-%E8%BF%90%E7%AE%97%E7%AC%A6%E4%B8%8E%E8%A1%A8%E8%BE%BE%E5%BC%8F)
    - [案例：写一个自己的四则运算器](#%E6%A1%88%E4%BE%8B%E5%86%99%E4%B8%80%E4%B8%AA%E8%87%AA%E5%B7%B1%E7%9A%84%E5%9B%9B%E5%88%99%E8%BF%90%E7%AE%97%E5%99%A8)
    - [Python运算符包括](#python%E8%BF%90%E7%AE%97%E7%AC%A6%E5%8C%85%E6%8B%AC)
    - [表达式](#%E8%A1%A8%E8%BE%BE%E5%BC%8F)
    - [运算符的优先级](#%E8%BF%90%E7%AE%97%E7%AC%A6%E7%9A%84%E4%BC%98%E5%85%88%E7%BA%A7)
  - [第四节 数据类型](#%E7%AC%AC%E5%9B%9B%E8%8A%82-%E6%95%B0%E6%8D%AE%E7%B1%BB%E5%9E%8B)
    - [案例](#%E6%A1%88%E4%BE%8B-1)
    - [数据类型](#%E6%95%B0%E6%8D%AE%E7%B1%BB%E5%9E%8B)
    - [数字类型](#%E6%95%B0%E5%AD%97%E7%B1%BB%E5%9E%8B)
    - [数字类型-整数int](#%E6%95%B0%E5%AD%97%E7%B1%BB%E5%9E%8B-%E6%95%B4%E6%95%B0int)
    - [数字类型-长整数long](#%E6%95%B0%E5%AD%97%E7%B1%BB%E5%9E%8B-%E9%95%BF%E6%95%B4%E6%95%B0long)
    - [数字类型-浮点型float](#%E6%95%B0%E5%AD%97%E7%B1%BB%E5%9E%8B-%E6%B5%AE%E7%82%B9%E5%9E%8Bfloat)
    - [数字类型-复数型complex](#%E6%95%B0%E5%AD%97%E7%B1%BB%E5%9E%8B-%E5%A4%8D%E6%95%B0%E5%9E%8Bcomplex)
    - [字符串String](#%E5%AD%97%E7%AC%A6%E4%B8%B2string)
  - [第五节 序列](#%E7%AC%AC%E4%BA%94%E8%8A%82-%E5%BA%8F%E5%88%97)
    - [基本概念](#%E5%9F%BA%E6%9C%AC%E6%A6%82%E5%BF%B5)
    - [序列的基本操作](#%E5%BA%8F%E5%88%97%E7%9A%84%E5%9F%BA%E6%9C%AC%E6%93%8D%E4%BD%9C)
    - [元组()](#%E5%85%83%E7%BB%84)
  - [第六节 序列-列表](#%E7%AC%AC%E5%85%AD%E8%8A%82-%E5%BA%8F%E5%88%97-%E5%88%97%E8%A1%A8)
    - [列表[]](#%E5%88%97%E8%A1%A8)
    - [列表操作](#%E5%88%97%E8%A1%A8%E6%93%8D%E4%BD%9C)
    - [对象与类快速入门](#%E5%AF%B9%E8%B1%A1%E4%B8%8E%E7%B1%BB%E5%BF%AB%E9%80%9F%E5%85%A5%E9%97%A8)
  - [第七节 字典](#%E7%AC%AC%E4%B8%83%E8%8A%82-%E5%AD%97%E5%85%B8)
    - [基本概念](#%E5%9F%BA%E6%9C%AC%E6%A6%82%E5%BF%B5-1)
    - [创建字典](#%E5%88%9B%E5%BB%BA%E5%AD%97%E5%85%B8)
    - [访问字典中的值](#%E8%AE%BF%E9%97%AE%E5%AD%97%E5%85%B8%E4%B8%AD%E7%9A%84%E5%80%BC)
    - [更新和删除](#%E6%9B%B4%E6%96%B0%E5%92%8C%E5%88%A0%E9%99%A4)
    - [字典相关的内建函数](#%E5%AD%97%E5%85%B8%E7%9B%B8%E5%85%B3%E7%9A%84%E5%86%85%E5%BB%BA%E5%87%BD%E6%95%B0)
    - [工厂函数dict()](#%E5%B7%A5%E5%8E%82%E5%87%BD%E6%95%B0dict)
    - [常用函数](#%E5%B8%B8%E7%94%A8%E5%87%BD%E6%95%B0)
  - [第八节 流程控制](#%E7%AC%AC%E5%85%AB%E8%8A%82-%E6%B5%81%E7%A8%8B%E6%8E%A7%E5%88%B6)
    - [if else](#if-else)
    - [for循环](#for%E5%BE%AA%E7%8E%AF)
    - [range](#range)
    - [遍历字典](#%E9%81%8D%E5%8E%86%E5%AD%97%E5%85%B8)
    - [for循环控制](#for%E5%BE%AA%E7%8E%AF%E6%8E%A7%E5%88%B6)
    - [while循环](#while%E5%BE%AA%E7%8E%AF)
  - [第九节 函数](#%E7%AC%AC%E4%B9%9D%E8%8A%82-%E5%87%BD%E6%95%B0)
    - [自定义函数](#%E8%87%AA%E5%AE%9A%E4%B9%89%E5%87%BD%E6%95%B0)
    - [预定义的Python函数](#%E9%A2%84%E5%AE%9A%E4%B9%89%E7%9A%84python%E5%87%BD%E6%95%B0)
    - [为什么使用函数](#%E4%B8%BA%E4%BB%80%E4%B9%88%E4%BD%BF%E7%94%A8%E5%87%BD%E6%95%B0)
    - [函数定义和调用](#%E5%87%BD%E6%95%B0%E5%AE%9A%E4%B9%89%E5%92%8C%E8%B0%83%E7%94%A8)
    - [形式参数和实际参数](#%E5%BD%A2%E5%BC%8F%E5%8F%82%E6%95%B0%E5%92%8C%E5%AE%9E%E9%99%85%E5%8F%82%E6%95%B0)
    - [缺省参数（默认参数）](#%E7%BC%BA%E7%9C%81%E5%8F%82%E6%95%B0%E9%BB%98%E8%AE%A4%E5%8F%82%E6%95%B0)
    - [局部变量和全局变量](#%E5%B1%80%E9%83%A8%E5%8F%98%E9%87%8F%E5%92%8C%E5%85%A8%E5%B1%80%E5%8F%98%E9%87%8F)
    - [global语句](#global%E8%AF%AD%E5%8F%A5)
    - [函数返回值](#%E5%87%BD%E6%95%B0%E8%BF%94%E5%9B%9E%E5%80%BC)
    - [向函数传入元组和字典](#%E5%90%91%E5%87%BD%E6%95%B0%E4%BC%A0%E5%85%A5%E5%85%83%E7%BB%84%E5%92%8C%E5%AD%97%E5%85%B8)
    - [处理多余实参](#%E5%A4%84%E7%90%86%E5%A4%9A%E4%BD%99%E5%AE%9E%E5%8F%82)
    - [lambda表达式](#lambda%E8%A1%A8%E8%BE%BE%E5%BC%8F)
    - [lambda基础](#lambda%E5%9F%BA%E7%A1%80)
    - [lambda应用实例](#lambda%E5%BA%94%E7%94%A8%E5%AE%9E%E4%BE%8B)
    - [switch语句](#switch%E8%AF%AD%E5%8F%A5)
    - [switch实现](#switch%E5%AE%9E%E7%8E%B0)
    - [函数调用](#%E5%87%BD%E6%95%B0%E8%B0%83%E7%94%A8)
  - [第十节 内置函数](#%E7%AC%AC%E5%8D%81%E8%8A%82-%E5%86%85%E7%BD%AE%E5%87%BD%E6%95%B0)
    - [help函数可以用来查看函数的用法](#help%E5%87%BD%E6%95%B0%E5%8F%AF%E4%BB%A5%E7%94%A8%E6%9D%A5%E6%9F%A5%E7%9C%8B%E5%87%BD%E6%95%B0%E7%9A%84%E7%94%A8%E6%B3%95)
    - [常用函数](#%E5%B8%B8%E7%94%A8%E5%87%BD%E6%95%B0-1)
    - [类型转换函数](#%E7%B1%BB%E5%9E%8B%E8%BD%AC%E6%8D%A2%E5%87%BD%E6%95%B0)
    - [string函数](#string%E5%87%BD%E6%95%B0)
    - [序列处理函数](#%E5%BA%8F%E5%88%97%E5%A4%84%E7%90%86%E5%87%BD%E6%95%B0)
    - [lambda -> 列表表达式](#lambda---%E5%88%97%E8%A1%A8%E8%A1%A8%E8%BE%BE%E5%BC%8F)
  - [第十一节 模块](#%E7%AC%AC%E5%8D%81%E4%B8%80%E8%8A%82-%E6%A8%A1%E5%9D%97)
    - [简介](#%E7%AE%80%E4%BB%8B)
    - [包](#%E5%8C%85)
    - [模块](#%E6%A8%A1%E5%9D%97)
    - [总结](#%E6%80%BB%E7%BB%93-1)
  - [第十二节 正则表达式](#%E7%AC%AC%E5%8D%81%E4%BA%8C%E8%8A%82-%E6%AD%A3%E5%88%99%E8%A1%A8%E8%BE%BE%E5%BC%8F)
    - [目标](#%E7%9B%AE%E6%A0%87-1)
    - [案例](#%E6%A1%88%E4%BE%8B-2)
    - [简介](#%E7%AE%80%E4%BB%8B-1)
    - [字符匹配](#%E5%AD%97%E7%AC%A6%E5%8C%B9%E9%85%8D)
    - [使用正则表达式](#%E4%BD%BF%E7%94%A8%E6%AD%A3%E5%88%99%E8%A1%A8%E8%BE%BE%E5%BC%8F)
    - [反斜杠的麻烦](#%E5%8F%8D%E6%96%9C%E6%9D%A0%E7%9A%84%E9%BA%BB%E7%83%A6)
    - [执行匹配](#%E6%89%A7%E8%A1%8C%E5%8C%B9%E9%85%8D)
    - [模块级函数](#%E6%A8%A1%E5%9D%97%E7%BA%A7%E5%87%BD%E6%95%B0)
    - [编译标志-flags](#%E7%BC%96%E8%AF%91%E6%A0%87%E5%BF%97-flags)
    - [分组()](#%E5%88%86%E7%BB%84)
    - [一个小爬虫](#%E4%B8%80%E4%B8%AA%E5%B0%8F%E7%88%AC%E8%99%AB)
  - [第十三节 python对内存的使用](#%E7%AC%AC%E5%8D%81%E4%B8%89%E8%8A%82-python%E5%AF%B9%E5%86%85%E5%AD%98%E7%9A%84%E4%BD%BF%E7%94%A8)
    - [浅拷贝和深拷贝](#%E6%B5%85%E6%8B%B7%E8%B4%9D%E5%92%8C%E6%B7%B1%E6%8B%B7%E8%B4%9D)
  - [第十四节 文件与目录](#%E7%AC%AC%E5%8D%81%E5%9B%9B%E8%8A%82-%E6%96%87%E4%BB%B6%E4%B8%8E%E7%9B%AE%E5%BD%95)
    - [目标](#%E7%9B%AE%E6%A0%87-2)
    - [案例](#%E6%A1%88%E4%BE%8B-3)
    - [python文件读写](#python%E6%96%87%E4%BB%B6%E8%AF%BB%E5%86%99)
    - [文件对象方法](#%E6%96%87%E4%BB%B6%E5%AF%B9%E8%B1%A1%E6%96%B9%E6%B3%95)
    - [文件查找和替换](#%E6%96%87%E4%BB%B6%E6%9F%A5%E6%89%BE%E5%92%8C%E6%9B%BF%E6%8D%A2)
    - [目录操作](#%E7%9B%AE%E5%BD%95%E6%93%8D%E4%BD%9C)
  - [第十五节 异常处理](#%E7%AC%AC%E5%8D%81%E4%BA%94%E8%8A%82-%E5%BC%82%E5%B8%B8%E5%A4%84%E7%90%86)
    - [异常以及异常抛出](#%E5%BC%82%E5%B8%B8%E4%BB%A5%E5%8F%8A%E5%BC%82%E5%B8%B8%E6%8A%9B%E5%87%BA)
    - [抛出机制](#%E6%8A%9B%E5%87%BA%E6%9C%BA%E5%88%B6)
    - [finally子句](#finally%E5%AD%90%E5%8F%A5)
    - [raise抛出异常](#raise%E6%8A%9B%E5%87%BA%E5%BC%82%E5%B8%B8)
    - [常见的python异常](#%E5%B8%B8%E8%A7%81%E7%9A%84python%E5%BC%82%E5%B8%B8)
  - [第十六节 MySQLdb](#%E7%AC%AC%E5%8D%81%E5%85%AD%E8%8A%82-mysqldb)
  - [第十七节 面向对象](#%E7%AC%AC%E5%8D%81%E4%B8%83%E8%8A%82-%E9%9D%A2%E5%90%91%E5%AF%B9%E8%B1%A1)
    - [类和对象](#%E7%B1%BB%E5%92%8C%E5%AF%B9%E8%B1%A1)
    - [Python类定义](#python%E7%B1%BB%E5%AE%9A%E4%B9%89)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 第一章 走进Python
## 目标
* 了解Python的历史
* 了解Python的特征
* 了解Python的应用
* 掌握Linux下Python开发环境的搭建
* 理解Windows下Python环境搭建

## 案例
* 安装Python，写出第一个Python程序

## 第一节 Python简史

### 什么是Python
* 一种解释型的、面向对象的、带有动态语义的高级程序设计语言

### Python编程
* 是一种使你在编程时能够保持自己风格的程序设计语言，你不用费什么劲就可以实现你想要的功能，并且编写的程序清晰易懂。

### Python简史
* Python的发展，可以分为几个重要的阶段：
    * CNRI时期：CNRI是资助Python发展初期的重要单位，Python1.5版之前的成果大部分都在此时期完成。
    * BeOpen时期：Guido van Rossum与BeOpen公司合作，此一期间将Python2.0推出，甚至Python1.6也同时问世，但原则上已经分别维护了。
    * DC时期：目前Guido已离开BeOpen公司，将开发团队带到Digital Creations（DC）公司，该公司以发展Zope系统闻名，因此这项合作也颇受注目。
    * Python 3.0

### 里程碑
* Python获年度Tiobe编程语言大奖
    * Python在2010年获得了较大的市场份额增长，2010年1月以来Python的市场份额增长了1.81%，是增长速度最快的。

## 第二节 Python特征

### Python编程语言中的定位
* 脚本语言
* 高阶动态编程语言

### 简单易学
* Python是一种代表简单主义思想的语言。Python的这种伪代码本质是它最大的优点之一。它使你能够专注于解决问题而不是去搞明白语言本身。Python有极其简单的语法，极易上手。

### 解释性&编译性
* Python语言写的程序不需要编译成二进制代码。可以直接从源代码运行程序，但是需要解释器。这点类似于Java，或是Matlab。其实我更今偏重于认为是后者。
* Python中亦有编译执行的特性。

### 面向对象
* Python既支持面向过程的编程也支持面向对象的编程。与其他主要的语言如C++和Java相比，Python以一种非常强大又简单的方式实现面向对象编程。让我迷惑的是，Python中类的属性似乎不是那么重要，至少我现在还不是很明白。

### 高级语言
* 使用Python语言编写程序，无需考虑诸如管理内存一类的底层。

### 可扩展性及可嵌入性
* 可以把部分程序用C或C++编写，然后Python程序中使用它们。与此相反，可以把Python嵌入C/C++程序，提供脚本功能。

### 免费、开源
* 自由地发布这个软件的拷贝、阅读它的源代码、对它做改动、把它的一部分用于新的自由软件中。现阶段，我们好像不太在意这一点。

### 可移植性
* 由于它的开源本质，Python已经被移植在许多平台上。如果能避免使用依赖于系统的特性，那么所有Python程序无需修改就可在任何平台上面运行。包括Linux、Windows、FreeBSD、Macintosh、Palm OS、QNX、VMS、Psion、Acom RISC OS、VxWorks、PlayStation、Sharp Zaurus、Window CE甚至还有PocketPC！

### 丰富的库
* 丰富的库，似乎已成为判断一门编程语言是否强大的重要标准。Python标准库确实很庞大。它可以帮助你处理各种工作，包括正则表达式、文档生成、单元测试、线程、数据库、网页浏览器、CGI、FTP、电子邮件、XML、XML-RPC、HTML、WAV文件、密码系统、GUI、TK和其他与系统有关的操作。只要安装了Python，所有这些功能都是可用的。这被称作Python的“功能齐全”理念。除了标准库以外，还有许多其他高质量的库（似乎可以称为第三方），如wxPython、Twisted和Python图像库等等。

### 总结
* 易用与速度的完美结合
* 把精力放在要解决的总理上
* 跨平台又易扩展
* 自动化的内存管理
* 内建许多高阶而实用的资料型态
* 轻易结合网络程序模块
* 万能钥匙？ No, **胶水语言**

## 第三节 Python的应用

### Google
* 实现Web爬虫和搜索引擎中的很多组件。

### Yahoo
* Yahoo使用它（包括其他技术）管理讨论组。

### NASA
* NASA在它的几个系统中既用了Python开发，又将其作为脚本语言。

### YouTube
* 视频分享服务大部分是由Python编写的。

### 豆瓣在Python和Ruby之间为何选择前者？
* Ruby名气很大，但在国内真正用的人不多。
* Python的“可用性”要好的多，Java本来就在传统的大型应用中占有重要地位。
* 虽然Python没有Perl的库强大，但是很多库还是在大型商业中应用的比较广泛，比之Ruby还是要稳的多。
* Python的简洁性。
* 还用，据说Ruby是小日本创造的。
* 其他：都根植于Unix体系，Google使用Python。

## 第四节 搭建Python环境

### Linux环境
* 大多Linux发行版均默认安装了Pthon环境。如想下载不同的版本，可到www.python.org下载。软件安装方法参照Linux软件安装。
* 输入Python可启动Python交互模式
* 程序编辑推荐使用VIM

### Windows环境
* 可下载安装python的msi所直接安装
* 自带python的GUI开发环境
* 开发工具很多



# 第二章 开始编程吧

## 第一节 Python文件类型

### 源代码 
* Python源代码的文件以“py”为扩展名，由Python程序解释，不需要编译

### 字节代码
* Python源文件经编译后生成的扩展名为“pyc”的文件
* 编译方法
```python
import py_compile
py_compile.compile("hello.py")
```

### 优化代码

* 经过优化的源文件，扩展名为“.pyo”
* `python -O -m py_compile hello.py`

### 以上三种均可直接运行


## 第二节 Python变量
### 变量的定义
* 变量是计算机内存中的一块区域，变量可以存储规定范围内的值，而且值可以改变。

### 变量的命名
* 变量名有字母、数字、下划线组成。
* 数字不能开头
* 不可以使用关键字
* `a  a1  a_  a_1`

### 变量的赋值

* 是变量声明和定义的过程
```python
a = 1
ld(a)
```

## 第三节 运算符与表达式 
### 案例：写一个自己的四则运算器
```python
#!/usr/bin/python

import sys
running = True

while running:
    try:
        t = int(raw_input())
        p = int(raw_input())
    except EOFError:
        break

    print 'operator + result\n', t + p
    print 'operator - result\n', t - p
    print 'operator * result\n', t * p
    print 'operator / result\n', t / p
```

### Python运算符包括
* 赋值运算符
```python
x = 3, y = 'abcde'      #等于
x += 2                  #加等于
x -= 2                  #减等于
x *= 2                  #乘等于
x /= 2                  #除等于
x %= 2                  #求余等于
```

* 算术运算符
```python
x + y                   #加法
x - y                   #减法
x * y                   #乘法
x / y                   #实数除法
x // y                  #整数除法
x % y                   #求余
x**y                    #求幂
```

* 关系运算符
```python
x < y                   #大于
x > y                   #小于
x <= y                  #小于等于
x >= y                  #大于等于
x != y                  #不等于
x == y                  #完全等于
```

* 逻辑运算符
```python
and                     #与
or                      #或
not                     #非
```

### 表达式
* 表达式是将不同数据（包括变量、函数）用运算符按一定规则连接起来的一种式子

### 运算符的优先级
* 在常规表达式中，存在着多个运算符，比如：`1+2*3-1/2*3/2`，那么就存在着计算优先度的问题
* 一般的，运算符存在高低级别，在同一个表达式中，高优先级的运算符：比如：`1*2+3*3 = 11` 而不是15
* 对于同级别的运算符，按从左到右处理。例如：`8*4/2*3 = 48`
* 运算符优先级由低到高是：
```python
Lambda
逻辑或：or
逻辑与：and
逻辑非：not
成员测试：in      not in
同一性测试：is      is not
比较：<   <=  >   >=  !=  ==
按位或：|
按位异或：^
按位与：&
移位：<<  >>
加法与减法：+   -
乘法、除法与取余：*   /   %
正负号：+x  -x
按位翻转：~x
指数：**
```

## 第四节 数据类型
### 案例
* `123`和`"123"`一样吗
* `() [] {}`

### 数据类型
* 计算机是用来辅助人们的，在程序设计中也映射了现实世界的分类，以便于抽象的分析。
* 数字
* 字符串
* 列表
* 元组
* 字典

### 数字类型
* 整型
* 长整形
* 浮点型
* 复数型

### 数字类型-整数int
* 整数int表示的范围-2147483648到2147483647。例如:0，100，-100
* int的范围示例：
```python
num=2147483647
type(num)       #输出结果: <type 'int'>
```

### 数字类型-长整数long
* long的范围很大很大，几乎可以说任意大的整数均可以存储。
* 为了区分普通整数和长整数，需要在整数后加L或小写l。例如：`51856678L, -0x22345L`
```python
num = 11
type(num)       #输出结果: <type 'int'>
num = 9999999999999999999999
type(num)       #输出结果: <type 'long'>
```

### 数字类型-浮点型float
* 例如：`0.0, 12.0, -18.8, 3e+7`
* 示例：
```python
num = 0.0
type(num)       #输出结果: <type 'float'>
num = 12
type(num)       #输出结果: <type 'int'>
num = 12.0
type(num)       #输出结果: <type 'float'>
```

### 数字类型-复数型complex
* Python对复数提供内嵌支持，这是其他大部分软件所没有的
* 复数举例: `3.14j, 8.32e-36j`
* 示例：
```python
>>> num=3.14j
>>> type(num)
<type 'complex'>
>>> num
3.14j
>>> print num
3.14j
```

### 字符串String

* 使用引号定义的一组可以包含数字、字母、符号（非特殊系统符号）的集合。
```python
Strval='This is a test'
Strval="This is a test"
Strval="""This is a test"""
```
* 三重引号（docstring）通常用来制作字符串，在面向对象时详解


## 第五节 序列
### 基本概念
* 列表、元组和字符串都是序列
* 序列的两个主要特点是索引操作符和切片操作符。
    * 索引操作符让我们可以从序列中抓取一个特定项目。
    * 切片操作符让我们能够获取序列的一个切片，即一部分序列。
* 索引同样可以是负数，位置是从序列尾开始计算的。
    * 因此，shoplist[-1]表示序列的最后一个元素，而shoplist[-2]抓取序列的倒数第二个项目
* 切片操作符是序列名后跟一个方括号，方括号中有一对可选的数字，并用冒号分割。
    * 注意这与你使用的索引操作符十分相似。记住数是可选的，而冒号是必须的。
    * 切片操作符中的第一个数（冒号之前）表示切片开始的位置，第二个数（冒号之后）表示切片到哪里结束。如果不指定第一个数，Python就从序列首开始。如果没有指定第二个数，则Python会停止在序列尾。
    * 注意：返回的序列从开始位置开始，刚好在结束位置之前结束。即开始位置是包含在序列切片中的，而结束位置被排斥在切片外。
        * shoplist[1:3]返回从位置1开始，包括位置2，但是停止在位置3的一个序列切片，因此返回一个含有两个项目的切片。shoplist[:]返回整个序列的拷贝。你可以用负数做切片。负数用在从序列尾开始计算的位置。例如,shoplist[:-1]会返回除了最后一个项目外包含所有项目的序列切片

### 序列的基本操作
* `len()`：求序列的长度
* `+`：连接两个序列
* `*`：重复序列元素
* `in`：判断元素是否在序列中
* `max()`：返回最大值
* `min()`：返回最小值
* `cmp(tuple1, tuple2)`：比较两个序列值是否相同

### 元组()
* 元组和列表十分类似，只不过元组和字符串一样是不可变的，即你不能修改元组。
    * 元组通过圆括号中用逗号分割的项目定义。
    * 元组通常用在使语句或用户定义的函数能够安全地采用一组值的时候，即被使用的元组的值不会改变。
* 创建元组
    * 一个空的元组由一对空的圆括号组成，如：`myempty=()`
    * 含有单个元素的元组，`singleton=(2)`
    * 一般的元组
    ```python
        zoo=('wolf', 'elephant', 'penguin')
        new_zoo=('monkey', 'dolphin', zoo)
    ```
* 元组操作
    * 元组和字符串一样属于序列类型，可通过索引和切片操作。
    * 元组值亦不可变

## 第六节 序列-列表

### 列表[]
* list是处理一组有序项目的数据结构，即你可以在一个列表中存储一个序列的项目。
* 列表是可变类型的数据。
* 列表的组成：用[]表示列表，包含了多个以逗号分隔开的数字，或者子串。
```python
list1=['Simon', 'David', 'Clotho']
list2=[1,2,3,4,5]
list3=["str1", "str2", "str3", "str4"]
```

### 列表操作
* 取值
    * 切片和索引
    * list[]
* 添加
    * list.append()
* 删除
    * del(list[])
    * list.remove(list[])
* 修改
    * list[]=x
* 查找
    * var in list
* 示例：
```python
>>> list1=['jack', 20, 'male']
>>> list1
['jack', 20, 'male']
>>> list1.append('USA')
>>> list1
['jack', 20, 'male', 'USA']
>>> list1.remove('USA')
>>> list1
['jack', 20, 'male']
>>> help(list1.remove)
>>> list1[1]=22
>>> list1
['jack', 22, 'male']
>>> 22 in list1
True
```

### 对象与类快速入门

* 对象和类，更好的理解列表。
* 对象=属性+方法
* 列表是使用对象和类的一个例子
    * 当你使用变量i并给它赋值时候，比如整数5，你可以认为你创建了一个类（类型）int的对象（实例）i。
    * help(int) 
* 类也有方法，即仅仅为类而定义的函数。
    * 仅在该类的对象可以使用这些功能。
    * 例如：
        * Python为list类提供了append方法，这个方法让你在列表尾添加一个项目。
        * mylist.append('an item')列表mylist中增加字符串。**注意，使用点号来使用对象的方法。**
* 类也有变量，仅为类而定义的变量
    * 仅在该类的对象可以使用这些变量/名称
    * 通过点号使用，例如mylist.field。

## 第七节 字典
### 基本概念
* 字典是Python中唯一的映射类型（哈希表）。
* 字典对象是可变的，但是字典的键必须使用不可变的对象，并且一个字典中可以使用不同类型的键值。
* keys()或者values()返回键列表或值列表。
* items()返回包含键值对的元值。
* 示例：
```python
>>> dict={'name': 'jack', 'age' : 30, 'gender':'male' }
>>> dict['name']
'jack'
>>> dict['age']
30
>>> dict['gender']
'male'
>>> dict.keys()
['gender', 'age', 'name']
>>> dict.values()
['male', 30, 'jack']
>>> dict.items()
[('gender', 'male'), ('age', 30), ('name', 'jack')]
```

### 创建字典
* `dict = {}`
* 使用工厂方法dict()
```python
fdict=dict(['x',1], ['y',2])
```
* 内建方法：fromkeys()，字典中的元素具有相同的值，默认为None
```python
ddict={}.fromkeys(('x','y'), -1)
#输出结果：{'x': -1, 'y': -1}
```

### 访问字典中的值
* 直接使用key访问：key不存在会报错，可以使用has_key()或者in和not in判断，但是has_key方法即将废弃。
* 循环遍历：`for key in dict1.keys():`
* 使用迭代器：`for key in dict1:`

### 更新和删除
* 直接用键值访问更新；内建的`update()`方法可以将整个字典的内容拷贝到另一个字典中。
* `del dict1['a']`：删除字典中键值为a的元素
* `dict1.pop('a')`：删除并且返回键为'a'的元素
* `dict1.clear()`：删除字典所有元素
* `del dict1`：删除整个字典

### 字典相关的内建函数
* `type(), str(), cmp()`(cmp很少用于字典的比较，比较依次是字典的大小、键、值)

### 工厂函数dict()
*　例如：
```python
dict(zip(('x','y'),(1,2)))
dict(x=1,y=2)
#输出结果：{'x': 1, 'y': 2}
```
* 使用字典生成字典比用copy慢，因此这种情况下推荐使用`copy()`

### 常用函数
* `len()`：返回序列的大小
* `hash()` : 用于判断某个对象是否可以做一个字典的键，非哈希类型报TypeError错误
* `dict.clear()`:　删除字典中的所有元素
* `dict.fromkeys(seq, val=None)`: 以seq中的元素为键创建并返回一个字典，val为制定默认值
* `dict.get(key, default=None)`: 返回key的value，如果该键不存在返回default指定的值
* `dict.has_key(key)`：判断字典中是否存在key，建议使用in或not in代替
* `dict.items()`：返回健值对元组的列表
* `dict.keys()`：返回字典中键的列表
* `dict.iter*()`: iteritems(), iterkeys(), itervalues()返回迭代子而不是列表
* `dict.pop(key[,default])`：同get()，区别是若key存在，删除并返回dict[key]，若不存在则返回default，未指定值，抛出KeyError异常
* `dict.setdefault(key, default=None)`：同set()，若key存在则返回其value，若key不存在，则dict[key]=default
* `dict.update(dict2)`：将dict2中的键值对添加到字典dict中，如果有重复则覆盖，原字典不存在的条目则添加进来。
* `dict.values()`：返回字典中所有值的列表

## 第八节 流程控制

### if else

* if语句

    * Python的if语句类似其他语言。if语句包含一个逻辑表达式，使用表达式比较，在比较的结果的基础上作用出决定。

        ```python
        if expression:
            statement
        ```

    * 注：Python使用缩进作为其语句分组的方法，建议使用4个空格代替缩进。
    * 逻辑值（bool）用来表示诸如：对与错，真与假，空与非空的概念
    * 逻辑值包含了两个值：
        * True：表示非空的量（比如：string, tuple, set, dictonary等），所有非零数
        * False：表示0，None，空的量等。
    * 作用：主要用于判读语句中，用来判断
        * 一个字符串是否为空的
        * 一个运算结果是否为零
        * 一个表达式是否可用

* else语句

    * 语法

        ```python
        if expression:
            statement
        else:
            statement
        ```

    * 如果条件表达式if语句解析为0或false值。else语句是一个可选的语句，并最多只能有一个else语句。

* elif语句

    * 语法

        ```python
        if expression:
            statement
        elif expression2:
            statement
        elif expression3:
            statement
        else:
            statement
        ```

    * elif语句可以让你检查多个表达式为真值，并执行一个代码块，elif语句是可选的。可以有任意数量的elif。

* 嵌套的if...elif...else构造

    ```python
    if expression1:
        statement
        if expression2:
            statement
        else:
            statement
    else:
        statement
    ```

* 使用逻辑运算符and、or、not

    ```python
    if expression1 and expression2:
        statement
    else:
        statement
    ```


### for循环

* 循环是一个结构，导致一个程序重复一定次数。

* 条件循环也是如此。当条件变为假，循环结束。

* for循环：

    * 在Python for循环遍历序列，如一个列表或一个字符。

* for循环语法：

    ```python
    for iterating_var in sequence:
        statements
    ```

* 注：如果一个序列包含一个表达式列表，它是第一个执行。
然后，该序列中的第一项赋值给迭代变量iterating_var。接下来，执行语句块。列表中的每个项目分配到iterating_var，代码块被执行，直到整个序列被耗尽。

* 注：格式遵循代码块缩进原则

* 例子：

    ```python
    for letter in 'python':
        print 'Current Letter: ', letter
    
    fruits=['banana', 'apple', 'mango']
    for fruit in fruits:
        print 'Current fruit: ', fruit
    ```


* 迭代序列指数（索引）：
    * 遍历每个项目的另一种方法是由序列本身的偏移指数（索引）

    * 例子

        ```python
        fruits=['banana', 'apple', 'mango']
        for index in range(len(fruits)):
            print 'Current fruit: ', fruits[index]
        ```

    * 注：‘迭代’，指重复执行一个指令。

### range

* 循环结构是用于迭代多个项的for语句，迭代形式可以循环序列的所有成员。

* range(i,j[,步进值])
    * 如果所创建的对象为整数，可以用range
    * i为初始数值
    * j为终止数值，但不包括在范围内，步进值为可选参数，不选的话默认是1
    * i不选择的话默认为0

* 例子：

    ```python
    sum = 0
    for num in range(1, 101, 1):
        sum += num
    print sum
    ```


### 遍历字典

```python
    dic={'name': 'jack', 'age': 20, 'gender'：'male'}
    for key in dic:
        val = dic[key]
        print key,val

    for key,val in dic.items():
        print key, val
```


### for循环控制

```python
    for x in range(10):
        if x == 1:
            pass
        if x == 2:
            continue
        if x == 5:
            break;
    else
        print 'end'
```

### while循环

* while循环，直到表达式变为假。表达的是一个逻辑表达式，必须返回一个true或false值

* 语法：

    ```python
    while expression:
        statement
    ```


* 注：遵循代码块缩进原则

    ```python
    while x != 'q':
        x = raw_input('please input something, q for quit: ')
        if not x:
            break
    else:
        print 'end'
    ```

<br>

## 第九节 函数

- 函数就是完成特定功能的一个语句组，这组语句可以作为一个单位使用，并且给它取一个名字。

- 可以通过函数名在程序的不同地方多次执行（这通常叫做函数调用），却不需要在所有地方都重复编写这些语句。

### 自定义函数

- 用户自己编写的

### 预定义的Python函数

- 系统自带的一些函数，还有一些和第三方编写的函数，如其他程序员编写的一些函数，对于这些现成的函数用户可以直接拿来使用。

### 为什么使用函数

- 降低编程的难度
    - 通常将一个复杂的大问题分解成一系列更简单的小问题，然后将小问题继续划分成更小的问题，当问题细化为足够简单时，我们将可以分而治之。这时，我们可以使用函数来处理特定的问题，各个小问题解决了，大问题也就迎刃而解了。

- 代码重用
    - 我们定义的函数可以在一个程序的多个位置使用，也可以用于多个程序。此外，我们还可以把函数放到一个模块中供其他程序员使用，同时，我们也可以使用其他程序定义的函数。这就避免了重复劳动，提供了工作效率。

### 函数定义和调用

- 当我们自己定义一个函数时，通常使用def语句，其语法形式如下所示：

    ```python
    def 函数名 (参数列表): #可以没有参数函数体
    
    def add(a, b):
        print a + b
    ```

- 调用函数的一般形式是：

    ```python
    函数名（参数列表）
    
    add(1, 2)
    ```

### 形式参数和实际参数

- 在定义函数时函数后面圆括号中的变量名称叫做“形式参数”，或简称为“形参”

- 在调用函数时，函数名后面圆括号中的变量名称叫做“实际参数”，或简称为“实参”

### 缺省参数（默认参数）

- 默认参数只能从右至左给定，如果需要第一个参数给默认值，其他参数不给，那么把第一个参数移到最后一个即可。

    ```python
    def add(a, b = 2):
        print a + b
    
    add(3)                  #result : 5
    ```

### 局部变量和全局变量

- Python中的任何变量都有其特定的作用域。

- 在函数中定义的变量一般只能在该函数内部使用，这些只能在程序的特定部分使用的变量我们称之为局部变量。

- 在一个文件顶部定义的变量可以供该文件中的任何函数调用，这些可以为整个程序所使用的变量称为全局变量。

    ```python
    x = 100         #全局变量，可以在文件任何地方调用
    
    def func():
        x = 200     #局部变量，只能在函数内部调用
        print x
    
    func()          #输出200
    print x         #输出100
    ```

### global语句
- 强制声明为全局变量

    ```python
    x = 100
    
    def func():
        global x    #强制声明x为全局变量,导致值被覆盖
        x = 200
    
    func()
    print x         #输出200
    ```

### 函数返回值

- 函数被调用后会返回一个指定的值

- 函数调用后默认返回None

- return返回值

- 返回值可以是任意类型

- return执行后，函数终止

- 区分返回值和打印

    ```python
    def add(a, b):
        return a + b
    
    ret = add(1, 2)     #将函数返回结果赋值给变量ret
    print ret           #输出3
    ```

### 向函数传入元组和字典
- `func (*args)`

    ```python
    def func(x, y):
        print x, y
    
    t = (1, 2)
    func(*t)
    ```

- `func (**kw)`

    ```python
    def func(name='jack', age=30):
        print name,age
    
    d = {'age': 22, 'name' : 'mike'};
    func(**d)
    ```

### 处理多余实参
- `def func(*args, **kw)`

    ```python
    def func(x, *args, **kw):
        print x
        print args
        print kw
    
    func(1, 2, 3, 4, 5, y=10, z=20)
    
    #输出
    1
    (2, 3, 4, 5)
    {'y': 10, 'z': 20}
    ```

### lambda表达式
- 匿名函数
    - lambda函数是一种快速定义单行的最小函数，是从Lisp借用来的，可以用在任何需要函数的地方。

            lambda x,y:x*y

    - 使用Python写一些执行脚本时，使用lambda可以省去定义函数的过程，让代码更加精简。
    - 对于一些抽象的，不会别的地方再复用的函数，有时候给函数起个名字也是个难题，使用lambda不需要考虑命名的问题。
    - 使用lambda在某些时候让代码更容易理解。

### lambda基础
- lambda语句中，冒号前是参数，可以有多个，用逗号隔开，冒号右边的返回值。lambda语句构建的其实是一个函数对象

    ```python
    g = lambda x:x**2
    print g
    <function <lambda> at 0x0000000002643A58>
    ```

### lambda应用实例
- reduce为逐次操作list里的每项，接收的参数为2个，最后返回的为一个结果。

    ```python
    sum = reduce(lambda x,y:x*y, range(1,6))
    print sum
    ```

### switch语句
- switch语句用于编写多分支结构的程序，类似与if...elif...else语句。
- switch语句表达的分支结构比if...elif...else语句表达的更清晰，代码的可读性更高。
- 但是python并没有提供switch语句

### switch实现
- python可以通过字典实现switch语句的功能。
- 实现方法分为两步
    - 首先，定义一个字典
    - 其次，调用字典的get()获取相应的表达式

### 函数调用
- 通过字典调用函数

    ```python
    def add(a, b):
        return a + b
    
    def sub(a, b):
        return a - b
    
    def mul(a, b):
        return a * b
    
    def div(a, b):
        return a / b
    
    operator = {'+': add, '-': sub, '*': mul, '/': div}     #通过字典实现switch语句的功能
    
    def calc(a, o, b):
        return operator.get(o)(a, b)
    
    print calc(4, '+', 2)
    print calc(4, '-', 2)
    print calc(4, '*', 2)
    print calc(4, '/', 2)
    ```


## 第十节 内置函数
### help函数可以用来查看函数的用法

```bash
help(range)

#输出结果
Help on built-in function range in module __builtin__:

range(...)
    range(stop) -> list of integers
    range(start, stop[, step]) -> list of integers

    Return a list containing an arithmetic progression of integers.
    range(i, j) returns [i, i+1, i+2, ..., j-1]; start (!) defaults to 0.
    When step is given, it specifies the increment (or decrement).
    For example, range(4) returns [0, 1, 2, 3].  The end point is omitted!
    These are exactly the valid indices for a list of 4 elements.
```

### 常用函数

- `abs(number)`: 绝对值
- `max(iterable[, key=func])`: 最大值
- `min(iterable[, key=func])`: 最小值
- `len(collection)`: 取得一个序列或集合的长度
- `divmod(x, y)`: 求两个数的商和模，返回一个元组(x//y, x%y)
- `pow(x, y[, z])`: 求一个数的幂运算
- `round(number[, ndigits])`: 对一个数进行指定精度的四舍五入
- `callable(object)`: 判断一个对象是否可调用
- `isinstance(object, class-or-type-or-tuple)`：判断对象是否为某个类的实例
- `cmp(x, y)`: 比较两个数或字符串大小
- `range(start [,stop, step])`: 返回一个范围数组，如range(3), 返回[0,1,2]
- `xrange(start [,stop, step])`: 作用与range相同，但是返回一个xrange生成器，当生成范围较大的数组时，用它性能较高

### 类型转换函数
- type()

    ```python
    type(object) -> the object's type
    type(name, bases, dict) -> a new type
    ```

- int()

    ```python
    int(x=0) -> int or long
    int(x, base=10) -> int or long
    ```

- long()

    ```python
    long(x=0) -> long
    long(x, base=10) -> long
    ```

- float()

    ```python
    float(x) -> floating point number
    ```

- complex()

    ```python
    complex(real[, imag]) -> complex number
    ```

- str()

    ```python
    str(object='') -> string
    ```

- list()

    ```python
    list() -> new empty list
    list(iterable) -> new list initialized from iterable's items
    ```

- tuple()

    ```python
    tuple() -> empty tuple
    tuple(iterable) -> tuple initialized from iterable's items
    ```

- hex()

    ```python
    hex(number) -> string
    ```

- oct()

    ```python
    oct(number) -> string
    ```

- chr()

    ```python
    chr(i) -> character
    ```

- ord()

    ```python
    ord(c) -> integer
    ```

### string函数
- str.capitalize()

    ```python
    >>> s = "hello"
    >>> s.capitalize()
    'Hello'
    ```

- str.replace()

    ```python
    >>> s = "hello"
    >>> s.replace('h', 'H')
    'Hello'
    ```


- str.split()

    ```python
    >>> ip = "192.168.1.123"
    >>> ip.split('.')
    ['192', '168', '1', '123']
    ```

### 序列处理函数

- len()

    ```python
    >>>l = range(10)
    >>> len(l)
    10
    ```

- max()

    ```python
    >>>l = range(10)
    >>> max(l)
    9
    ```

- min()

    ```python
    >>>l = range(10)
    >>> min(l)
    0
    ```

- filter()

    ```python
    >>>l = range(10)
    >>> filter(lambda x: x>5, l)
    [6, 7, 8, 9]
    ```

- zip()

    ```python
    >>> name=['bob','jack','mike']
    >>> age=[20,21,22]
    >>> tel=[131,132]
    >>> zip(name, age)
    [('bob', 20), ('jack', 21), ('mike', 22)]
    >>> zip(name,age,tel)
    [('bob', 20, 131), ('jack', 21, 132)]       #如果个数不匹配会被忽略
    ```

- map()

    ```python
    >>> map(None, name, age)
    [('bob', 20), ('jack', 21), ('mike', 22)]
    >>> map(None, name, age, tel)
    [('bob', 20, 131), ('jack', 21, 132), ('mike', 22, None)]       #个数不匹配时，没有值的会被None代替
    
    >>> a = [1,3,5]
    >>> b = [2,4,6]
    >>> map(lambda x,y:x*y, a, b)
    [2, 12, 30]
    ```

- reduce()

    ```python
    >>> reduce(lambda x,y:x+y, range(1,101))
    5050
    ```

### lambda -> 列表表达式

- map的例子，可以写成

    ```python
    print map(lambda x:x*2+10, range(1,11))
    print [x*2+10 for x in range(1,11)]
    ```

- 非常的简洁，易懂。filter的例子可以写成：

    ```python
    print filter(lambda x:x%3==0, range(1,11))
    print [x for x in range(1,11) if x%3 == 0]
    ```

<br>

## 第十一节 模块
### 简介
- 模块是python组织代码的基本方式
- python的脚本都是用扩展名为py的文本文件保存的，一个脚本可以单独运行，也可以导入另一个脚本中运行。当脚本被导入运行时，我们将其称为模块(module)

### 包
- python的模块可以按目录组织为包
- 创建一个包的步骤是：
    - 建立一个名字为包名字的文件夹
    - 在该文件夹下创建一个`__init__.py`文件
    - 根据需要在该文件夹下存放脚本文件、已编译扩展及子包
    - `import pack.m1, pack.m2, pack.m3`

### 模块
- 模块名与脚本的文件名相同
    - 例如我们编写了一个名为`items.py`的脚本，则可在另外一个脚本中用`import items`语句来导入它

### 总结
- 模块是一个可以导入的python脚本文件
- 包是一堆目录组织的模块和子包，目录下的`__init__.py`文件存放了包的信息
- 可以用`import, import as, from import`等语句导入模块和包
    ​      
    ```python
    #假设有一个模块名为calc.py
    import calc
    import calc as calculate
    from calc import add
    ```

<br>

## 第十二节 正则表达式

### 目标
- 掌握正则表达式的规则

### 案例
- 一个小爬虫

### 简介
- 正则表达式（或re）是一种小型的、高度专业化的编程语言，（在python中）它内嵌在python中，并通过re模块实现
    - 可以为想要匹配的相应字符串集指定规则
    - 该字符集可能包含英文语句、e-mail地址、命令或任何你想搞定的东西
    - 可以问诸如“这个字符串匹配该模式吗”
    - “在这个字符串中是否有部分匹配该模式呢？”
    - 你也可以使用re以各种试来修改或分割字符串

- 正则表达式模式被编译成一系列的字节码，然后由C编写的匹配引擎执行
- 正则表达式语言相对小型和受限（功能有限）
    - 并非所有字符串处理都能用正则表达式完成

### 字符匹配
- 普通字符
    - 大多数字母和数字一般都会和自身匹配
    - 如正则表达式test会和字符串"test"完全匹配
- 元字符

        .   ^   $   *   +   ?   {}  []  \   |   ()

    - `[]`
        - 常用来指定一个字符集：`[abc]  [a-z]`
        - 元字符在字符集中不起作用：`[akm$]`
        - 补集匹配不在区间范围内的字符：`[^5]`

            ```python
            import re
            
            regExp = r't[0-9]p'
            print re.findall(regExp, 't1p t2p')
            ```

    - `^`

        - 匹配行首。除非设置MULTILINE标志，它只是匹配字符串的开始。在MULTILINE模式里，它也可以匹配字符串中的每个换行。

    - `$`

        - 匹配行尾，行尾被定义为要么是字符串尾，要么是一个换行字符后面的任何位置。

    - `\`
        - 反斜杠后面可以加不同的字符以表示不同特殊意义
        - 也可以用于取消所有的元字符：`\[`或`\\`

                \d  匹配任何十进制数，它相当于[0-9]
                \D  匹配任何非数字字符，它相当于[^0-9]
                \s  匹配任何空白字符，它相当于[\t\n\r\f\v]
                \S  匹配任何非空白字符，它相当于[^\t\n\r\f\v]
                \w  匹配任何字母数字字符，它相当于[a-zA-Z0-9]
                \W  匹配任何非字母数字字符，它相当于[^a-zA-Z0-9]

    - 重复

        - 正则表达式第一功能是能够匹配不定长的字符集，另一个功能就是可以指定正则表达式的一部分的重复次数。

    - `*`

        - 指定前一个字符可能被匹配零次或更多次，而不是只有一次。匹配引擎会试着重复尽可能多的次数（不超过整数界定范围，20亿）

    - `+`
        - 表示匹配一次或更多次
        - 注意*和+之间的不同：*匹配零或更多次，所以可以根本不出现，而+则要求至少出现一次

    - `?`

        - 匹配一次或零次，你可以认为它用于标识某事物是可选的

    - `{m,n}`
        - 其中`m`和`n`是十进制整数。该限定符的意思是至少有m个重复，至多到n个重复
        - 忽略m会认为下边界是0，而忽略n的结果将是上边界为无穷大（实现上是20亿）
        - `{0,}`等同于`*`，`{1,}`等同于`+`，而`{0,1}`则与`?`相同。如果可以的话，最好使用`*`，`+`或`?`

### 使用正则表达式
- `re`模块提供了一个正则表达式引擎的接口，可以让你将REstring编译成对象并用它们来进行匹配
- 编译正则表达式

    ```python
    >>> import re
    >>> p = re.compile('ab*')
    >>> print p
    <_sre.SRE_Pattern object at 0x00000000004D1CA8>
    ```

- `re.compile()`也可以接受可选择的标志参数，常用来实现不同的特殊功能和语法变更

    ```python
    p = re.compile('ab*', re.IGNORECASE)
    ```

### 反斜杠的麻烦
- 字符串前加`"r"`反斜杠就不会被任何特殊方式处理

| 字符          | 阶段                                                             |
| ------------- | ---------------------------------------------------------------- |
| \section      | 要匹配的字符串                                                   |
| \\section     | 为re.compile取消反斜杠的特殊意义                                 |
| "\\\\section" | 为"\\section"的字符串实值（string literals）取消反斜杠的特殊意义 |

### 执行匹配
- 'RegexObject'实例有一些方法和属性，完整的列表可查阅Python Library Reference

| 方法/属性  | 作用                                             |
| ---------- | ------------------------------------------------ |
| match()    | 决定RE是否在字符串刚开始的位置匹配               |
| search()   | 扫描字符串，找到这个RE匹配的位置                 |
| findall()  | 找到RE匹配的所有子串，并把它们作为一个列表返回   |
| finditer() | 找到RE匹配的所有子串，并把它们作为一个迭代器返回 |

        如果没有匹配到的话，match()和search()将返回None。
        如果成功的话，就会返回一个'MatchObject'实例。

- MatchObject实例方法

| 方法/属性 | 作用                                     |
| --------- | ---------------------------------------- |
| group()   | 返回被RE匹配的字符串                     |
| start()   | 返回匹配开始的位置                       |
| end()     | 返回匹配结束的位置                       |
| span()    | 返回一个元组包含匹配（开始，结束）的位置 |


- 实际程序中，最常见的作法是将'MatchObject'保存在一个变量里，然后检查它是否为None

    ```python
    p = re.compile('ab*', re.I)
    m = p.match('aaaabcccccabcc')
    
    if m:
        print 'Match found : ', m.group()
    else:
        print 'No match'
    ```

### 模块级函数

- re模块也提供了顶级函数调用如`match()、search()、sub()、subn()、split()、findall()`等
- 查看模块的所有属性和方法: `dir(re)`


### 编译标志-flags
| 标志          | 含义                                             |
| ------------- | ------------------------------------------------ |
| DOTALL, S     | 使.匹配包括换行在内的所有字符                    |
| IGNORECASE, I | 使匹配对大小写不敏感                             |
| LOCALE, L     | 做本地化识别（local-aware）匹配.法语等           |
| MULTILINE, M  | 多行匹配，影响^和$                               |
| VERBOSE, X    | 能够使用REs的verbose状态，使之被组织得更清晰易懂 |

```python
charref = re.compile(r"""
(
[0-9]+[^0-9]    #Decimal form
| 0[0-7]+[^0-7] #Octal form
| x[0-9a-fA-F]+[^0-9a-fA-F] #Hexadecimal form
)
""", re.VERBOSE)
```

### 分组()

```python
email = r"\w+@\w+(\.com|\.cn)"
```

### 一个小爬虫
- 下载贴吧或空间中所有图片

    ```python
    import re
    import urllib
    
    def getHtml(url):
        page = urllib.urlopen(url)
        html = page.read()
        return html
    
    def getImg(html):
        reg = r'src="(.*?\.jpg)" width'
        imgre = re.compile(reg)
        imglist = re.findall(imgre, html)
        x = 0
        for imgurl in imglist:
            urllib.urlretrieve(imgurl, '%s.jpg' % x)
            x++
    
    getImg(getHtml(url))
    ```



## 第十三节 python对内存的使用
### 浅拷贝和深拷贝
- 所谓浅拷贝就是对引用的拷贝（只拷贝父对象）
- 所谓深拷贝就是对对象的资源的拷贝
- 解释一个例子：

    ```python
    import copy
    a = [1,2,3,['a','b','c']]
    b = a
    c = copy.copy(a)
    d = copy.deepcopy(a)
    ```



## 第十四节 文件与目录
### 目标
- 文件的打开和创建
- 文件读取
- 文件写入
- 内容查找和替换
- 文件删除、复制、重命名
- 目录操作

### 案例
- 目录分析器
- 杀毒软件
- 系统垃圾清理工具

### python文件读写
- python进行文件读写的函数是`open`或`file`
- `file_handle = open(filename, mode)`

| **模式** | **说明**                                                           |
| -------- | ------------------------------------------------------------------ |
| r        | 只读                                                               |
| r+       | 读写                                                               |
| w        | 写入，先删除原文件，在重新写入，如果文件没有则创建                 |
| w+       | 读写，先删除原文件，在重新写入，如果文件没有则创建（可以写入输出） |
| a        | 写入，在文件末尾追加新的内容，文件不存在，创建之                   |
| a+       | 读写，在文件末尾追加新的内容，文件不存在，创建之                   |
| b        | 打开二进制文件。可以与r、w、a、+结合使用                           |
| U        | 支持所有的换行符号。"\r"、"\n"、"\r\n"                             |

### 文件对象方法
- close
    - 格式
        - `FileObject.close()`
    - 说明
        - 关闭文件，关闭前，会将缓存中的数据先写入文件。

- readline
    - 格式
        - `String = FileObject.readline([size])`
    - 说明
        - 每次读取文件的一行
        - size:是指每行每次读取size个字节，直到行的末尾

- readlines
    - 格式
        - `List = FileObject.readlines([size])`
    - 说明
        - 多行读，返回一个列表
        - size: 每次读入size个字符，然后继续按size读，而不是每次读入行的size个字符

- read
    - 格式
        - `String = FileObject.read([size])`
    - 说明
        - 读出文件的所有内容，并复制给一个字符串
        - size: 读出文件的前[size]个字符，并输出给字符串，此时文件的指针指向size处

- next
    - 格式
        - `FileObject.next()`
    - 说明
        - 返回当前行，并将文件指针到下一行

- write
    - 格式
        - `FileObject.write(string)`
    - 说明
        - write和后面的writelines在写入前会是否清除文件中原来所有的数据，在重新写入新的内容，取决于打开文件的模式

- writelines
    - 格式
        - `FileObject.writelines(List)`
    - 说明
        - 多行写
        - 效率比write高，速度更快，少量写入可以使用write

- seek
    - 格式
        - `FileObject.seek(偏移量，选项)`
    - 说明
        - 选项=0时，表示将文件指针指向从文件头部到“偏移量”字节处。
        - 选项=1时，表示将文件指针指向从文件的当前位置，向向移动“偏移量”字节。
        - 选项=2时，表示将文件指针指向从文件的尾部，向前移动“偏移量”字节。

- flush
    - 格式
        - `FileObject.flush()`
    - 说明
        - 提交更新

### 文件查找和替换

- 文件查找
- cat a.txt

    ```reStructuredText
    hello world
    hello hello world
    ```

- 统计文件中hello的个数

    ```python
    import re
    
    fp = file("a.txt", "r")
    count = 0
    for s in fp.readlines():
        li = re.findall("hello", s)
        if len(li) > 0:
            count = count + len(li)
    
    print "Search ",count," hello"
    fp.close()
    ```

- 文件内容替换
- 问题：把a.txt中的hello替换为good, 并保存结果到b.txt中
- 示例代码一：

    ```python
    fp1 = file("a.txt", "r")
    fp2 = file("b.txt", "w")
    
    for s in fp1.readlines():
        fp2.write(s.replace("hello", "good"))
    
    fp1.close()
    fp2.close()
    ```

- 示例代码二：

    ```python
    fp1 = file("a.txt", "r")
    fp2 = file("b.txt", "w")
    
    s = fp1.read()
    fp2.write(s.replace("hello", "good"))
    
    fp1.close()
    fp2.close()
    ```

### 目录操作

- 目录操作就是通过python来实现目录的创建，修改，遍历等功能
- `import os`
    - 目录操作需要调用os模块
    - 比如`os.mkdir('/root/demo')`

- 常用函数

| 函数                                  | 说明           |
| ------------------------------------- | -------------- |
| mkdir(path[,mode=0777])               | 创建单个目录   |
| makedirs(name,mode=511)               | 创建多层级目录 |
| rmdir(path)                           | 删除单个目录   |
| removedirs(path)                      | 删除多层级目录 |
| listdir(path)                         | 列出目录       |
| getcwd()                              | 取得当前目录   |
| chdir(path)                           | 切换目录       |
| walk(top, topdown=True, onerror=None) |                |

- 案例

    - 系统垃圾清除小工具

- 方式
    - 递归函数
    - `os.walk()`函数
        - 函数声明：`os.walk(path)`
        - 该函数返回一个元组，该元组有3个元素，这3个元素分别表示每次遍历的路径名，目录列表和文件列表。

            ```python
            for path, dirlist, filelist in os.walk('.'):
                for filename in filelist:
                    print os.path.join(path, filename)
            ```

## 第十五节 异常处理
### 异常以及异常抛出
- 异常抛出机制，为程序开发人员提供了一种在运行时发现错误，进行恢复处理，然后继续执行的能力。下面是一个异常处理实例：

    ```python
    try:
        f = open('unfile.py', 'r')
    except IOError, e:
        print False,str(e)
    
    False [Errno 2] No such file or directory: 'unfile.py'
    ```

### 抛出机制
- 如果在运行时发生异常的话，解释器会查找相应的处理语句（称为handler）。
- 要是在当前函数里没有找到的话，它会将异常传递给上层的调用函数，看看那里能不能处理。
- 如果在最外层（全局“main”）还是没有找到的话，解释器就会退出，同时打印出traceback以便让用户找出错误产生的原因。
- 注意：虽然大多数错误会导致异常，但一个异常不一定代表错误。有时候它们只是一个警告，有时候它们可能是一个终止信号，比如退出循环等。

### finally子句
- python提供try-finally子句来表述这样的情况：我们不关心捕捉到是什么错误，无论错误是不是发生，这些代码“必须”运行，比如文件关闭，释放锁，把数据库连接还给连接池等。比如：

    ```python
    try:
        f = open('unfile.py', 'r')
    except Exception, e:
        print False,str(e)
    finally:
        print "exec finally"
    ```

### raise抛出异常

- 到目前为止，我们只讨论了如何捕捉异常，那么如何抛出异常？
- 使用raise来抛出一个异常：

    ```python
    if 'a' > 5:
        raise TypeError("Error: 'a' must be integer.")
    ```

### 常见的python异常

| 异常              | 描述                                                                                 |
| ----------------- | ------------------------------------------------------------------------------------ |
| AssertionError    | assert语句失败                                                                       |
| AttributeError    | 试图访问一个对象没有的属性                                                           |
| IOError           | 输入输出异常，基本是无法打开文件                                                     |
| ImportError       | 无法引入模块或者包，基本是路径问题                                                   |
| IndentationError  | 语法错误，代码没有正确的对齐                                                         |
| IndexError        | 下标索引超出序列边界                                                                 |
| KeyError          | 试图访问你字典里不存在的键                                                           |
| KeyBoardInterrupt | Ctrl+C被按下                                                                         |
| NameError         | 使用一个还未赋予对象的变量                                                           |
| SyntaxError       | python代码逻辑语法出错，不能执行                                                     |
| TypeError         | 传入的对象类型与要求不符                                                             |
| UnboundLocalError | 试图访问一个还未设置的全局变量，基本上是由于另有一个同名的全局变量，导致你以为在访问 |
| ValueError        | 传入一个不被期望的值，即使类型正确                                                   |

<br>

## 第十六节 MySQLdb
- [win64位安装python-mysqldb1.2.5](http://www.cnblogs.com/lgh344902118/p/6244266.html)

- ubuntu下安装MySQLdb

    ```bash
    sudo apt-get install python-MySQLdb
    ```

- 导入MySQLdb库

    ```python
    import MySQLdb
    ```

- 创建数据库连接

    ```python
    conn = MySQLdb.connect(host="localhost",user="root",passwd="123456",db="test",charset="utf8")
    ```

- connect对象属性
    - `commit()`:如果数据库表进行了修改，提交保存当前的数据。当然，如果此用户没有权限就作罢了，什么也不会发生。
    - `rollback()`:如果有权限，就取消当前的操作，否则报错。
    - `cursor([cursorclass])`:游标指针。

- 创建游标（指针）cursor

    ```python
    cur = conn.cursor()
    ```

- cursor执行命令的方法:
    - `execute(query, args)`:执行单条sql语句。query为sql语句本身，args为参数值的列表。执行后返回值为受影响的行数。
    - `executemany(query, args)`:执行单条sql语句,但是重复执行参数列表里的参数,返回值为受影响的行数

- 在数据表中插入一条记录

    ```python
    cur.execute("insert into users (username,password,email) values (%s,%s,%s)",("python","123456","python@gmail.com"))
    ```

- 在数据表中插入多条记录

    ```python
    cur.executemany("insert into users (username,password,email) values (%s,%s,%s)",(("google","111222","g@gmail.com"),("facebook","222333","f@face.book"),("github","333444","git@hub.com"),("docker","444555","doc@ker.com")))
    ```

- 提交数据库操作

    ```python
    conn.commit()
    ```

- 查询数据

    ```python
    cur.execute("select * from users")
    ```

    - cursor对象获取数据的方法
        - `fetchall(self)`:接收全部的返回结果行.
        - `fetchmany(size=None)`:接收size条返回结果行.如果size的值大于返回的结果行的数量,则会返回cursor.arraysize条数据.
        - `fetchone()`:返回一条结果行.
        - `scroll(value, mode='relative')`:移动指针到某一行.如果mode='relative',则表示从当前所在行移动value条,如果mode='absolute',则表示从结果集的第一行移动value条.

            ```python
            cur.execute("select * from users")
            lines = cur.fetchall()
            for line in lines:
                print line
            
            cur.execute("select * from users where id=1")
            line_first = cur.fetchone()     #只返回一条
            print line_first
            
            cur.execute("select * from users")
            print cur.fetchall()
            ```

- 游标cursor的操作

    - `cur.scroll(n)`或`cur.scroll(n,"relative")`：意思是相对当前位置向上或者向下移动，n为正数，表示向下（向前），n为负数，表示向上（向后）

    - 还有一种方式，可以实现“绝对”移动，不是“相对”移动：增加一个参数"absolute"

        ```python
        cur.scroll(1)
        cur.scroll(-2)
        cur.scroll(2,"absolute")    #回到序号是2,但指向第三条
        ```

- 更新数据

    ```python
    cur.execute("update users set username=%s where id=2",("mypython"))
    conn.commit()
    ```

- 指定数据库

    ```python
    conn = MySQLdb.connect("localhost","root","123456",port=3306,charset="utf8")    #创建数据库时不指定那个数据库
    conn.select_db("test")      #连接创建后再指定
    ```

- 关闭数据库

    ```python
    cur.close()     #先关闭游标
    conn.close()    #再关闭数据库
    ```

## 第十七节 面向对象

### 类和对象

- 面向过程和面向对象的编程
    - 面向过程的编程：函数式编程，C程序等
    - 面向对象的编程：C++，Java，Python等

- 类和对象：是面向对象中的两个重要概念
    - 类：是对事物的抽象，比如：汽车模型
    - 对象：是类的一个实例，比如:QQ轿车，大客车

- 范例说明
    - 汽车模型可以对汽车的特征和行为进行抽象，然后可以实例化一台真实的汽车实体出来

### Python类定义
- Python类的定义
    - 使用class关键字定义一个类，并且类名的首字母要大写
    - 当程序员需要创建的类型不能用简单类型表示时就需要创建类
    - 类把需要的变量和函数组合在一起，这种包含也称之为“封装”

- Python类的结构

    ```python
    class 类名：
        成员变量
        成员函数
    
    class MyClass():
        first = 123
        def fun(self):
            print "I am function"    
    ```

- 对象的创建
    - 创建对象的过程称之为实例化；当一个对象被创建后，包含三个方面的特性：对象的句柄、属性和方法。
        - 句柄用于区分不同的对象
        - 对象的属性和方法与类中的成员变量和成员函数对应

            ```python
            if __name__ == "__main__":
                myClass = MyClass()     #创建类的一个实例
            ```

- 构造函数__init__

    ```python
    class Person:
        def __init__(self, name, lang, website):
            self.name = name
            self.lang = lang
            self.website = website
    ```

- self是一个很神奇的参数

    - self指向类的一个实例，当实例调用方法时，self就指向这个调用的方法的实例

- 子类、父类和继承

    ```python
    # 抽象形状类
    class Shape:
        # 类的属性
        edge = 0
        # 构造函数
        def __init__(self, edge):
            self.edge = edge
        # 类的方法
        def getEdge(self):
            return self.edge
        # 抽象方法	
        def getArea(self):
            pass
    
    #三角形类，继承抽象形状类
    class Triangle(Shape):
        width = 0
        height = 0
        # 构造函数
        def __init__(self, width, height):
            #调用父类构造函数
            Shape.__init__(self, 3)
            self.width = width
            self.height = height
        #重写方法
        def getArea(self):
            return self.width * self.height / 2
    
    #四边形类，继承抽象形状类		
    class Rectangle(Shape):
        width = 0
        height = 0
        # 构造函数
        def __init__(self, width, height):
            #调用父类构造函数
            Shape.__init__(self, 4)
            self.width = width
            self.height = height
        #重写方法
        def getArea(self):
            return self.width * self.height
            
    triangle = Triangle(4,5);
    print triangle.getEdge()
    print triangle.getArea()
    
    rectangle = Rectangle(4,5);
    print rectangle.getEdge()
    print rectangle.getArea()
    ```

- python支持多继承，但不推荐使用
