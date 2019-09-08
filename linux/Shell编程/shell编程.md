命令行的艺术
https://github.com/jlevy/the-art-of-command-line/blob/master/README-zh.md

Awesome Shell
https://github.com/alebcay/awesome-shell/blob/master/README_ZH-CN.md

## Shell历史
- Shell的作用是解释用户的命令，用户输入一条命令，Shell就解释执行一条，这条方式称为交互式(interactive)，Shell还有一种执行命令的方式称为批处理(batch)，用户事先写一个Shell脚本(script)，其中有很多条命令，让Shell一次把这些命令执行完，而不必一条条地敲命令。Shell脚本和编程语言相似，也有变量和流程控制语句，但Shell脚本是解释执行的，不需要编译，Shell程序从脚本中一行一行读取并执行这些命令，相当于一个用户把脚本中的命令一行一行敲到Shell提示符下执行。

- 由于历史原因，UNIX系统上有很多种Shell：
  - 1、**sh**(Bourne Shell)：由Steve Bourne开发，各种UNIX系统都配有sh。

  - 2、**csh**(C Shell)：由Bill Joy开发，随BSD UNIX发布，它的流程控制语句很象C语言，支持很多Bourne Shell把不支持的功能：作业控制，命令历史，命令行编辑。

  - 3、**ksh**(Korn Shell)：由David Korn开发，向后兼容sh的功能，并且添加了csh引入的新功能，是目前很多UNIX系统标准配置的Shell，在这些系统上/bin/sh往往是指向/bin/ksh的符号链接。

  - 4、**tcsh**(TENEX C Shell)：是csh的增强版本，引入了命令补全等功能，在FreeBSD、MacOS X等系统上替代了csh。

  - 5、**bash**(Bourne Again Shell)：由GNU开发的Shell，主要目标是与POSIX标准保持一致，同时兼顾对sh的兼容，bash从csh和ksh借鉴了很多功能，是各种Linux发行版标准配置的Shell，在Linux系统上/bin/sh往往是指向/bin/bash和符号链接。虽然如此，bash和sh还是有很多不同的，一方面，bash扩展了一些命令和参数，另一方面，bash并不完全和sh兼容，有些行为并不一致，所以bash需要模拟sh的行为：当我们通过sh这个程序名启动bash时，bash可以假装自己是sh，不认扩展的命令，并且行为与sh保持一致。

     ```bash
     cat /etc/passwd
     root:x:0:0:root:/root:/bin/zsh
     daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
     bin:x:2:2:bin:/bin:/usr/sbin/nologin
     sys:x:3:3:sys:/dev:/usr/sbin/nologin
     sync:x:4:65534:sync:/bin:/bin/sync
     ```

- 用户在命令行输入命令后，一般情况下Shell会fork并exec该命令，但是Shell的内建命令例外，执行内建命令相当于调用Shell进程中的一个函数，并不创建新的进程。以前学过的cd、alias、umask、exit等命令即是内建命令，凡是用which命令查不到程序文件所在位置的命令都是内建命令，内建命令没有单独的man手册，要在man手册中查看内建命令，应该执行

   ```bash
   man bash-builtins
   ```

- 如export、shift、if、eval、[、for、while等等。内建命令虽然不创建新的进程，但也会有Exit Status，通常也用0表示成功非零表示失败，虽然内建命令不创建新的进程，但执行结束后也会有一个状态码，也可以用特殊变量`$?`读出。

## 执行脚本

- 编写一个简单的脚本test.sh：

   ```bash
   #! /bin/sh
   cd ..
   ls
   ```

- Shell脚本中用`#`表示注释，相当于C语言的//注释。但如果#位于第一行开头，并且是`#!（称为Shebang）`则例外，它表示该脚本使用后面指定的解释器/bin/sh解释执行。如果把这个脚本文件加上可执行权限然后执行：

   ```bash
   chmod a+x test.sh
   ./test.sh
   ```

- Shell会fork一个子进程并调用exec执行`./test.sh`这个程序，exec系统调用应该把子进程的代码段替换成`./test.sh`程序的代码段，并从它的`_start`开始执行。然而test.sh是个文本文件，根本没有代码段和`_start`函数，怎么办呢？其实exec还有另外一种机制，如果要执行的是一个文本文件，并且第一行用Shebang指定了解释器，则用解释程序的代码段替换当前进程，并且从解释器的`_start`开始执行，而这个文本文件被当作命令行参数传给解释器。因此，执行上述脚本相当于执行程序

   ```bash
   /bin/sh ./test.sh
   ```

- 以这种方式执行不需要test.sh文件可执行权限。

- 如果将命令行下输入的命令用()括号括起来，那么也会fork出一个子Shell执行小括号中的命令，一行中可以输入由分号`;`隔开的多个 命令，比如：

   ```bash
   (cd ..; ls -l)
   ```

- 和上面两种方法执行Shell脚本的效果是相同的，`cd ..`命令改变的是子Shell的PWD，而不影响到交互式Shell。

   ```bash
   cd ..; ls -l
   ```

- 则不同的效果，`cd ..`命令是直接在交互式Shell下执行的，改变交互式Shell的PWD，然而这种方式相当于这样执行Shell脚本：

   ```bash
   source ./test.sh
   或者
   . ./test.sh
   ```

- `source`或者`.`命令是Shell的内建命令，这种方式也不会创建子Shell，而是直接在交互式Shell下逐行执行脚本中的命令。

## 基本语法

### 变量
- 按照惯例，Shell变量通常由字母加下划线开头，由任意长度的字母、数字、下划线组成。有两种类型的Shell变量：
  - 1、环境变量
      - 环境变量可以从父进程传给子进程，因些Shell进程的环境变量可以从当前Shell进程传给fork出来的子进程。用`printenv`命令可以显示当前Shell的环境变量。
  - 2、本地变量
      - 只存在于当前Shell进程，用`set`命令可以显示当前Shell进程中定义的所有变量（包括本地变量和环境变量）和函数。

- 环境变量是任何进程都有的概念，而本地变量是Shell特有的概念。在Shell中，环境变量和本地变量的定义和用法相似。在Shell中定义或赋值一个变量：

   ```bash
   VARNAME=value
   ```

- 注意等号两边都不能有空格，否则会被Shell解释成命令行参数。

- 一个变量定义后仅存在于当前Shell进程，它是本地变量，用export命令可以把本地变量导出为环境变量，定义和导出环境变量通常可以一步完成：

   ```bash
   export VARNAME=value
   ```

- 也可以分两步完成：

   ```bash
   VARNAME=value
   export VARNAME
   ```

- 用unset命令可以删除已定义的环境变量或本地变量。

   ```bash
   unset VARNAME
   ```

- 如果一个变量叫做VARNAME，用'VARNAME'可以表示它的值，在不引起歧义的情况下也可以用VARNAME表示它的值。通过以下的例子比较这两种表示法的不同：

   ```bash
   echo $SHELL
   ```

- 注意，在定义变量时不用"'"，取变量值时要用。和C语言不同的是，Shell变量不需要明确定义类型，事实上Shell变量的值都是字符串，比如我们定义VAR=45，其实VAR的值是字符串45而非整数。Shell变量不需要先定义后使用，如果一个没有定义的变量取值，则值为空字符串。

### 文件名代换（Globbing）

- 这些用于匹配的字符称为通配符（Wildcard），如：`*?[]`，具体如下：
  - `*`匹配0个或多个任意字符

  - `?`匹配一个任意字符

  - `[`若干字符]匹配方括号中任意一个字符的一次出现

     ```bash
     ls /dev/ttyS*
     ls ch0?.doc
     ls ch0[0-2].doc
     ls ch[012][0-9].doc
     ```

  - 注意，Globbing所匹配的文件名是由Shell展开的，也就是说在参数还没传给程序之前已经展开了，比如上述`ls ch0[012].doc`命令，如果当前目录下有ch00.doc和ch02.doc，则传给ls命令的参数实际上是这两个文件名，而不是一个匹配字符串。

### 命令代换

- 由“`”反引号括起来的也是一条命令，Shell先执行该命令，然后将输出结果立刻代换到当前命令行中。例如定义一个变量存放date命令的输出：

   ```bash
   DATE=`date`
   echo $DATE
   ```

- 命令代换也可以用`$()`表示：

   ```bash
   DATE=$(date)
   ```

### 算术代换

- 使用`$(())`，用于算术计算，`(())`中的Shell变量取值将转换成整数，同样含义的`$[]`等价，例如：

   ```bash
   VAR=45
   echo $(($VAR+3))  
   ```

    等价于

   ```bash
   echo $[VAR+3]
   ```

   或

   ```bash
   $[$VAR+3]
   ```

- `$(())`中只能用`+-*/`和`()`运算符，并且只能做整数运算。

- `$[base#n]`，其中base表示进制，n按照base进制解释，后面再运算数，按十进制解释。

   ```bash
   echo $[2#10+11]
   echo $[8#10+11]
   echo $[16#10+11]
   ```

### 转义字符
- 和C语言类似，`\`在Shell中被用作转义字符，用于去除紧跟其后的单个字符的特殊意义（回车除外），换句话说，紧跟其后的字符取字面值。例如：

   ```bash
   echo $SHELL
   /bin/bash
   echo \$SHELL
   $SHELL
   echo \\
   \
   ```

- 比如创建一个文件名为"$ $"的文件（$间含有空格），可以这样：

   ```bash
   touch \$\ \$
   ```

- 还有一个字符虽然不具有特殊含义，但是要用它做文件名也很麻烦，就是`-`号。如果要创建一个文件名以`-`号开头的文件，这样是不正确的：

   ```bash
   touch -hello
   touch：无效选项 -- e
   Try 'touch --help' for more information.
   ```

- 即使加上`\`转义也还是报错：

   ```bash
   touch \-hello
   touch：无效选项 -- e
   Try 'touch --help' for more information.
   ```

- 因为各种UNIX命令都把`-`号开关的命令行参数当作命令的选项，而不会当作文件名。，如果非要处理以`-`号开头的文件名，可能有两种方法：

   ```
   touch ./-hello    
   ```

   或者

   ```bash
   touch -- -hello
   ```

### 单引号
- 和C语言同，Shell脚本中的单引号和双引号一样是字符串的界定符（双引号下一节介绍），而不是字符的界定符。单引号用于保持引号内所有字符的字面值，即使引号内的\和回车也不例外，但是字符串中不能出现单引号。如果引号没有配对就输入回车，Shell会给出续行提示符，要求用户把引号配上对。例如：

   ```bash
   echo '$SHELL'
   $SHELL
   
   echo 'ABC\(回车)
   > DE'（再按一次回车结束命令）
   ABC\
   DE
   ```

### 双引号

- 被双引号用括住的内容，将被视为单一的字串。它防止通配符扩展，但允许变量扩展。这点与单引号的处理方式不同

   ```bash
   DATE=$(date)
   echo "$DATE"
   echo '$DATE'
   ```

- 再比如：

   ```bash
   VAR=200
   echo $VAR
   200
   echo '$VAR'
   $VAR
   echo "$VAR"
   200
   ```

## Shell脚本语法
### 条件测试

- 命令`test`或`[`可以测试一个条件是否成立，如果测试结果为真，则该命令的`Exit Status`为0，如果测试结果为假，则命令的`Exit Status`为1（注意与C语言的逻辑表示正好相反）。例如测试两个数的大小关系：

   ```bash
   var=2
   test $var -gt 1
   echo $?
       0
   test $var -gt 3
   echo $?
       1
   ```

- 虽然看起来很奇怪，但左方括号[确实是一个命令的名字，传给命令的各参数之间应该用空格隔开，比如：`$VAR、-gt、3、]`和`[`命令的四个参数，它们之间必须用空格隔开。命令`test`或`[`的参数形式是相同的，只不过`test`命令不需要`]`参数。以`[`命令为例，常见的测试命令如下表所示：

   ```bash
   [ -d DIR ]                 如果DIR存在并且是一个目录则为真
   [ -f FILE ]                如果FILE存在且是一个普通文件则为真
   [ -z STRING ]              如果STRING的长度为零则为真
   [ -n STRING ]              如果STRING的长度非零则为真
   [ STRING1 = STRING2 ]      如果两个字符串相同则为真
   [ STRING1 != STRING2 ]     如果两个字符串不相同则为真
   [ ARG1 OP ARG2 ]           ARG1和ARG2应该是整数或者取值为整数的变量，OP的值有：
   -eq                        等于
   -ne                        不等于
   -lt                        小于
   -le                        小于等于
   -gt                        大于
   -ge                        大于等于
   ```

- 和C语言类似，测试条件之间还可以做与、或、非逻辑运算：

   ```bash
   [ ! EXPR ]           EXPR可以是上表中的任意一种测试条件, !表示"逻辑反(非)"
   [EXPR1 -a EXPR2 ]    EXPR1和EXPR2可以是上表中的任意一种测试条件,-a表示"逻辑与"
   [EXPR1 -o EXPR2 ]    EXPR1和EXPR2可以是上表中的任意一种测试条件,-o表示"逻辑或"
   ```

- 例如：

   ```bash
   VAR=abc
   [ -d Desktop -a $VAR = 'abc' ]
   echo $?
   0
   ```

- 注意，如果上例中的`$VAR`变量事先没有定义，则被Shell展开为空字符串，会造成测试条件的语法错误（展开为`[ -d Desktop -a = 'abc']`），**作为一种好的Shell编程习惯，应该总是把变量取值放在双引号之中**（展开为`[ -d Desktop -a "" = 'abc']`）

   ```bash
   unset VAR
   [ -d Desktop -a $VAR = 'abc' ]
   -bash: [: 参数太多
   [ -d Desktop -a "$VAR" = 'abc' ]
   echo $?
   1
   ```

### 分支
- if/then/elif/else/fi
  - 和C语言类似，在Shell中用if、then、elif、else、fi这几条命令实现分支控制。这种流程控制语句本质上也是由若干条Shell命令组成的，例如先前讲过的

     ```
     if [ -f ~/.bashrc ]; then
         . ~/.bashrc
     fi
     ```

  - 其实是三条命令，`if [ -f ~/.bashrc `是第一条，`then . ~/.bashrc`是第二条，`fi`是第三条。如果两条命令写在同一行则需要用`;`号隔开，一行只写一条命令就不需要写`;`号了，另外，then后面有换行，但这条命令没写完，Shell会自动续行，把下一行接在then后面当作一条命令处理。和`[`命令一样，要注意命令和各参数之间必须用空格隔开。if命令的参数组成一条子命令，如果该子命令的Exit Status为0（表示真），则执行then后面的子命令上，如果Exit Status非0（表示假），则执行elif、else或者fi后面的子命令。if后面的子命令通常是测试命令，但也可以是其它命令。Shell脚本没有{}括号，所以用fi表示if语句的结束。见下例：

     ```bash
     #! /bin/sh
     if [ -f /bin/bash ]
     then
         echo "/bin/bash is a file"
     else
         echo "/bin/bash is NOT a file"
     fi
     if :; then echo "always true"; fi
     ```

  - ":"是一个特殊的命令，称为空命令，该命令不做任何事，但Exit Status总是真。此外，也可以执行/bin/true或/bin/false得到真或假的Exit Status。再看一个例子：

     ```bash
     #! /bin/sh
     echo "Is it morning? Please answer yes or no."
     read YES_OR_NO
     if [ "$YES_OR_NO" = "yes" ]; then
         echo "Good morning!"
     elif [ "$YES_OR_NO" = "no" ]; then
         echo "Good afternoon!"
     else
         echo "Sorry, $YES_OR_NO not recognized. Enter yes or no."
         exit 1
     fi
     exit 0
     ```

  - 上例中的read命令的作用是等等用户输入一行字符串，将该字符串存到一个Shell变量中。

  - 此外，Shell还提供了`&&`和`||`语法，和C语言类似，具有Short-circuit特性，很多Shell脚本喜欢写成这样：

     ```bash
     test "$(whoami)" != 'root' && (echo you are using a non-privileged account; exit 1)
     ```

  - `&&`相当于“if...then...”，而`||`相当于“if not...then...”。`&&`和`||`用于连接两个命令，而上面讲的-a和-o仅用于在测试表达式中连接两个测试条件，要注意它们的区别，例如：

     ```bash
     test "$VAR" -gt 1 -a "$VAR" -lt 3
     ```

  - 和以下写法是等价的

     ```bash
     test "$VAR" -gt 1 && test "$VAR" -lt 3
     ```

- case/esac
  - case命令可类比C语言的switch/case语句，esac表示case语句块的结束。C语言的case只能匹配整形或字符型常量表达式，而Shell脚本的case可以匹配字符串和Wildcard，每个匹配分支可以有若干条命令，末尾必须以`;;`结束，执行时找到第一个匹配的分支并执行相应的命令，然后直接跳到esac之后，不需要像C语言一样用break跳出。

     ```bash
     #! /bin/sh
     echo "Is it morning? Please answer yes or no."
     read YES_OR_NO
     case "$YES_OR_NO" in
     yes|y|Yes|YES)
         echo "Good Morning!";;
     [nN]*)
         echo "Good Afternoon!";;
     *)
         echo "Sorry, $YES_OR_NO not recognized. Enter yes or no."
         exit 1;;
     esac
     exit 0
     ```

  - 使用case语句的例子可以在系统服务的脚本目录`/etc/init.d`中找到。这个目录下的脚本大多具有这种形式（以`/etc/init.d/nfs-kernel-server`为例）：

     ```bash
         case "$1" in 
             start)
                 ...
             ;;
             stop)
                 ...
             ;;
             status)
                 ...
             ;;
             reload | force-reload)
                 ...
             ;;
             restart)
                 ...
             ;;
             *)
                 log_sucess_msg "Usage: nfs-kernel-serve {start|stop|status|reload|force-reload|restart}"
                 exit 1
             ;;
         esac
     ```

  - 启动nfs-kernel-server服务的命令是

     ```bash
     sudo /etc/init.d/nfs-kernel-server start
     ```

  - `$1`是一个特殊变量，在执行脚本时自动取值为第一个命令行参数，也就是start，所以进入start)分支执行相关的命令。同理，命令行参数指定为stop、reload或restart可以进入其它分支执行停止服务、重新加载配置文件或重新启动服务的相关命令。

### 循环
- for/do/done
  - Shell脚本的for循环结构和C语言很不一样，它类似于某些编程语言foreach循环。例如：

     ```bash
     #! /bin/sh
     for FRUIT in apple banana pear; do
         echo "I like $FRUIT"
     done
     ```

  - FRUIT是一个循环变量，第一次循环`$FRUIT`的取值是apple，第二次取值是banana，第三次取值是pear。再比如，要将当前目录下的chap0、chap1、chap2等文件夹名改为chap0、chap1、chap2等（按惯例，末尾有字符的文件名表示临时文件），这个命令可以这样写：

     ```bash
     for FILENAME in chap?; do mv FILENAME $FILENAME~; done
     ```

  - 也可以这样写：

     ```bash
     for FILENAME in `ls chap?`; do mv $FILENAME $FILENAME~; done
     ```

- while/do/done
  - while的用法和C语言类似。比如一个验证码的脚本：

     ```bash
     #! /bin/sh
     echo "Enter password:"
     read TRY
     while [ "$TRY" != "secret" ]; do
         echo "Sorry, try again"
         read TRY
     done
     ```

  - 下面的例子通过算术运算控制循环的次数：

     ```bash
     #! /bin/sh
     COUNTER=1
     while [ "$COUNTER" -lt 10 ]; do
         echo "Here we go again"
         COUNTER=$[$COUNTER+1]
     done
     ```

  - 另，Shell还有until循环，类似C语言的do...while。如有兴趣可在课后自行扩展学习。

- break和continue
  - break[n]可以指定跳出几层循环；continue跳过本次循环，但不会跳出循环。
  - 即break跳出，continue跳过。
  - 练习：将上面验证密码的程序修改一下，如果用户输错五次密码就报错退出。

### 位置参数和特殊变量
- 有很多特殊变量是被Shell自动赋值的，我们已经遇到了`$?`和`$1`。其他常用的位置参数和特殊变量在这里总结一下：

   ```bash
   $0           #相当于C语言main函数的argv[0]
   $1、$2...    #这些称为位置参数（Positional Parameter），相当于C语言main函数的argv[1]、argv[2]...
   $#           #相当于C语言main函数的argc - 1，注意这里的#后面不表示注释
   $@           #表示参数"$1" "$2" ...，例如可以用在for循环中的in后面 
   $*           #表示参数"$1" "$2" ...，同上
   $?           #上一条命令的Exit Status
   $$           #当前进程号
   ```

- 位置参数可以用`shift`命令左移。比如`shift 3`表示原来的`$4`现在变成`$1`，原来的`$5`现在变成`$2`等等，原来的`$1、$2、$3`丢弃，`$0`不移动。不带参数的`shift`命令相当于`shift 1`。例如：

   ```bash
   #! /bin/sh
   echo "The program $0 is now running"
   echo "The first parameter is $1"
   echo "The second parameter is $2"
   echo "The parameter list is $@"
   shift
   echo "The first parameter is $1"
   echo "The second parameter is $2"
   echo "The parameter list is $@"
   ```

### 输入输出
- echo
  - 显示文本行或变量，或者把字符串输入到文件。

     ```bash
     echo [option] string
     -e 解析转义字符
     -n 不回车换行。默认情况echo回显的内容后面跟一个回车换行。
     echo "hello\n\n"
     echo -e "hello\n\n"
     echo "hello"
     echo -n "hello"
     ```

- 管道
  - 可以通过 `|` 把一个命令的输出传递给另一个命令做输入。

     ```bash
     cat myfile | more
     ls -l | grep "myfile"
     df -k | awk '{print $1}' | grep -v "文件系统"
     df -k 查看磁盘空间，找到第一列，去除“文件系统”，并输出
     ```

- tee
  - tee命令把结果输出到标准输出，另一个副本输出到相应文件。

     ```bash
     df -k | awk '{print $1}' | grep -v "文件系统" | tee a.txt
     ```

  - `tee -a a.txt`表示追加操作。

     ```bash
     df -k | awk '{print $1}' | grep -v "文件系统" | tee -a a.txt        
     ```

- 文件重定向

   ```bash
   cmd > file                把标准输出重定向到新文件中
   cmd >> file                追加
   cmd > file2 2>&1        标准出错也重定向到1所指向的file里
   cmd >> file2 2>&1        
   cmd < file1 > file2        输入输出都定向到文件里
   cmd < &fd               把文件描述符fd作为标准输入
   cmd > &fd               把文件描述符fd作为标准输出
   cmd < &-                关闭标准输入
   ```

### 函数

- 和C语言类似，Shell中也有函数的概念，但是函数定义中没有返回值也没有参数列表。例如：

   ```bash
   #/bin/sh
   foo(){ echo "Function foo is called"; }
   
   echo "-=start=-"
   foo
   echo "-=end=-"
   ```

- 注意函数体的左花括号`{`和后面的命令之间必须有空格或换行，如果将最后一条命令和右花括号`}`写在一行，命令末尾必须有分号`;`但不建议将函数定义的写在一行上，不利于脚本阅读。
- 在定义`foo()`函数时并不执行函数体中的命令，就象定义变量一样，只是给foo这个名一个定义，到后面调用foo函数的时候（注意Shell中的函数调用不写括号）才执行函数体中的命令。Shell脚本中的函数必须先定义后调用，一般把函数定义语句写在脚本的前面，把函数调用和其它命令写在脚本的最后（类似C语言中的main函数，这才是整个脚本实际开始执行命令的地方）。
- Shell函数没有参数列表并不表示不能传参数，事实上，函数就象是迷你脚本，调用函数时可以传任意个参数，在函数内部同样是用`$0、$1、$2`等变量来提取参数，函数中的位置参数相当于函数的局部变量，改变这些变量并不会影响外面的`$0、$1、$2`等变量。函数中可以用return命令返回，如果return后面跟一个数字则表示函数的Exit Status。
- 下面这个脚本可以一次创建多个目录，各目录名通过命令行参数传入，脚本逐个测试各目录是否存在，如果目录不存在，首先打印信息然后试着创建该目录。

   ```bash
   #! /bin/sh
   is_directory(){
       DIR_ANME=1
       if [ ! -d DIR_ANME ]
           return 1
       else
           return 0
       fi
   }
   for DIR in "$@"; do
       if is_directory "$DIR"
       then : 
       else
           echo "$DIR doesn't exist, Creating it now..."
           mkdir $DIR > /dev/null 2>&1
           if [ $? -ne 0 ]; then
               echo "Cannot create directory $DIR"
               exit 1
           fi
       fi
   done
   ```

- 注意：`is_directory`返回0表示真，返回1表示假

## Shell脚本调试方法
- Shell提供了一些用于调试脚本的选项，如：

   ```bash
   -n        读一遍脚本中的命令但不执行，用于检查脚本中的语法错误。
   -v        一边执行脚本， 一边将执行过的脚本命令打印到标准错误输出。
   -x        提供跟踪执行信息，
   ```

   将执行的每一条命令和结果依次打印出来。

- 这些选项有三种常见的使用方法：

- 1、在命令行提供参数。如：

   ```bash
   sh -x ./script.sh
   ```

- 2、在脚本开关提供参数。如：

   ```bash
   #! /bin/sh -x
   ```

- 3、在脚本中用set命令启动或禁用参数。如：

   ```bash
   #! /bin/sh
   if [ -z "$1" ]; then
       set -x
       echo "ERROR: Insufficient Args."
       exit 1
       set +x
   fi
   ```

- `set -x`和`set +x`分别表示启用或禁用`-x`参数，这样可以只对脚本中的某一段进行跟踪调试。

## 正则表达式

- 以前我们用`grep`在一个文件中找出包含某些字符串的行，比如在头文件中找出一个宏定义。其实`grep`还可以找出符合某个模式（Pattern）的一类字符串。例如找出所有符合xxx@xxx.xxx模式的字符串（也就是email地址），要求x字符可以是字母、数字、下划线、小数点或减号，email地址的每一部分可以有一个或多个x字符，例如`abc.d@ef.com、1_2@987-6.54`，当然符合这个模式的不全是合法的email地址，但至少可以做一次初步筛选，筛掉a.b、c@d等肯定不是email地址的字符串。再比如，找出所有符合yyy-yyy-yyy-yyy模式的字符串（也就是IP地址），要求y是0-9的数字，IP地址的每一部分可以有1-3个y字符。

- 如果用grep查找一个模式，如何表示这个模式，这一类字符串，而不是特定的字符串呢？从这两个简单的例子可以看出，要表示一个模式至少应该包含以下信息：

- 字符类（Character Class）：如上例的x和y，它们在械中表示一个字符，但是取值范围是一类字符中的任意一个。

- 数量限定符（Quantifier）：邮件地址的每一个部分可以有一个或多个x字符，IP地址的每一部分可以有1-3个y字符。

- 各种字符类以及普通字符之间的位置关系：例如邮件地址分三部分，用普通字符`@`和`.`隔开，IP地址分四部分，用.隔开，每一部分都可以字符类和数量限定符描述。为了表示位置关系，还有位置限定符（Anchor）的概念，将在下面介绍。

- 规定一些特殊语法表示字符类、数量限定符和位置关系，然后用这些特殊语法和普通字符一起表示一个模式，这就是正则表达式（Regular Expression）。例如email地址的正则表达式可以写成`[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+.[a-zA-Z0-9_.-]+`，IP地址的正则表达式可以写成`[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}`。下一节介绍正则表达式的语法，我们先看看正则表达式在grep中怎么用。例如有这样一个文件testfile：

   ```
   192.168.1.1
   1234.234.04.5678
   123.4234.045.678
   abcde
   ```

   ```bash
   egrep '[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}' testfile
   192.168.1.1
   1234.234.04.5678
   ```

- `egrep`相当于`grep -E`，表示采用Extended正则表达式语法。`grep`的正则表达式有Basic和Extended两种规范，它们之间的区别下一节再解释。另外还有`fgrep`命令，相当于`grep -F`，表示只搜索固定字符而不搜索正则表达式模式，不会按正则表达式的语法解释后面的参数。

- 注意正则表达式参数用单引号括起来了，因为正则表达式中用到的很多特殊字符在Shell中也有特殊含义（例如），只有用单引号括起来才能保证这些字符原封不动地传给`grep`命令，而不会被Shell解释掉。

- 192.168.1.1符合上述模式，由三个.隔开的四段组成，每段都是1到3个数字，所以这一行被找出来了，可为什么1234.234.04.5678也被找出来了呢？因为`grep`找的是包含某一模式的行，这一行包含一个符合模式的字符串234.234.04.567。相反，123.4234.045.678这一行不包含符合模式的字符串，所以不会被找出来。

- `grep`是一种查找过滤工具，正则表达式在`grep`中用来查找符合模式的字符串。其实正则表达还有一个重要的应用是验证用户输入是否合法，例如用户通过网页表单提交自己的email地址，就需要用程序验证一下是不是合法的email地址，这个工作可以在网页的javascript中做，也可以在网站后台程序中做，例如PHP、Perl、Python、Ruby、Java或C，所有这些语言都支持正则表达式，可以说，目前不支持正则表达式的编程语言实在少见。除了编程语言之外，很多UNIX命令和工具也都支持正则表达式，例如`grep、vi、sed、awk、emacs`等等。“正则表达式”就像“变量”一样，它是一个广泛的概念，而不是某一种工具或编程语言的特性。

### 基本语法

- 我们知道C的变量和Shell脚本变量的定义和使用方法很不相同，表达能力也不相同，C的变量有各种类型，而Shell脚本变量都是字符串。同样道理，各种工具和编程语言所使用的正则表达式规范的语法并不相同，表达能力也各不相同，有的正则表达式规范引入很多扩展，能表达更复杂的模式，但各种正则表达式规范的基本概念都是想通的。本节介绍egrep（1）所使用的正则表达式，它大致上符合POSIX正则表达式规范，详见regex(7)(看这个man page对你的英文绝对是很好的锻炼）。希望读者仿照上一节的例子，一边学习语法，一边用egrep命令做实验。
- 字符类
  - `. `匹配任意一个字符，`abc.`可以匹配abcd、abc9等。
  - `[]`匹配括号中的任意一个字符，`[abc]d`可以匹配ad、bd或cd。
  - `-`在[]括号内表示字符范围，`[0-9a-fA-F]`可以匹配一位十六进制数字。
  - `^`位于[]括号内的开头，匹配括号中的字符之外的任意一个字符，`[^xy]`匹配xy之外的任一字符，因此`[^xy]1`可以匹配a1、b1但不匹配x1、y1。
  - `[[:xxx:]]`grep工具预定义的一些命名字符类，`[[:alpha:]]`匹配一个字母，`[[:digit:]]`匹配一个数字。
- 数量限定符
  - `?`紧跟在它前面的单元匹配零次或一次，`[0-9]?\.[0-9]`匹配0.0、2.3、.5等，由于.在正则表达式中是一个特殊字符，所以需要用\转义一下，取字面值。

  - `+`紧跟在它前面的单元应匹配一次或多次，`[a-zA-Z0-9_.-]+@[a-zA-Z0-9_.-]+\.[a-zA-Z0-9_.-]+`匹配email地址。

  - `*`紧跟在它前面的单元应匹配零次或多次，`[0-9][0-9]*`匹配至少一个数字，等价于`[0-9]+`，`[a-zA-Z_]+[a-zA-Z_0-9]*`匹配C语言的标识符。

  - `{N}`紧跟在它前面的单元应精确匹配N次，`[1-9][0-9]{2}`匹配从100到999的整数。

  - `{N,}`紧跟在它前面的单元应匹配至少N次，`[1-9][0-9]{2,}`匹配三位以上（含三位）的整数。

  - `{,M}`紧跟在它前面的单元应匹配最多M次，`[0-9]{,1}`相当于`[0-9]?`。

  - `{N,M}`紧跟在它前面的单元应匹配至少次，最多M次，`[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}`匹配IP地址。

  - 再次注意：**grep找的是包含某一模式的行，而不是完全匹配某一模式的行**。

  - 例如有如下文本：

     ```
     aaabc
     aad
     efg
     ```

  - 查找a*这个模式的结果，会发现，三行都被找了出来。

     ```bash
     $ egrep 'a*' testfile
     aaabc
     aad
     efg
     ```

  - a匹配0个或多个a，而第三行包含0个a,所以也包含了这一模式。单独用a这样的正则表达式做查找没什么意义，一般是把`a*`作为正则表达式的一部分来用。
- 位置限定符
  - `^`匹配行首的位置，`^Content`匹配位于一行开头的Content。

  - `$`匹配行末的位置，`;$`匹配位于一行结尾的;号，`^$`匹配空行。

  - `\<`匹配单词开关的位置，`\<th`匹配... this，但不匹配ethernet、tenth。

  - `\>`匹配单词结尾的位置，`p\>`匹配leap ...，但不匹配parent、sleepy。

  - `\b`匹配单词开关或结尾的位置，`\bat\b`匹配... at ...，但不匹配cat、atexit、batch。

  - `\B`匹配非单词开头和结尾的位置，`\Bat\B`匹配battery，但不匹配... attend、hat ...

  - 位置限定符可以帮助grep更准确地查找。

  - 例如上一节我们用`[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}`查找IP地址，找到这两行

     ```
     192.168.1.1
     1234.234.04.5678
     ```

  - 如果用`^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$`查找，就可以1234.234.04.5678这一行过滤掉了。
- 其它特殊字符
  - `\`转义字符，普通字符转义为特殊字符，特殊字符转义为普通字符。普通字符<写成\<表示单词开头的位置，特殊字符.写成\.以及\写成\\就当作普通字符来匹配。
  - `()`将正则表达式的一部分括起来组成一个单元，可以对整个单元使用数量限定符。`([0-9]{1,3}\.){3}[0-9]{1,3}`匹配IP地址
  - `|`连接两个子表达式，表示或的关系。`n(o|either)`匹配no或neither

### Basic正则和Extended正则区别
- 以上介绍的是`grep`正则表达式的Extended规范，Basic规范也有这些语法，只是字符`?+{}|()`应解释为普通字符，要表示上述特殊含义则需要加\转义。如果用`grep`而不是`egrep`，并且不加-E参数，则应遵照Basic规范来写正则表达式。

### grep
- 1、作用
  - Linux系统中`grep`命令是一种强大的文本搜索工具，它能使用正则表达式搜索文件，并把匹配的行打印出来。grep全称是`Global Regular Expression Print`，表示全局正则表达式版本，它的使用权限是所有用户。
  - grep家族包括`grep`、`egrep`和`fgrep`。egrep和fgrep的命令只跟grep有很小不同。egrep是grep的扩展，支持更多的re元字符，fgrep就是fixed grep和fast grep，它们把所有的字母都看作单词，也就是说，正则表达式中的元字符表示回其自身的字面意义，不再特殊。linux使用GNU版本的grep。它功能更强，可以通过-G、-E、-F命令选项来使用egrep和fgerp的功能。

- 2、格式及主要参数
  - `grep [option]`
  - 主要参数：`grep -help`可查看
      - `-c`：只输出匹配行的计数。
      - `-i`：不区分大小写。
      - `-h`：查询多文件时不显示文件名。
      - `-l`：查询多文件时只输出包含匹配字符的文件名。
      - `-n`：显示匹配行及行号。
      - `-s`：不显示不存在或无匹配文本的错误信息。
      - `-v`：显示不包含匹配文本的所有行。
      - `--color=auto`：可以将找到的关键词部分加上颜色的显示。
  - pattern正则表达式主要参数：
      - `\`：忽略正则表达式中特殊字符的原有含义。
      - `^`：匹配正则表达式的开始行
      - `$`：匹配正则表达式的结束行
      - `<`：从匹配正则表达式的行开始
      - `>`：到匹配正则表达式的行结束
      - `[]`：单个字符，如[A]即A符合要求
      - `[ - ]`：范围，如[A-Z]，即A、B、C一直到Z都符合要求。
      - `.`：所有的单个字符。
      - `*`：所有字符，长度可以为0。

- 3、grep命令使用简单实例

   ```bash
   grep 'test' d*            显示所有以d开头的文件中包含test的行。
   ```

### find
- 由于find具有强大的功能，所以它的选项也很多，其中大部分选项都值得我们花时间来了解一下。即使系统中含有网络文件系统（NFS），find命令在该文件系统中同样有效，只要你具有相应的权限。
- 在运行一个非常消耗资源的find命令时，很多人都倾向于把它放在后台执行，因为遍历一个大的文件系统可能会花费很长的时间（这里是指30G字节以上的文件系统）。
- 一、find命令格式
  - 1、find命令的一般形式为

    ```bash
    find pathname -options [-print -exec -ok ...]
    ```

  - 2、find命令的参数
    - `pathname`：find命令所查找的目录路径。例如用.来表示当前目录，用/来表示系统根目录，递归查找。
    - `-print`：find命令将匹配的文件输出到标准输出。
    - `-exec`：find命令对匹配的文件执行该参数所给出的shell命令。相应命令的形式为'command' {} \；，注意{}内部无空格，和\;之间含有一个空格分隔符。
    - `-ok`：和-exec的作用相同，只不过以一种更为安全的模式来执行该参数所给出的shell命令，在执行每一个命令之前，都会给出提示，让用户来确定是否执行。

  - 3、find命令选项
    - `-name`：按照文件名查找文件。
    - `-perm`：按照文件权限来查找文件。
    - `-prune`：使用这一选项可以使find命令不在当前指定的目录中查找，如果同时使用-depth选项，那么-prune将被find命令忽略。
    - `-user`：按照文件属主来查找文件。
    - `-group`：按照文件所属的组来查找文件。
    - `-mtime -n +n`：按照文件的更改时间来查找文件，-n表示文件更改时间距现在n天以内，+n表示文件更改时间间距现在n天以前。find命令还有-atime和-ctime选项，但它们都有-mtime选项。 
    - `-nogroup`：查找无有效属组的文件，即该文件所属的组在/etc/groups中不存在。
    - `-nouser`：查找无有效属主的文件，即该文件的属主在/etc/passwd中不存在。
    - `newer file1 ! file2`：查找更改时间比文件file1新但比文件file2旧的文件。
    - `-type`：查找某一类型的文件，诸如：
        - `b`：块设备文件
        - `d`：目录
        - `c`：字符设备文件
        - `p`：管道文件
        - `l`：符号链接文件
        - `f`：普通文件
    - `-size n`：[c]查找文件长度为n块的文件，带有c时表示文件长度以字节计。
    - `-depth`：在查找文件时，首先查找当前目录中的文件，然后再在其子目录中查找。
    - `fstype`：查找位于某一类型文件系统中的文件，这些文件系统类型通常可以在配置文件/etc/fstab中找到，该配置文件中包含了本系统中有关文件系统的信息。
    - `mount `在查找文件时不跨越文件系统mount点。
    - `follow `如果find命令遇到符号链接文件，就跟踪至链接所指向的文件。

  - 另外，下面三个的区别：
    - `-amin n` 查找系统中最后n分钟访问的文件
    - `-atime n` 查找系统中最后n*24小时访问的文件
    - `-cmin n `查找系统中最后n分钟被改变文件状态的文件
    - `-ctime n `查找系统中最后n*24小时被改变文件状态的文件
    - `-mmin n` 查找系统中最后n分钟被改变文件数据的文件
    - `-mtime n `查找系统中最后n*24小时被改变文件数据的文件

  - 4、使用`exec`或`ok`来执行shell命令

    - 使用`find`时，只要把想要的操作写在一个文件里，就可以用`exec`来配合find查找，很方便的。

    - 在有些操作系统中只允许`-exec`选项诸如ls或ls -l这样的命令。大多数用户使用这一选项是为了查找旧文件并删除它们。建议在真正执行rm命令删除文件之前，最好先用ls命令看一下，确认它们是所有删除文件。

    - exec选项后面跟随着所要执行的命令或脚本，然后是一对儿{}，一个空格和一个\，最后是一个分号。为了使用exec选项，必须要同时使用print选项。如果验证一下find命令，会发现该命令只输出从当前路径起的相对路径及文件名。

    - 例如：为了用ls -l命令列出所匹配的文件，可以把ls -l命令放在find命令的-exec选项中

       ```bash
       find . -type f -exec ls -l {} \;
       ```

    - 上面的例子中，find命令匹配到了当前目录下的所有普通文件，并在-exec选项中使用ls -l命令将它们列出。

    - 在/logs目录中查找更改时间在5日以前的文件并删除它们：

       ```bash
       find logs -type f -mtime +5 -exec rm {} \;
       ```

    - 记住：在shell中用任何方式删除文件之前，应当先查看相应的文件，一定要小心！当使用诸如mv或rm命令时，可以使用-exec选项的安全模式。它将在对每个匹配到的文件操作之前提示你。

    - 在下面的例子中，find命令在当前目录中查找所有文件名以.LOG结尾、更改时间在5日以上的文件，并删除它们，只不过在删除之前先给出提示。

       ```bash
       find . -name "*.conf" -mtime +5 -ok rm {} \;
       < rm ... ./conf/httpd.conf > ? n
       ```

    - 按y键删除文件，按n键不删除。

    - 任何形式的命令都可以在-exec选项中使用。

    - 在下面的例子中我们使用grep命令。find命令首先匹配所有文件名为"passwd*"的文件，例如passwd、passwd.old、passed.bak，然后执行grep命令看看在这些文件中是否存在一个itcast用户。

       ```bash
       find /etc -name "passwd*" -exec grep "root" {} \;    
       root:x:0:0:root:/root:/bin/zsh
       ```

- 二、find使用例子

   ```bash
   find ./ -name *.mp3
   
   find ./ -type f/d/p/c/b/s/l
   
   find ./ -size +3M -size -7M             默认单位：512B  0.5k  一个扇区大小 
   
   find ./ -size +47k -size -89k
   
   find ./ -maxdepth 2 -type d
   
   find ./ -maxdepth 1 -name "*.sh" -exec rm -r {} \;
   
   find ./ -maxdepth 1 -name "*.sh" -ok rm -r {} \;
   
   find ./ -maxdepth 1 -type f -print0 | xargs -0 ls -lh
   
   find ./ -name "*.gz" -mtime -5 -exec ls -lh {} /;
   ```

### sed

- sed意为流编辑器（Stream Editor），在Shell脚本和Makefile中作为过滤器使用非常普通，也就是把前面一个程序的输出引入sed的输入，经过一系列编辑命令转换为另一种格式输出。sed和vi都源于早期UNIX的ed工具，所以很多sed命令和vi的末行命令是相同的。

- sed命令行的基本格式为：

   ```bash
   sed option 'script' file1 file2 ...
   sed option -f scriptfile file1 file2 ...
   ```

- 选项含义：

     ```bash
       -n, --quiet, --silent
                          静默输出，默认情况下，sed程序在所有脚本指令执行完毕后，
                          将自动打印模式空间中的内容，这些选项可以屏蔽自动打印。
                          
       -e 脚本, --expression=脚本
                      允许多个脚本指令被执行。
     
       -f 脚本文件, --file=脚本文件
                      从文件中读取脚本指令，对编写自动脚本程序来说很棒！
     
       --follow-symlinks
                      直接修改文件时跟随软链接
     
       -i[SUFFIX], --in-place[=SUFFIX]
                      直接修改源文件，经过脚本指令处理后的内容将被输出至源文件
                     （源文件被修改）慎用！
     
       -l N, --line-length=N
                      该选项指定l指令可能输出的行长度，l指令用于输出非打印字符。
     
       --posix
                      禁用GNU sed扩展功能。
     
       -r, --regexp-extended
                      在脚本指令中使用扩展正则表达式
     
       -s, --separate
                      默认情况下，sed将把命令行指定的多个文件名作为一个长的连续的输入流。
                      而GNU sed则允许把他们当作单独的文件，这样如正则表达式则不进行跨文件匹配。
     
       -u, --unbuffered
                      从输入文件读取最少的数据，更频繁的刷新输出
     
       -z, --null-data
                      separate lines by NUL characters
           --help     显示帮助文档
           --version  显示sed版本。
         
       - 如果没有 -e, --expression, -f 或 --file 选项，那么第一个非选项参数被视为
         sed脚本。其他非选项参数被视为输入文件，如果没有输入文件，那么程序将从标准
         输入读取数据。
     ```

- 以上仅是sed程序本身的选项功能说明，至于具体的脚本指令（即对文件内容做的操作）后面我们会详细描述，这里简单介绍几个脚本指令操作作为sed程序的例子。

   ```
   a,    append            追加
   i,    insert            插入
   d,    delete            删除
   s,    substitution    替换
   ```

- 如：`$ sed "2a test" ./testfile`在输出testfile内容的第二行后添加"test"。

   ```bash
   sed "2,5d" testfile
   ```

- sed处理的文件既可以由标准输入重定向得到，也可以当命令行参数传入，命令行参数可以一次传入多个文件，sed会依次处理。sed的编辑命令可以直接当命令行参数传入，也可以写成一个脚本文件然后用-f参数指定，编辑命令的格式为：

   ```bash
   /pattern/action
   ```

- 其中pattern是正则表达式，action是编辑操作。sed程序一行一行读出待处理文件，如果某一行与pattern匹配，则执行相应的action，如果一条命令没有pattern而只有action，这个action将作用于待处理文件的每一行。

- 常用sed命令

   ```bash
   /pattern/p    打印匹配pattern的行
   /pattern/d    删除匹配pattern的行
   /pattern/s//pattern1/pattern2/    查找符合pattern的行，将该行第一个匹配pattern1的字符串替换为pattern2    
   /pattern/s//pattern1/pattern2/g     查找符合pattern的行，将该行所有匹配pattern1的字符串替换为pattern2
   ```

   - 使用p命令需要注意，sed是把待处理文件的内容连同处理结果一起输出到标准输出的，因此p命令表示除了把文件内容打印之外还额外打印一遍匹配pattern的行。比如一个文件testfile的内容是

      ```
      123
      abc
      456
      ```

   - 打印其中包含abc的行

      ```bash
      sed '/abc/p' testfile
          123
          abc
          abc
          456
      ```

   - 要想只输出处理结果，应加上-n选项，这种用法相当于grep命令

      ```bash
      sed -n '/abc/p' testfile
          abc
      ```

   - 使用d命令就不需要-n参数了，比如删除含有abc的行

      ```bash
      sed 'abc/d' testfile
          123
          456
      ```

   - 注意，sed命令不会修改原文件，删除命令只表示某些行不打印输出，而不是从原文件中删去。

   - 使用查找替换命令时，可以把匹配pattern1的字符串复制到pattern2中，比如：

      ```bash
      sed 's/bc/-&-/' testfile
          123
          a-bc-
          456
      ```

   - 再比如：

      ```bash
      sed 's/\([0-9]\)\([0-9]\)/-\1-~\2~/' testfile
          -1-~2~3
          abc
          -4-~5~6
      ```

   - pattern2中的`\1`表示与pattern1的第一个()括号相匹配的内容，`\2`表示与pattern1的第二个()括号相匹配的内容。sed默认使用Basic正则表达式规范，如果指定了`-r`选项则使用Extended规范，那么()括号就不必转义了。如：

      ```bash
      sed -r 's/([0-9])([0-9])/-\1-~\2~/' testfile
      ```

   - 替换结束后，所有行，含有连续数字的第一个数字前后都添加了"-"号；第二个数字前后都添加了“~”号。

   - 可以一次指定多条不同的替换命令，用“;”隔开：

      ```bash
      sed 's/yes/no/; s/static/dhcp/' testfile
      ```

      > 注：使用分号隔开指令。

   - 也可以使用-e参数来指定不同的替换命令，有几个替换命令需添加几个-e参数：

      ```bash
      sed -e 's/yes/no/' -e 's/static/dhcp/' testfile
      ```

      > 注：使用-e选项

   - 如果testfile的内容是

      ```html
      <html>undefined<head><title>Hello World</title></head>
      <body>Welcome to the world of regexp!</body></html>
      ```

   - 现在要去掉所有的HTML标签，使输出结果为：

      ```
      Hello World
      Welcome to the world of regexp!
      ```

   - 怎么做呢？如果用下面的命令

      ```bash
      sed 's/<.*>//g' testfile
      ```

   - 结果是两个空行，把所有字符都过滤掉了。这是因为，正则表达式中的数量限定符会匹配尽可能长的字符串，这称为贪心的（Greedy）。比如sed在处理第一行时，`<.*>`匹配的并不是`<html>`或`<head>`这样的标签，而是

      ```html
      <html>undefined<head><title>Hello World</title></head>
      ```

   - 这样一整行，因为这一行开头是`<`，中间是若干个任意字符，末尾是`>`。那么这条命令怎么改才对呢？留给同学们思考。

### awk
- `sed`以行为单位处理文件，`awk`比`sed`强的地方在于不仅能以行为单位还能以列为单位处理文件。**awk缺省的行分隔符是换行，缺省的列分隔符是连续的空格和Tab**，但是行分隔和列分隔符都可以自定义，比如`/etc/passwd`文件的每一行有若干个字段，字段之间以`：`分隔，就可以重新定义`awk`的列分隔符为`：`并以列为单位处理这个文件。`awk`实际上是一门很复杂的脚本语言，还有像C语言一样的分支和循环结构，但是基本用法和sed类似，`awk`命令行的基本形式为：

   ```bash
   awk option 'script' file1 file2 ...
   awk option -f scriptfile file1 file2 ...
   ```

- 和`sed`一样，`awk`处理的文件既可以由标准输入重定向得到，也可以当命令行参数传入，编辑命令可以直接当命令行参数传入，也可以用`-f`参数指定一个脚本文件，编辑命令的格式为：

   ```
   /pattern/{actions}
   condition{actions}
   ```

- 和`sed`类似，**pattern是正则表达式，actions是一系列操作**。awk程序一行一行读出待处理文件，如果某一行与pattern匹配，或者满足condition条件，则执行相应的actions，如果一条awk命令只有actions部分，则actions作用于待处理文件的每一行。比如文件testfile的内容表示某商店的库存量：

   ```
   ProductionA 30
   ProductionB 76        
   ProductionC 55
   ```

- 打印每一行的第二列：

   ```bash
   awk '{print $2;}' testfile
       30
       76
       55
   ```

- 自动变量`$1、$2`分别表示第一列、第二列等，类似于Shell脚本的位置参数，而`$0`表示整个当前行。再比如，如果某种产品的库存量低于75则在末行标注需要订货：

   ```bash
   awk '$2<75 {printf "%s\t%s\n", $0, "REORDER";} $2>=75 {print $0;}' testfile
       ProductionA 30 REORDER
       ProductionB 76        
       ProductionC 55 REORDER
   ```

- 可见`awk`也有和C语言非常相似的printf函数。`awk`命令的condition部分还可以是两个特殊的condition——`BEGIN`和`END`，对于每个待处理文件，`BEGIN`后面的actions在处理整个文件之前执行一次，`END`后面的actions在整个文件处理完之后执行一次。

- awk命令可以像C语言一样使用变量（但不需要定义变量），比如统计一个文件中的空行数

   ```bash
   awk '/^ *$/ {x=x+1;} END {print x;}' testfile
   ```

- 就像Shell的环境变量一样，有些awk变量是预定义的有特殊含义的：
  - `awk`常用的内建变量

     ```
     FILENAME    当前输入文件的文件名，该变量是只读的
     NR            当前行的行号，该变量是只读的，R代表record
     NF            当前行所拥有的列数，该变量是只读的，F代表field
     OFS            输出格式的列分隔符，缺省是空格
     FS            输入文件的列分隔符，缺省是连续的空格和Tab
     ORS            输出格式的行分隔符，缺省是换行符
     RS            输入文件的行分隔符，缺省是换行符
     ```

- 例如打印系统中的用户帐号列表

   ```bash
   awk 'BEGIN {FS=":"} {print $1;}' /etc/passwd
   ```

- `awk`也可以像C语言一样使用if/else、while、for控制结构。可自行扩展学习。

### C程序中使用正则
- POSIX规定了正则表达式的C语言库函数，详见regex(3)。我们已经学习了很多C语言库函数的用法，读者应该具备自己看懂man手册的能力了。本章介绍了正则表达式在grep、sed、awk中的用法，学习要能够举一反三，请读者根据regex(3)自己总结正则表达式在C语言中的用法，写一些签单的程序，例如验证用户输入的IP地址或email地址格式是否正确。
- C语言处理正则表达式常用的函数有`regcomp()、regexec()、regfree()、regerror()`，一般分为三个步骤，如下所示：
  - 1、编译正则表达式`regcomp()`
  - 2、匹配正则表达式`regexec()`
  - 3、释放正则表达式`regfree()`
- 下边是对三个函数的详细解释
  - 1、regcomp()这个函数把指定的正则表达式pattern编译成一种特定的数据格式compiled，这样可以使匹配更有效。函数regexec会使用这个数据在目标文本串中进行模式匹配。执行成功返回0。
    - `int regcomp(regex_t *compiled, const char *pattern, int cflags)`
    - `regex_t`：是一个结构休数据类型，用来存放编译后的正则表达式，它的成员re_nsub用来存储正则表达式中的子正则表达式的个数，子正则表达式就是用圆括号包起来的部分表达式。
    - `pattern`：是指向我们写好的正则表达式的指针。
    - `cflags`有如下4个值或者是它们或运算(|)后的值：
        - `REG_EXTENDED`：以功能更加强大的扩展正则表达式的方式进行匹配。
        - `REG_ICASE`：匹配字母时忽略大小写
        - `REG_NOSUB`：不用存储匹配后的结果，只返回是否成功匹配。如果设置该标志位，那么在regexec将忽略nmatch和pmatch两个参数。
        - `REG_NEWLINE`：识别换行符，这样'$'就可以从行尾开始匹配，'^'就可以从行的开关开始匹配。

  - 2、当我们编译好正则表达式后，就可以用regexec匹配我们的目标文本串了，如果在编译正则表达式的时候没有指定cflags的参数为REG_NEWLINE，则默认情况下是忽略换行符的，也就是把整个文本串当作一个字符串处理。
    - 执行成功返回0。

    - `regmatch_t`是一个结构体数据类型，在regex.h中定义：

       ```c
       typedef struct {
           regoff_t rm_so;
           regoff_t rm_eo;
       } regmatch_t;
       ```

    - 成员rm_so存放匹配文本串在目标串中的开始位置，rm_eo存放结束位置。通常我们以数组的形式定义一组这样的结构。因为往往我们的正则表达式中还包含子正则表达式。数组0单元存放主正则表达式位置，后边的单元依次存放正则表达式位置。

    - `int regexec(regex_t *compiled, char *string, size_t nmatch, regmatch_t matchptr[], int eflags)`
      - `compiled`：是已经用regcomp函数编译好的正则表达式。
      - `string`：是目标文本串。
      - `nmatch`：是regmatch_t结构体数组的长度。
      - `matchptr`：regmatch_t类型的结构体数组，存放匹配文本串的位置信息。
      - `eflags`有两个值：
          - `REG_NOTBOL`：让特殊字符^无作用。
          - `REG_NOTEOL`：让特殊字符$无作用。

  - 3、当我们使用完编译好的正则表达式后，或者要重新编译其他正则表达式的时候，我们可以用这个函数清空compiled指向的regex_t结构体的内容，请记住，如果是重新编译的话，一定要先清空regex_t结构体。

    - `void regfree(regex_t *compiled)`

  - 4、当执行regcomp或者regexec产生错误的时候，就可以调用这个函数而返回一个包含错误信息的字符串。
    - `size_t regerror(int errcode, regex_t *compiled, char *buffer, size_t length)`
        - `errcode`：是由regcomp和regexec函数返回的错误代号。
        - `compiled`：是已经用regcomp函数编译好的正则表达式，这个值可以为NULL。
        - `buffer`：指向用来存放错误信息的字符串的内存空间。
        - `length`：指明buffer的长度，如果这个错误信息的长度大于这个值，则regerror函数会自动截断超出的字符串，但他仍然会返回完整的字符串的长度。所以我们可以用如下的方法先得到错误字符串的长度。
        - 例如：`size_t length = regerror(errcode, compiled, NULL, 0);`

  - 测试用例：

     ```c
     #include <sys/types.h>
     #include <regex.h>
     #include <stdio.h>
         
     int main(int argc, char *argv[])
     {
         if(argc != 3){ 
             printf("Usage: %s RegexString And Text\n", argv[0]);
         }   
     
         const char * p_regex_str = argv[1];
         const char * p_txt = argv[2];
         //编译后的结构体
         regex_t oregex;
         int ret = 0;
         //保存错误信息的数组
         char emsg[1024] = {0};
         size_t emsg_len = 0;
     
         //编译正则表达式， 扩展正则
         if((ret = regcomp(&oregex, p_regex_str, REG_EXTENDED|REG_NOSUB)) == 0){ 
             //执行匹配，不保存匹配的返回值
             if((ret = regexec(&oregex, p_txt, 0, NULL, 0)) == 0){ 
                 printf("%s matches %s\n", p_txt, p_regex_str);
                 regfree(&oregex);
                 return 0;
             }   
         }   
     
         //正则编译错误，存emsg中错误描述
         emsg_len = regerror(ret, &oregex, emsg, sizeof(emsg));
         //错误信息较长特殊情况
         emsg_len = emsg_len < sizeof(emsg)? emsg_len : sizeof(emsg) - 1;
     
         emsg[emsg_len] = '\0';
         printf("Regex error Msg: %s\n", emsg);
     
         regfree(&oregex);
     
         //非正常退出                                                                                             
         return 1;
     }
     ```

  - 匹配网址：

     ```bash
     ./a.out "http:\/\/www\..*\.com" "http://www.taobao.com"
     ```

  - 匹配邮箱：

     ```bash
     ./a.out "^[a-zA-Z0-9.]+@[a-zA-Z0-9]+.[a-zA-Z0-9]+" "abc.123@126.com"
     ./a.out "\w+([-+.]\w+)*@\w+([-+.]\w+)*\.\w+([-+.]\w+)*" "abc@qq.com"
     ```

  - 匹配固话号码：请同学们自己编写。

  - 除了GNU提供的函数外，还常用PCRE处理正则，全称是Rerl Compatible Regular Expressions。从名字我们可以看出PCRE库是与Perl中正则表达式相兼容的一个正则表达式库。PCRE是免费开源的库，它是由C语言实现的，这里是它的官方主页：http://www.pcre.org/，感兴趣的朋友可以在这里了解更多的内容。要得到PCRE库，可以从这里下载：http://sourceforge.net/projects/pcre/files/

  - PCRE++是一个对PCRE库的C++封装，它提供了更加方便、易用的C++接口。这里是它的官方主页：http://freecode.com/projects/pcrepp
