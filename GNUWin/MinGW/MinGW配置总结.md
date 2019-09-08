[TOC]

# MinGW配置总结

## 简介

- MinGW是“Minimalist GNU for Windows”的缩写，是原生Microsoft Windows应用程序的极简开发环境。

- MinGW提供了一个完整的开源编程工具集，它适合于本地MS-Windows应用程序的开发，并且不依赖于任何第三方C-运行时DLL。（它确实依赖于Microsoft本身提供的许多DLL，作为操作系统的组件；其中最值得注意的是MSVCRT.DLL，Microsoft C运行时库）。此外，线程应用程序必须附带作为MinGW本身的一部分提供的可自由分发的线程支持DLL。

- MinGW编译器提供对Microsoft C运行时和一些特定于语言的运行时的功能的访问。作为极简主义者，MinGW不会也不会试图为MS-Windows上的POSIX应用程序部署提供POSIX运行时环境。如果您想要在这个平台上部署POSIX应用程序，请考虑Cygwin。

- 主要用于本地MS-Windows平台上的开发人员使用，但也可用于跨主机使用（参见下面的注释——您可能需要遵循“read more”链接才能看到它），MinGW包括：
    - GNU编译器集合（GCC）的一个端口，包括C、C++、ADA和FORTRAN编译器；
    - 用于Windows的GNU Binutils（汇编程序、链接器、归档管理器）
    - 命令行安装程序，带有可选的GUI前端（mingw-get），用于在MS-Windows上部署MinGW和MSYS
    - GUI首次设置工具（mingw-get-setup），用于启动并使用mingw-get运行。
    - MSYS是“Minimal SYStem”的缩写，是一个Bourne Shell命令行解释器系统。作为Microsoft的cmd.exe的替代，它提供了一个通用命令行环境，特别适合与MinGW一起使用，用于将许多开放源码应用程序移植到MS-Windows平台；Cygwin-1.3的一个轻量级分支，它包含一些Unix工具，这些工具被选择用于促进这一目标。

## 下载

https://osdn.net/projects/mingw/downloads/68260/mingw-get-setup.exe/

> mingw-get已过时，被MinGW-w64取代了



# [MinGW-w64安装教程——著名C/C++编译器GCC的Windows版本](https://www.cnblogs.com/ggg-327931457/p/9694516.html)

## **一、什么是 MinGW-w64 ？**

- MinGW 的全称是：Minimalist GNU on Windows 。它实际上是将经典的开源 C语言 编译器 GCC 移植到了 Windows 平台下，并且包含了 Win32API ，因此可以将源代码编译为可在 Windows 中运行的可执行程序。而且还可以使用一些 Windows 不具备的，Linux平台下的开发工具。一句话来概括：MinGW 就是 GCC 的 Windows 版本 。

- 以上是 MinGW 的介绍，MinGW-w64 与 MinGW 的区别在于 MinGW 只能编译生成32位可执行程序，而 MinGW-w64 则可以编译生成 64位 或 32位 可执行程序。

- 正因为如此，MinGW 现已被 MinGW-w64 所取代，且 MinGW 也早已停止了更新，内置的 GCC 停滞在了 4.8.1 版本，而 MinGW-w64 内置的 GCC 则更新到了 6.2.0 版本。

 

## 二、为什么使用 MinGW-w64 ？

1. MinGW-w64 是开源软件，可以免费使用。
2. MinGW-w64 由一个活跃的开源社区在持续维护，因此不会过时。
3. MinGW-w64 支持最新的 C语言 标准。
4. MinGW-w64 使用 Windows 的C语言运行库，因此编译出的程序不需要第三方 DLL ，可以直接在 Windows 下运行。
5. 那些著名的开源 IDE 实际只是将 MinGW-w64 封装了起来，使它拥有友好的图形化界面，简化了操作，但内部核心仍然是 MinGW-w64。

- MinGW-w64 是稳定可靠的、持续更新的 C/C++ 编译器，使用它可以免去很多麻烦，不用担心跟不上时代，也不用担心编译器本身有bug，可以放心的去编写程序。

 

## **三、MinGW-w64 适合做什么？**

- 对于熟悉 MinGW-w64 的高手而言，它可以编译任何 C语言 程序。但对于一般人来说，MinGW-w64 太过简陋，连图形用户界面都没有。这让习惯使用鼠标的人，感到很痛苦。虽然也可以通过一些配置，让 MinGW-w64 拥有图形用户界面，但那个过程非常麻烦。

- 除此之外，编译复杂的程序时，还需要你会编写 Makefile ，否则只能一个文件一个文件的编译，可想而知会多么辛苦。

- 但对于初学 C语言 的人来说，MinGW-w64 是正合适的编译器，至少黑色的命令提示符界面很有编程的气氛，感觉很酷。

- 在刚开始学 C语言 时，所有代码通常都写在一个文件中，只要输入几个简单的命令，就能用 MinGW-w64 编译成可执行文件。虽然  VS2015 等编译器，只要点击下鼠标就可以完成编译，但它会自动生成一大堆工程文件，让初学者摸不着头脑。而 MinGW-w64 则只会生成一个可执行文件。

- 如果对 MinGW-w64 和 VS2015 等编译器进行一下形容，那么 MinGW-w64 是手动的，而  VS2015 等编译器则是自动的。因此 MinGW-w64 的编译过程更加直观容易理解，也比较适合C语言学习。

- 总而言之，对于一般人来说，MinGW-w64 适合学习 C语言 时使用，真正工作还是用  VS2015 更好。当然如果您是在 Linux 下工作，那么Code::Blocks可能是一个选择，不过最大的可能是您必须习惯使用 GCC 来编译程序。





























