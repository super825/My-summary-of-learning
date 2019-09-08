[TOC]

## 进程相关的概念

### 程序与进程

- 程序，是指编译好的二进制文件，在磁盘上，不占用系统资源（CPU、内存、打开的文件、设备、锁等等）。

- 进程，是一个抽象的概念，与操作系统原理联系紧密。进程是活跃的程序，占用系统资源。在内存中执行（程序运行起来，产生一个进程）。

- 程序 --> 剧本（纸），进程 -->戏（舞台、演员、灯光、道具等等）。同一个剧本可以在多个舞台同时上演。同样，同个程序也可以加载为不同的进程（彼此之间互不影响）。如：同时开两个终端。各自都有一个bash，但彼此ID不同。

### 并发

- 并发，在操作系统中，一个时间段中有多个进程都处于已启动运行到运行完毕之间的状态。但任一个时刻点上仍只有一个进程在运行。

- 例如，当下，我们使用计算机时可以边听音乐边聊天上网。若笼统的将他们均看做一个进程的话，为什么可以同时运行呢？因为并发。

- 分时复用CPU

![分时复用CPU](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e5%88%86%e6%97%b6%e5%a4%8d%e7%94%a8CPU.png)

### 单道程序设计

- 所有进程一个一个排队执行。若A阻塞，B只能等待，即使CPU处于空闲状态。而在人机交互时阻塞的出现是必然的。所有这种模型在系统资源利用上及其不合理，在计算机发展史上存在不久，大部分已被淘汰了。

### 多道程序设计

- 在计算机内存中同时存放几道相互独立的程序，它们在管理程序控制之下，相互穿插的运行。多道程序设计必须有硬件基础作为保证。

- **时钟中断**即为多道程序设计模型的理论基础。并发时，任意进程在执行期间都不希望放弃CPU。因此系统需要一种强制让进程让出CPU资源的手段。时钟中断有硬件基础作为保障，对进程而言不可抗拒。操作系统中的中断处理函数，来负责调度程序执行。

- 在多道程序设计模型中，多个进程轮流使用CPU（分时复用CPU资源）。而当下常见CPU为纳米级，1秒可以执行大约10亿条指令。由于人眼的反应速度是毫秒级，所以看似同时在运行。

   ```
   1s = 1000ms
   1ms = 1000us
   1us = 1000ms
   ```

- 实质上，并发是宏观并行，微观串行！ -- 推动了计算机蓬勃发展，将人类引入了多媒体时代。

### CPU与MMU
![CPU和MMU](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_CPU%e5%92%8cMMU.png)

- 内存管理单元MMU

![内存管理单元MMU](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e5%86%85%e5%ad%98%e7%ae%a1%e7%90%86%e5%8d%95%e5%85%83MMU.png)

### 进程控制块PCB

- 我们知道，每个进程在内核中都有一个进程控制块（PCB）来维护进程相关的信息，Linux内核的进程控制块是task_struct结构体。

- `/usr/src/linux-headers-3.16.0-30/include/linux/sched.h`文件中可以查看struct task_struct结构体定义。其内部成员有很多，我们重点掌握以下部分即可：
   - 进程ID。系统中每个进程唯一的ID，在C语言中用pid_t类型表示，其实就是一个非负整数。
   - 进程的状态，有就绪、运行、挂起、停止等状态。
   - 进程切换时需要保存和恢复的一些CPU寄存器。
   - 描述虚拟地址空间的信息。
   - 描述控制终端的信息。
   - 当前工作目录（Current Working Directory）
   - umask掩码。
   - 文件描述符，包含很多指向file结构体的指针。
   - 和信号相关的信息。
   - 用户id和组id。
   - 会话（Session）和进程组。
   - 进程可以使用的资源上限（Resource Limit）。

### 进程状态

- 进程基本的状态有5种。分别为初始态，就绪态，运行态，挂起态与终止态。其中初始态为进程准备阶段，常与就绪态结合来看。

![进程状态](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e8%bf%9b%e7%a8%8b%e7%8a%b6%e6%80%81.png)

## 环境变量

- 环境变量，是指在操作系统中用来指定操作系统运行环境的一些参数。通常具备以下特征：
  - 1、字符串（本质）。
  - 2、有统一的格式：名=值[:值]。
  - 3、值用来描述进程环境信息。
  - 存储形式：与命令行参数类似。`char*[]`数组，数组名`environ`，内部存储字符串，`NULL`作为哨兵结尾。
  - 使用形式：与命令行参数类似。
  - 加载位置：与命令行参数类似。位于用户区，高于stack的起始位置。
  - 引入环境变量表：须声明环境变量。`extern char **environ;`
  - 练习：打印当前进程的所有环境变量。

     ```c
     #include <stdio.h>
     
     extern char **environ;
     
     int main(int argc, char *argv[])
     {
         int i;
         for(i = 0; environ[i]; i++)
         {
             printf("%s\n", environ[i]);
         }
         return 0;
     }
     ```

### 常见环境变量

- 按照惯例，环境变量字符串都是name=value这样的形式，大多数name由大写字母加下划线组成，一般把name的部分叫做环境变量，value的部分则是环境变量的值。环境变量定义了进程的运行环境，一些比较重要的环境变量的含义如下：
  - PATH
    - 可执行文件的搜索路径。ls命令也是一个程序，执行它不需要提供完整的路径名/bin/ls，然而通常我们执行当前目录下的程序a.out却需要提供完整的路径名./a.out，这是因为PATH环境变量的值里面包含了ls命令所在的目录/bin，却不包含a.out所在的目录。PATH环境变量的值可以包含多个目录，用：号隔开。在shell中用echo命令可以查看这个环境变量的值：

       ```bash
       echo $PATH
       ```

  - SHELL

    - 当前shell，它的值通常是`/bin/bash`。

  - TERM

    - 当前终端类型，在图形界面终端下它的值通常是`xterm`，终端类型决定了一些程序的输出显示方式，比如图形界面终端可以显示汉字，而字符终端一般不行。

  - LANG

    - 语言和`locale`, 决定了字符编码以及时间、货币等信息的显示格式。

  - HOME

    - 当前用户主目录的路径，很多程序需要在主目录下保存配置文件，使得每个用户在运行该程序时都有自己的一套配置。

### getenv函数

- 获取环境变量

- `char *getenv(const char *name);`
   - 成功：返回环境变量的值；
   - 失败：NULL（name）不存在。

- 练习：编程实现`getenv`函数。

### setenv函数

- 设置环境变量的值

- `int setenv(const char *name, const char * value, int overwrite);`
   - 成功：0；
   - 失败：-1
   - 参数overwrite取值：
      - 1：覆盖原环境变量
      - 0：不覆盖。（该参数常用于设置新环境变量，如：ABC=day-night）


### unsetenv函数

- 删除环境变量name的定义

- `int unsetenv(const char *name);`
  -  成功：0；
  -  失败：-1
  - 注意事项：name不存在仍返回0（成功）， 当name命名为"ABC="时则会出错。

- 示例

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <string.h>
   
   int main(int argc, char * argv[])
   {
       char * val;
       const char * name = "ABD";
       
       val = getenv(name);
       printf("1, %s = %s\n", name, val);//ABD = NULL
       
       setenv(name, "efg", 1);
       
       val = getenv(name);
       printf("2, %s = %s\n", name, val);//ABD = efg
          
       int ret = unsetenv(name);
       printf("ret = %d \n", ret);//0
       
       val = getenv(name);
       printf("3, %s = %s \n", name, val);//ABD = NULL
    
       return 0;
   }
   ```



## 进程控制

### fork函数

- 创建一个子进程。
- `pid_t fork(void);`

  - 失败返回-1；
  - 成功返回：1、父进程返回子进程的ID（非负）；2、子进程返回0。
- pid_t类型表示进程ID，但为了表示-1， 它是有符号整形。（0不是有效进程ID，init最小为1）。
- 注意返回值，不是fork函数能返回两个值，而是fork后，fork函数变为两个，父子需各自返回一个。
- 示例

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   
   int main(int argc, char *argv[])
   {
       printf("father process exec begin...");
       
       pid_t pid = fork();
       if(pid == -1)
       {
           perror("fork error");
           exit(1);
       }
       else if(pid == 0)
       {
           printf("I'm child, pid = %u, ppid = %u \n", getpid(), getppid());
       }
       else
       {
           printf("I'm father, pid = %u, ppid = %u \n", getpid(), getppid());
           sleep(1);
       }
       
       printf("father process exec end...");
       return 0;
   }
   ```

- 循环创建n个子进程
  - 一次fork函数调用可以创建一个子进程。那么创建n个子进程应该怎么实现呢？
  - 简单想，`for(i = 0; i< n; i++){ fork() }`即可。但这样创建的是N个子进程吗？

![循环创建n个子进程](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e5%be%aa%e7%8e%af%e5%88%9b%e5%bb%ban%e4%b8%aa%e5%ad%90%e8%bf%9b%e7%a8%8b.png)

- 错误示例

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   
   int main(int argc, char *argv[])
   {
       printf("father process exec begin...");
       
       pid_t pid;
       int i;
       for(i = 0; i < 5; i++)
       {
           pid_t pid = fork();
           if(pid == -1)
           {
               perror("fork error");
               exit(1);
           }
           else if(pid == 0)
           {
               printf("I'm %dth child, pid = %u, ppid = %u \n", i+1, getpid(), getppid());
           }
           else
           {
               printf("I'm father, pid = %u, ppid = %u \n", getpid(), getppid());
               sleep(1);
           }        
       }
   
       printf("father process exec end...");
       return 0;
   }
   ```

- 正确的调用方式

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   
   int main(int argc, char *argv[])
   {
       printf("father process exec begin...");
       
       pid_t pid;
       int i;
       for(i = 0; i < 5; i++)
       {
           pid_t pid = fork();
           if(pid == -1)
           {
               perror("fork error");
               exit(1);
           }
           else if(pid == 0)
           {
               //不让子进程现创建孙子进程
               break;
           }       
       }
   
       if(i<5)
       {
           sleep(i);
           printf("I'm %dth child, pid = %u, ppid = %u \n", i+1, getpid(), getppid());
       }
       else
       {
           sleep(i);
           printf("I'm father");
       }
       
       return 0;
   }
   ```

- getpid函数

  - 获取进程ID。`pid_t getpid(void);`

- getppid函数

  - 获取父进程ID。`pid_t getppid(void);`

- getuid函数
  - 获取当前进程实际用户ID。`uid_t getuid(void);`
  - 获取当前进程有效用户ID。`uid_t geteuid(void);`

- getgid函数
  - 获取当前进程使用用户组ID。`gid_t getgid(void);`
  - 获取当前进程有效用户组ID。`gid_t getegid(void);`

- 进程共享
  - 父子进程之间在fork后，有哪些相同，那些想异之处呢？
     - 父子相同处：全局变量、.data、.text、栈、堆、环境变量、用户ID、宿主目录、进程工作目录、信号处理方式……
     - 父子不同处：进程ID、fork返回值、父进程ID、进程运行时间、闹钟（定时器）、未决定信号集。
     - 似乎，子进程复制了父进程0-3G用户空间内容，以及父进程的PCB，但pid不同。真的每fork一个子进程都要将父进程的0-3G地址空间完全拷贝一份，然后在映射至物理内存吗？
     - 当然不是，父子进程间遵循**读时共享写时复制**的原则。这样设计，无论子进程执行父进程的逻辑还是执行自己的逻辑都能节省内存开销。
     - 练习：编写程序测试，父子进程是否共享全局变量。
     - 重点注意！躲避父子进程共享全局变量的知识误区！
  - **重点**：父子进程共享：1、文件描述符（打开文件的结构体）。2、mmap建立的映射区（进程间通信详解）。
  - 特别的，fork之后的父进程先执行还是子进程先执行不确定。取决于内核所使用的调度算法。

- gdb调试
  - 使用gdb调试的时候，gdb只能跟踪一个进程。可以在fork函数调用之前，通过指令设置gdb调试工具跟踪父进程或者是跟踪子进程。默认跟踪父进程。
  - `set follow-fork-mode child` 命令设置gdb在fork之后跟踪子进程。
  - `set follow-fork-mode parent` 设置跟踪父进程。
  - 注意：一定要在fork函数调用之前设置才有效。



## exec函数族

- fork创建子进程后执行的是和父进程相同的程序（但有可能执行不同的代码分支）， 子进程往往要调用一种exec函数以执行另一个程序。当进程调用一种exec函数时，该进程的用户空间代码和数据完全被新程序替换，从新程序的启动例程开始执行。调用exec并不创建新进程，所以调用exec前后该进程的id并未改变。

- 将当前进程的.text、.data替换为所要加载的程序的.text、.data，然后让进程从新的.text第一条指令开始执行，但进程ID不变，换核不换壳。

- 其实有六种以exec开头的函数，统称exec函数：
   - `int execl(const char *path, const char *arg, ...);`
   - `int execlp(const char *file, const char *arg, ...);`
   - `int execle(const char *path, const char *arg, ..., char * const envp[]);`
   - `int execv(const char *path, char *const argv[]);`
   - `int execvp(const char *file, char *const argv[]);`
   - `int execve(const *path, char * const argv[], char *const envp[]);`

### execlp函数

- 加载一个进程，借助PATH环境变量

- `int execlp(const char *file, const char *arg, ...); `成功：无返回；失败：-1。

- 参数1：要加载的程序的名字。该函数需要配合PATH环境变量来使用，当PAHT中所有目录搜索后没有参数1则出错返回。

- 该函数通常用来调用系统程序。如：ls、date、cp、cat等命令。

- 示例

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   
   int main(int argc, char * argv[])
   {
       pid_t pid;
       pid = fork();
       if(pid == -1)
       {
           perror("fork error");
           exit(1);
       }
       else if (pid > 0)
       {
           sleep(1);
           printf("parent");
       }
       else
       {
           execlp("ls", "ls", "-l", "-a", NULL);
       }
       
       return 0;
   }
   ```

### execl函数

- 加载一个进程，通过路径+程序名来加载。

- `int execl(const char *path, const char *arg, ...);`成功：无返回；失败：-1

- 对比execlp, 如加载“ls”命令带有-l，-F参数

   ```c
   execlp("ls", "ls", "-l", "-F", NULL);         //使用程序名在PATH中搜索
   execl("/bin/ls", "ls", "-l", "-F", NULL);      //使用参数1给出的绝对路径搜索
   ```

### execvp函数

- 加载一个进程，使用自定义环境变量env。

- `int execvp(const char *file, const char *argv[]);`

- 变参形式：`1、...  2、argv[] `（main 函数也是变参函数，形式上等同于`int main(int argc, char *argv0, ...)`）

- 变参终止条件：1、NULL结尾；2、固参指定。

- execvp与execlp参数形式不同，原理一致。

   ```C
   char *argv[] = {"ls", "-l", "-a", NULL};
   execvp("ls", argv);
   execv("/bin/ls", argv);
   ```

- 练习：将当前系统中的进程信息，打印到文件中。

   ```c
   #include <unistd.h>
   #include <fcntl.h>
   #include <stdio.h>
   #include <stdlib.h>
   
   int main(int argc, char *argv[])
   {
       int fd;
       fd = open("ps.out", O_WRONLY | O_CREAT | O_TRUNC, 0644);
       if(fd < 0)
       {
           perror("open ps.out error");
           exit(1);
       }
       
       dup2(fd, STDOUT_FILENO);
       
       execlp("ps", "ps", "aux", NULL);//执行成功，后面的语句不会执行
      perror("execlp error");
      exit(1);
   
       return 0;
   }
   ```

### exec函数族一般规律

- exec函数一旦调用成功即执行新的程序，不返回。只有失败才返回，错误值-1。所以通常我们直接在exec函数调用后直接调用`perror`和`exit()`，无需if判断。

   ```
   l(list)            命令行参数列表。
   p(path)            搜索file时使用path变量
   v(vector)         使用命令行参数数组
   e(environment)      使用环境变量数组，不使用进程原有的环境变量，设置新加载程序运行的环境变量。
   ```

- 事实上，只有`execve`是真正的系统调用，其它五个函数最终都是调用`execve`，所以`execve`在man手册第2节，其它函数在man手册第3节。这些函数之间的关系如下图所示。

![exec函数族](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_exec%e5%87%bd%e6%95%b0%e6%97%8f.png)



## 回收子进程

### 孤儿进程

- 孤儿进程：父进程先于子进程结束，则子进程成为孤儿进程，子进程的父进程成为init进程，称为init进程领养孤儿进程。

- 示例，产生一个孤儿进程：

   ```c
   #include <stdio.h>
   #include <unistd.h>
   #include <sys/wait.h>
   
   int main(int argc, char * argv[])
   {
       pid_t pid;
       pid = fork();
       
       if(pid == 0)
       {
           while(1)
           {
               printf("I am child, my parent pid is %d\n", getppid());
               sleep(1);
           }
       }
       else if(pid >0)
       {
           printf("I am parent, my pid is %d \n", getpid());
           sleep(9);
           printf("----------parent going to die---------\n");
       }
       else
       {
           perror("fork");
           return 1;
       }
       
       return 0;
   }
   ```

### 僵尸进程

- 僵尸进程：进程终止，父进程尚未回收，子进程残留资源（PCB）存放于内核中，变成僵尸（Zombie）进程。

- 特别注意：僵尸进程是不能使用kill命令清除掉的。因为kill命令只是用来终止进程的，而僵尸进程已经终止。

- 思考，用什么办法可清除僵尸进程呢？

- 示例，产生一个僵尸进程：

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <sys/wait.h>
   
   int main(int argc, char *argv[])
   {
       pid_t pid;
       pid = fork();
   
       if(pid == 0)
       {
           printf("---child, my parent=%d, going to sleep 10s \n", getppid());
           sleep(10);
           printf("-------------child die--------------\n");
       }
       else if(pid > 0)
       {
           while(1)
           {
               printf("I am parent, pid = %d, myson = %d \n", getpid(), pid);
           }
       }
       else {
           perror("fork error");
           exit(1);
       }
       return 0;
   }
   ```

### wait函数

- 一个进程在终止时会关闭所有文件描述符，释放在用户空间分配的内存，但它的PCB还保留着，内核在其中保存了一些信息：如果是正常终止则保存着退出状态，如果是异常终止则保存着导致该进程终止的信号是哪个。这个进程的父进程可以调用wait或waitpid获取这些信息，然后彻底清除掉这个进程。我们知道一个进程的退出状态可以在shell中用特殊变量$?查看，因为Shell是它的父进程，当它终止时Shell调用wait或waitpid得到它的退出状态，同时彻底清除掉这个进程。

- 父进程调用wait函数可以回收子进程终止信息。该函数有三个功能：
  - 1、阻塞等待子进程退出。
  - 2、回收子进程残留资源。
  - 3、获取子进程结束状态（退出原因）。
  - `pid_t wait(int *status); `
     - 成功：清理掉的子进程ID；
     - 失败：-1（没有子进程）。

- 当进程终止时，操作系统的隐式回收机制会：
  - 1、关闭所有文件描述符。
  - 2、释放用户空间分配的内存。内核的PCB仍存在。其中保存该进程的退出状态。（正常终止-->退出值班；异常终止-->终止信号）。

- 可使用wait函数传出参数status来保存进程的退出状态。借助宏函数来进一步判断进程终止的具体原因。宏函数可以分为如下三组：

   ```c
   1、WIFEXITED(status)         为非0 --> 进程正常结束
      WEXITSTATUS(status)      如上宏为真，使用此宏 --> 获取进程退出状态（exit的参数）
   2、WIFSIGNALED(status)      为非0 --> 进程异常结束
      WTERMSIG(status)         如上宏为真，使用此宏 --> 取得使进程终止的那个信号的编号。
   3、WIFSTOPPED(status)      为非0 --> 进程处于暂停状态
      WSTOPSIG(status)         如上宏为真，使用此宏 --> 取得使进程暂停的那个信号的编号。
      WIFCONTINUED(status)      为真 --> 进程暂停后已经继续运行。
   ```

- 示例

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <sys/wait.h>
   
   int main(int argc, char *argv[])
   {
       pid_t pid, wpid;
       int status;
       pid = fork();
   
       if(pid == 0)
       {
           printf("---child, my parent=%d, going to sleep 10s \n", getppid());
           sleep(30);
           printf("-------------child die--------------\n");
           //exit(100);
           return 100;
       }
       else if(pid > 0)
       {
           wpid = wait(&status);
           if(wpid == -1)
           {
               perror("wait error");
               exit(1);
           }
           if(WIFEXITED(status))
           {
               printf("child exit with %d \n", WEXITSTATUS(status));
           }
           if(WIFSIGNALED(status))
           {
               printf("child killed by %d \n", WTERMSIG(status));
           }
   
           while(1)
           {
               printf("I am parent, pid = %d, myson = %d \n", getpid(), pid);
           }
       }
       else {
           perror("fork error");
           exit(1);
       }
       return 0;
   }
   ```

### waitpid函数

- 作用同wait，但可指定pid进程清理，可以不阻塞。

- `pid_t waitpid(pid_t pid, int *status, int options);`成功：返回清理掉的子进程ID；失败：-1（无子进程）。

- 特殊参数和返回情况：

   ```
   参数pid:
         >0      回收指定ID的子进程
         -1      回收任意子进程（相当于wait）
         0      回收和当前调用waitpid一个组的所有子进程
         <-1      回收指定进程组内的任意子进程
   参数status
   参数options：
         0         （wait）阻塞回收
         WNOHANG      非阻塞回收（轮询）
   返回：
         成功         pid
         失败         -1
         0         参数3传WNOHANG，并且子进程尚未结束
   ```

- 注意：一次wait或waitpid调用只能清理一个子进程，清理多个子进程应使用循环。

- 作业：父进程fork 3个子进程，三个子进程一个调用`ps`命令，一个调用自定义程序1（正常），一个调用自定义程序2（会出现错误）。父进程使用waitpid对其子进程进行回收。

- 示例

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <sys/wait.h>
   
   int main(int argc, char *argv[])
   {
       int n = 5, i;//默认创建五个子进程
       pid_t p, q;
       pid_t wpid;
       
       if(argc == 2)
       {
           n = atoi(argv[1]);
       }
   
       for(i = 0; i < n; i++)
       {//出口1，父进程专用出口
           p = fork();
           if(p == 0)
           {
               break;//出口2，子进程出口，i不自增
           }
           else if (i == 3)
           {
               q = p;
           }
       }
   
       if(n == i)
       {
           sleep(n);
           printf("I am parent, pid = %d\n", getpid(), getgid());
           //waitpid(q, NULL, 0);  //1、回收第三个子进程
           //while(waitpid(-1, NULL, 0));  //2、等价于wait(NULl),阻塞回收任意子进程
           do
           {
               //3、非阻塞回收任意子进程
               //如果wpid == 0 说明子进程正在运行
               wpid = waitpid(-1, NULL, WNOHANG);
               if(wpid > 0)
               {
                   n--;
               }
               sleep(1);
           }
           while(n > 0)
   
           printf("wait finish\n");
       }
       else
       {
           sleep(i);
           printf("I'm %dth child, pid = %d, gid = %d \n", i+1, getpid(), getgid());
       }
      
       return 0;
   }
   ```



## IPC（InterProcess Communication）进程间通信

- linux环境下，进程地址空间相互独立，每个进程各自有不同的用户地址空间。任何一个进程的全局变量在另一个进程中都看不到，所以进程和进程之间不能相互访问，要交换数据必须通过内核，在内核中开辟一块缓冲区，进程1把数据从用户空间拷到内核缓冲冲区，进程2再从内核缓冲区把数据读走，内核提供的这种机制称为进程间通信（IPC）。

![进程间通信IPC](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e8%bf%9b%e7%a8%8b%e9%97%b4%e9%80%9a%e4%bf%a1IPC.png)

- 在进程间完成数据传递需要借助操作系统提供特殊的方法，如：文件、管道、信号、共享内存、消息队列、套接字、命名管道等。随着计算机的蓬勃发展，一些方法由于自身设计缺陷被淘汰或者弃用。常用的进程间通信方式有：
   - 管道（使用最简单）
   - 信号（开销最小）
   - 共享映射区（无血缘关系）
   - 本地套接字（最稳定）

## 管道

### 管道的概念

- 管道是一种最基本的IPC机制，作用于有血缘关系的进程之间，完成数据传递。调用pipe系统函数即可创建一个管道。有如下特质：
   - 1、其本质是一个伪文件（实为内核缓冲区）
   - 2、由两个文件描述符引用，一个表示读端，一个表示写端。
   - 3、规定数据从管道的写端流入管道，从读端流出。

- 管理的原理：管道实为内核使用环形队列机制，借助内核缓冲区（4k）实现。

- 管道的局限性：
   - 1、数据自己读不能自己写。
   - 2、数据一旦被读走，便不在管道中存在，不可反复读取。
   - 3、由于管道采用半双工通信方式。因此，数据只能在一个方向上流动。
   - 4、只能在有公共祖先的进程间使用管道。

### pipe函数

- `int pipe(int pipefd[2]);`

- 参数
   - fd[2] (传出参数)

- 返回值
   - 成功：0
   - 失败：-1，设置errno

### 管道的读写行为

- 读管道
  - 管道中有数据
     - read返回实际读到的字节数
  - 管道中无数据
     - 写端全关闭：read返回0
     - 仍有写端打开：阻塞等待

- 写管道
  - 读端全关闭
     - 进程异常终止（SIGPIPE信号）
  - 有读端打开
     - 管道未满：写数据，返回写入字节数
     - 管道已满：阻塞（少见）

- 父子进程间通信`ls | wc -l`

   ```c
   #include <stdio.h>
   #include <unistd.h>
   #include <sys/wait.h>
      
   int main(void)
   {
       pid_t pid;
       int fd[2];
   
       pipe(fd);
       pid = fork();
   
       //子进程
       if(pid == 0){
           //子进程从管道中读数据，关闭写端
           close(fd[1]);
           //让wc从管道中读取数据
           dup2(fd[0], STDIN_FILENO);
           //wc命令默认从标准读入取数据
           execlp("wc", "wc", "-l", NULL);
       }else {
           //父进程向管道中写数据，关闭读端
           close(fd[0]);
           //将ls的结果写入管道中
           dup2(fd[1], STDOUT_FILENO);
           //ls输出结果默认对应屏幕
           execlp("ls", "ls", NULL);
       }
   
       return 0;
   }
   ```

- 兄弟进程间通信

   ```c
   #include <stdio.h>
   #include <unistd.h>
   #include <sys/wait.h>
   
   int main(void)
   {
       pid_t pid;
       int fd[2], i;
   
       pipe(fd);
   
       for(i = 0; i < 2; i++){
           if((pid = fork()) == 0){
               break;
           }
       }
   
       if(i == 0){        //兄
           close(fd[0]);           //写，关闭读端
           dup2(fd[1], STDOUT_FILENO);
           execlp("ls", "ls", NULL);
       }else if(i == 1){  //弟
           close(fd[1]);           //读，关闭写端
           dup2(fd[0], STDIN_FILENO);
           execlp("wc", "wc", "-l", NULL);
       }else {
           close(fd[0]);
           close(fd[1]);
           for(i = 0; i < 2; i++){ //两个儿子wait两次
               wait(NULL);
           }
       }
   
       return 0;
   }
   ```

### 管道缓冲区的大小

- 命令：`ulimit -a`

- 函数：`fpathconf`, 参数2：`__PC_PIPE_BUF`

### 管道的优劣

- 优点：
   - 实现手段简单

- 缺点：
   - 单向通信
   - 只能有血缘关系进程间使用

## FIFO

- 命名管道（Linux基础文件类型）

- 创建
   - 命令：`mkfifo`
   - 函数：`int mkfifo(const char *pathname, mode_t mode);`
      - 参数：
         - name
         - mode：8进制
      - 返回值：
         - 成功：0
         - 失败：-1，设置errno

- 无血缘关系进程间通信
   - 使用同一FIFO
   - 可多读端，多写端

## 共享存储映射

### 文件进程间通信

- 使用文件也可以完成IPC，理论依据是，fork后，父子进程共享文件描述符。也就共享打开的文件。

- 练习：编程测试，父子进程共享打开的文件。借助文件进行进程间通信。

- 思考：无血缘关系的进程可以打开同一个文件进行通信吗？为什么？

- 示例

   ```c
   /**
   *父子进程共享打开的文件描述符------使用文件完成进程间共享
   */
   #include <stdio.h>
   #include <unistd.h>
   #include <string.h>
   #include <stdlib.h>
   #include <fcntl.h>
   #include <sys/wait.h>
   
   int main(int argc, char *argv[])
   {
       int fd1, fd2;
       pid_t pid;
       char * str = "----test for shared fd in parent child process----\n";
   
       pid = fork();
       if(pid < 0)
       {
           perror("fork error");
           exit(1);
       }
       else if(pid == 0)
       {
           fd1 = open("test.txt", O_RDWR);
           if(fd1 < 0)
           {
               perror("open error");
               exit(1);
           }
           
           //子进程写入数据
           write(fd1, str, strlen(str));
           printf("child wrote over...\n");
       }
       else
       {
           fd2 = open("test.txt", O_RDWR);
           if(fd2 < 0)
           {
               perror("open error");
               exit(1);
           }
           sleep(1);   //保证子进程写入数据
   
           //父进程读取数据
           int len = read(fd2, buf, sizeof(buf));
           write(STDOUT_FILENO, buf, len);
   
           wait(NULL);
       }
   
       return 0;
   }
   ```

### 存储映射I/O

- 存储映射I/O（Memory-mmapped I/O）使一个磁盘文件与存储空间中一个缓冲区相映射。于是当从缓冲区取数据，就相当于读文件中的相应字节。于此类似，将数据存入缓冲区，则相应的字节就自动写入文件。这样，就可在不适用read和write函数的情况下，使用地址（指针）完成I/O操作。

- 使用这种方法，首先应通知内核，将一个指定文件映射到存储区域中。这个映射工作可以通过mmap函数来实现。

![mmap](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_mmap.png)

- mmap函数

  - `void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset);`

  - 返回：
    - 成功：返回创建的映射区的首地址。
    - 失败：MAP_FAILED宏。

  - 参数：
    - addr：建立映射区的首地址，由Linux内核指定。使用时，直接传递NULL。
    - length：欲创建映射区的大小。
    - prot：映射区权限PROT_READ、PROT_WRITE、PROT_READ | PROT_WRITE。
    - flags：标志位参数（常用于设定更新物理区域、设置共享、创建匿名映射区）
       - MAP_SHARED：会将映射区所做的操作反映到物理设备（磁盘）上。
       - MAP_PRIVATE：映射区所做的修改不会反映到物理设备。
    - fd：用来建立映射区的文件描述符。
    - offset：映射文件的偏移（4k的整数倍）

  - 示例

     ```c
     #include <stdio.h>
     #include <stdlib.h>
     #include <string.h>
     #include <unistd.h>
     #include <fcntl.h>
     #include <sys/mmap.h>
     
     void sys_err(char *str)
     {
         perror(str);
         exit(1);
     }
     
     int main(int argc, char *argv[])
     {
         char *p = NULL;
         int fd = open("test.txt", O_CREAT|O_REWR, 0644);
         if(fd < 0)
         {
             sys_err("open error");
         }
     
         int len = ftruncate(fd, 4);
         if(len == -1)
         {
             sys_err("ftruncate error");
         }
     
         p = mmap(NULL, 4, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
         if(p == MAP_FAILED)
         {
             sys_err("mmap error");
         }
     
         strcpy(p, "abc");  //写数据
     
         int ret = munmap(p, 4);
         if(ret == -1)
         {
             sys_err("munmap error");
         }
         close(fd);
     
         return 0;
     }
     ```

- munmap函数

  - 同malloc函数申请内存空间类似的，mmap建立的映射区在使用结束后也应调用类似free的函数来释放。

  - `int munmap(void *addr, size_t length);` 
     - 成功：0；
     - 失败：-1。

  - 借鉴malloc和free函数原型，尝试封装自定义smalloc，sfree来完成映射区的建立和释放。思考函数应如何设计？

- mmap注意事项

  - 思考：
     - 1、可以open的时候O_CREAT一个新文件来创建映射区吗？（可以）
     - 2、如果open时O_RDONLY，mmap时PROT参数指定PROT_READ|PROT_WRITE会怎样？（权限不足）
     - 3、文件描述符先关闭，对mmap映射有没有影响？（没有影响）
     - 4、如果偏移量为1000会怎样？（不行，必须是4k的整数倍）
     - 5、对mem越界操作会怎样？（不能越界）
     - 6、如果mem++，mmap可否成功？（不行）
     - 7、mmap什么情况下会调用失败？（每个参数都有影响）
     - 8、如果不检测mmap的返回值，会怎样？（会死得很难看）

  - 总结：使用mmap时务必注意以下事项：
     - 1、创建映射区的过程中，隐含着一次对映射文件的读操作。
     - 2、当MAP_SHARED时，要求：映射区的权限<=文件打开的权限（出于对映射区的保护）。而MAP_PRIVATE则无所谓，因为mmap中的权限是对内存的限制。
     - 3、映射区的释放与文件关闭无关。只要映射建立成功，文件可以立即关闭。
     - 4、特别注意，当映射文件大小为0时，不能创建映射区。所以：用于映射的文件必须要有实际大小！！mmap使用时常常会出现总线错误，通常是由于共享文件存储空间大小引起的。
     - 5、munmap传入的地址一定是mmap的返回地址。坚决杜绝指针++、--操作。
     - 6、如果文件偏移量必须为4k的整数倍。
     - 7、mmap创建映射区出错概率非常高，一定要检查返回值，确保映射区建立成功再进行后续操作。

### mmap父子进程通信

- 父子等有血缘关系的进程之间也可以通过mmap建立的映射区来完成数据通信。但相应的要在创建映射区的时候指定对应的标志位参数flags:
  - MAP_PRIVATE：（私有映射）父子进程各自独占映射区。
  - MAP_SHARED：（共享映射）父子进程共享映射区。

- 练习：父进程创建映射区，然后fork子进程，子进程修改映射区内容，然后，父进程读取映射区内容，查验是否共享。

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <fcntl.h>
   #include <sys/mman.h>
   #include <sys/wait.h>
   
   int var = 100;
   
   int main(int argc, char *argv[])
   {
       int *p;
       pid_t pid;
   
       int fd;
       fd = open("temp", O_RDWR|O_CREAT|O_TRUNC, 0644);
       if(fd <　0)
       {
           perror("open error");
           exit(1);
       }
   
       unlink("temp"); //删除临时文件目录项，使之具备被释放条件
       ftruncate(fd, 4);
   
       p = (int *)mmap(NULL, 4, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
       //p = (int *)mmap(NULL, 4, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
       if(p == MAP_FAILED) //注意：不是p == NULL
       {
           perror("mmap error");
           exit(1)
       }
       close(fd); //映射区建立完毕，即可关闭文件
   
       pid = fork();//创建子进程
       if(pid == 0)
       {
           *p = 2000;
           var = 1000;
           printf("child, *p = %d, var = %d\n", *p, var);
       }
       else
       {
           sleep(1);
           printf("parent, *p = %d, var = %d\n", *p, var);
           wait(NULL);    
       }
   
       int ret = mnumap(p, 4);//释放映射区
       if(ret == -1)
       {
           perror("mnumap error");
           exit(1);
       }
   
       return 0;
   }
   ```

- 结论：父子进程共享：
  - 1、打开的文件
  - 2、mmap建立的映射区（但必须要使用MAP_SHARED）

### 匿名映射

- 通过使用我们发现，使用映射区来完成文件读写操作十分方便，父子进程间通信也较容易。但缺陷是，每次创建映射区一定要依赖一个文件才能实现。通常为了建立映射区要open一个temp文件，创建好了再unlink、close掉，比较麻烦。可以直接使用匿名精映射来代替。其实Linux系统给我们提供了创建匿名映射区的方法，无需依赖一个文件即可创建映射区。同样需要借助标志位参数flags来指定。

- 使用MAP_ANONYMOUS(或MAP_ANON)，如：

   ```c
   int *p = mmap(NUll, 4, PROT_READ|PROT_WRITE， MAP_SHARED|MAP_ANONYMOUS, -1, 0);
   //"4"随意举例，该位置大小，可依实际需要填写。
   ```

- 需要注意的是，MAP_ANONYMOUS和MAP_ANON这两个宏是Linux操作系统特有的宏。在类Unix系统中如无该宏定义，可使用如下两步来完成匿名映射区的建立。

   ```c
   1、fd = open("/dev/zero", O_RDWR);
   2、p = mmap(NULL, size, PROT_READ|PROT_WRITE， MMAP_SHARED, fd, 0);
   ```

- 示例

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <fcntl.h>
   #include <sys/mman.h>
   #include <sys/wait.h>
   
   int var = 100;
   
   int main(int argc, char *argv[])
   {
       int *p;
       pid_t pid;
   
       p = (int *)mmap(NULL, 4, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANON, -1, 0);
       if(p == MAP_FAILED) //注意：不是p == NULL
       {
           perror("mmap error");
           exit(1)
       }
   
       pid = fork();//创建子进程
       if(pid == 0)
       {
           *p = 2000;
           var = 1000;
           printf("child, *p = %d, var = %d\n", *p, var);
       }
       else
       {
           sleep(1);
           printf("parent, *p = %d, var = %d\n", *p, var);
           wait(NULL);    
       }
   
       int ret = mnumap(p, 4);//释放映射区
       if(ret == -1)
       {
           perror("mnumap error");
           exit(1);
       }
   
       return 0;
   }
   ```

### mmap无血缘关系进程间通信

- 实质上mmap是内核借助文件帮我们创建了一个映射区，多个进程之间利用该映射区完成数据传递。由于内核空间多进程共享，因此无血缘关系的进程间也可以使用mmap来完成通信。只要设置相应的标志位参数flags即可。若想实现共享，当然应该使用MAP_SHARED了。

- 示例
  - 读端​   

     ```c
     #include <stdio.h>
     #include <sys/stat.h>
     #include <fcntl.h>
     #include <unistd.h>
     #include <stdlib.h>
     #include <sys/mman.h>
     #include <string.h>
     
     struct STU
     {
         int id;
         char name[20];
         char sex;
     }
     
     void sys_err(char *str)
     {
         perror(str);
         exit(-1);
     }
     
     int main(int argc, char *argv[])
     {
         int fd;
         struct STU student;
         struct STU *mm;
     
         if(argc < 2)
         {
             printf("./a.out file_shared\n");
             exit(-1);
         }
     
         fd = open(argv[1], O_RDONLY);
         if(fd == -1)
         {
             sys_err("open error");
         }
     
         mm = mmap(NULL, sizeof(student), PROT_READ, MAP_SHARED, fd, 0);
         if(mm == MAP_FAILED)
         {
             sys_err("mmap error");
         }
     
         close(fd);
     
         while(1)
         {
             printf("id=%d\t name=%s\t %c\n", mm->id, mm->name, mm->sex);
             sleep(2);
         }
     
         munmap(mm, sizeof(student));
     
         return 0;
     }
     ```

  - 写端

     ```c
     #include <stdio.h>
     #include <sys/stat.h>
     #include <sys/types.h>
     #include <fcntl.h>
     #include <unistd.h>
     #include <stdlib.h>
     #include <sys/mman.h>
     #include <string.h>
     
     struct STU
     {
         int id;
         char name[20];
         char sex;
     }
     
     void sys_err(char *str)
     {
         perror(str);
         exit(-1);
     }
     
     int main(int argc, char *argv[])
     {
         int fd;
         struct STU student = {10, "xiaoming", 'm'};
         char *mm;
     
         if(argc < 2)
         {
             printf("./a.out file_shared\n");
             exit(-1);
         }
     
         fd = open(argv[1], O_RDWR | O_CREAT, 0664);
         ftruncate(fd, sizeof(student));
     
         mm = mmap(NULL, sizeof(student), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
         if(mm == MAP_FAILED)
         {
             sys_err("mmap error");
         }
     
         close(fd);
     
         while(1)
         {
             memcpy(mm, &student, sizeof(student));
             student.id++;
             sleep(1);
         }
     
         munmap(mm, sizeof(student));
     
         return 0;
     }
     ```

## 阶段综合练习一

- 实现文件多进程拷贝。
- 假设有一个超大文件，需对其完成拷贝工作。为提高效率，可采用多进程并行拷贝的方法实现。假设文件大小为len，共有n个进程对该文件进行拷贝。那每个进程拷贝的字节数应为len/n。但未必一定能整除，我们可以选择最后一个进程负责剩余部分拷贝工作。可使用len%(len/n)将剩余部分大小求出。
- 为降低实现复杂度，可选用mmap来实现源、目标文件的映射，通过指针操作内存地址，设置每个进程拷贝的起始、结束位置。借助MAP_SHARED选项将内存中所做的修改反映到物理磁盘上。
![多进程拷贝](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e5%a4%9a%e8%bf%9b%e7%a8%8b%e6%8b%b7%e8%b4%9d.png)
- 实现步骤：
   - 1、指定创建子进程的个数
   - 2、打开源文件
   - 3、打开目的文件，不存在则创建
   - 4、获取文件大小
   - 5、根据文件大小拓展目标文件
   - 6、为源文件创建映射
   - 7、为目标文件创建映射
   - 8、求出每个子进程该拷贝的字节数
   - 9、创建N个子进程
   - 10、子进程完成分块拷贝（注意最后一个子进程拷贝起始位置）
   - 11、释放映射区

## 阶段综合练习二
- 实现简单的交互式的Shell。
- 使用已学习的各种C函数实现一个简单的交互式的Shell, 要求：
  - 1、给出提示符，让用户输入一行命令，识别程序名和参数并调用适当的exe函数执行程序，待执行完成后再次给出提示符。

  - 2、该程序可识别和处理以下符号：
    - 1）简单的标准输入输出重定向：仿照例“父子进程ls | wc -l”，先dup2然后exec。
    - 2）管理（|）：Shell进程先调用pipe创建管道，然后fork出两个子进程。一个子进程关闭读端，调用dup2将写端赋给标准输出，另一个子进程关闭写端，调用dup2把读端赋给标准输入，两个子进程分别调用exec执行程序，而Shell进程把管道的两端都关闭，调用wait等待两个子进程终止。类似于“兄弟进程间ls | wc -l”练习的实现。

  - 你的程序应该可以处理以下命令：

     ```bash
     ls -l -R > file1
     cat < file1 | wc -c > file1
     ```

  - 实现步骤：
    - 1、接收用户输入命令字符串，拆分命令及参数存储。（自行设计数据存储结构）
    - 2、实现普通命令加载功能。
    - 3、实现输入、输出重定向的功能。
    - 4、实现管道。
    - 5、支持多重管道。

## 阶段综合练习三
- 简易本地聊天室
- 借助IPC完成一个简易的本地聊天功能。设有服务器端和客户端两方。服务启动监听客户端请求，并负责记录处理客户端登录、聊天、退出等相关数据。客户端完成登录、发起聊天等操作。可以借助服务器转发向某个指定客户端完成数据包发送（聊天）。
- 客户端向服务器发送数据包，可采用如下协议格式来存储客户端数据，使用”协议号“区分客户端请求和各种状况。服务器依据包号处理客户端对应请求。
![简易聊天室](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e7%ae%80%e6%98%93%e8%81%8a%e5%a4%a9%e5%ae%a4.png)


## 信号的概念
- 信号在我们的生活中随处可见，如：古代战争中摔杯为号；现代战争中的信号弹；体育比赛中使用的信号枪......
- 他们都有共性：
   - 1、简单
   - 2、不能携带大量信息
   - 3、满足某个特设条件才发送
- 信号是信息的载体，Linux/Unix环境下，古老、经典的通信方式，现下依然是主要的通信手段。
- Unix早期版本就提供了信号机制，但不可靠，信号可能丢失。Berkeley和AT&T都对信号模型做了更改，增加了可靠信号机制。但彼此不兼容。POSIX.1对可靠信号例程进行了标准化。

### 信号的机制
- A给B发送信号，B收到信号之前执行自己的代码，收到信号后，不管执行到程序的什么位置，都要暂停运行，去处理信号，处理完毕再继续执行。与硬件中断类似--异步模式。但信号是软件层面上实现的中断，早期常被称为”软中断“。
- 信号的特质：由于信号是通过软件方法实现，其实现手段导致信号很强的延时性。但对于用户来说，这个延迟时间非常短，不易察觉。
- 每个进程收到的所有信号，都是由内核负责发送的，内核处理。

### 与信号相关的事件和状态
- 产生信号
   - 1、按键产生，如：ctrl+c、ctrl+z、ctrl+\
   - 2、系统调用产生，如：kill、raise、abort
   - 3、软件条件产生，如：定时器alarm
   - 4、硬件异常产生，如：非法访问内存（段错误）、除0（浮点数例外）、内存对齐出错（总线错误）
   - 5、命令产生，如：kill命令
- 递达：递达并且到达进程。
- 未决：产生和递达之间的状态。主要由于阻塞（屏蔽）导致该状态。
- 信号的处理方式：
   - 1、执行默认动作
   - 2、忽略（丢弃）
   - 3、捕捉（调用户处理函数）
- Linux内核的进程控制块PCB是一个结构体，task_struct，除了包含进程id，状态，工作目录，用户id，组id，文件描述符表，包含了信号相关的信息，主要指阻塞信号集和未决信号集。
- 阻塞信号集（信号屏蔽字）：将某些信号加入集合，对他们设置屏蔽，当屏蔽x信号后，再收到该信号，该信号的处理将推后（解除屏蔽后）
- 未决信号集
   - 1、信号产生，未决信号集中描述该信号的位立刻翻转为1，表信号处于未决状态。当信号被处理对应位翻转回为0。这一时刻往往非常短暂。
   - 2、信号产生后由于某些原因（主要是阻塞）不能抵达。这类信号的集合称之为未决信号集。在屏蔽解除前，信号一直处于未决状态。

![阻塞信号集与未决信号集](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e9%98%bb%e5%a1%9e%e4%bf%a1%e5%8f%b7%e9%9b%86%e4%b8%8e%e6%9c%aa%e5%86%b3%e4%bf%a1%e5%8f%b7%e9%9b%86.png)

### 信号的编号
- 可以使用`kill -l`命令来查看当前系统可使用的信号有哪些。

    ```
        1) SIGHUP        2) SIGINT        3) SIGQUIT        4) SIGILL        5) SIGTRAP
        6) SIGABRT        7) SIGBUS        8) SIGFPE        9) SIGKILL      10) SIGUSR1
       11) SIGSEGV      12) SIGUSR2      13) SIGPIPE      14) SIGALRM      15) SIGTERM
       16) SIGSTKFLT   17) SIGCHLD      18) SIGCONT      19) SIGSTOP      20) SIGTSTP
       21) SIGTTIN      22) SIGTTOU      23) SIGURG      24) SIGXCPU      25) SIGXFSZ
       26) SIGVTALRM   27) SIGPROF      28) SIGWINCH   29) SIGIO      30) SIGPWR
       31) SIGSYS      34) SIGRTMIN   35) SIGRTMIN+1   36) SIGRTMIN+2   37) SIGRTMIN+3
       38) SIGRTMIN+4   39) SIGRTMIN+5   40) SIGRTMIN+6   41) SIGRTMIN+7   42) SIGRTMIN+8
       43) SIGRTMIN+9   44) SIGRTMIN+10   45) SIGRTMIN+11   46) SIGRTMIN+12   47) SIGRTMIN+13
       48) SIGRTMIN+14   49) SIGRTMIN+15   50) SIGRTMAX-14   51) SIGRTMAX-13   52) SIGRTMAX-12
       53) SIGRTMAX-11   54) SIGRTMAX-10   55) SIGRTMAX-9   56) SIGRTMAX-8   57) SIGRTMAX-7
       58) SIGRTMAX-6   59) SIGRTMAX-5   60) SIGRTMAX-4   61) SIGRTMAX-3   62) SIGRTMAX-2
       63) SIGRTMAX-1   64) SIGRTMAX
    ```

- 不存在编号为0的信号。其中1-31号信号称之为常规信号（也叫普通信号或标准信号），34-64称之为实时信号，驱动编程与硬件相关。名字上区别不大。而前32个名字各不相同。

### 信号4要素
- 与变量三要素类似的，每个信号也有其必备**4要素**，分别是：
  - 1、编号
  - 2、名称
  - 3、事件
  - 4、默认处理动作
- 可通过`man 7 signal`查看帮助文档获取。也可查看`/usr/src/linux-headers-3.16.0-30/arch/s390/include/uapi/asm/signal.h`

   ```bash
   Signal     Value     Action   Comment
      ──────────────────────────────────────────────────────────────────────
      SIGHUP        1       Term    Hangup detected on controlling terminal or death of controlling process
      SIGINT        2       Term    Interrupt from keyboard
      SIGQUIT       3       Core    Quit from keyboard
      SIGILL        4       Core    Illegal Instruction
      SIGABRT       6       Core    Abort signal from abort(3)
      SIGFPE        8       Core    Floating point exception
      SIGKILL       9       Term    Kill signal
      SIGSEGV      11       Core    Invalid memory reference
      SIGPIPE      13       Term    Broken pipe: write to pipe with no readers
      SIGALRM      14       Term    Timer signal from alarm(2)
      SIGTERM      15       Term    Termination signal
      SIGUSR1   30,10,16    Term    User-defined signal 1
      SIGUSR2   31,12,17    Term    User-defined signal 2
      SIGCHLD   20,17,18    Ign     Child stopped or terminated
      SIGCONT   19,18,25    Cont    Continue if stopped
      SIGSTOP   17,19,23    Stop    Stop process
      SIGTSTP   18,20,24    Stop    Stop typed at terminal
      SIGTTIN   21,21,26    Stop    Terminal input for background process
      SIGTTOU   22,22,27    Stop    Terminal output for background process
   The signals SIGKILL and SIGSTOP cannot be caught, blocked, or ignored.
   ```

- 在标准信号中，有一些信号是有三个“Value”，第一个值通常对alpha和sparc架构有效，**中间值**针对x86、arm和其他架构，最后一个应用于mips架构。一个'-'表示在对应架构中尚未定义该信号。
- 不同的操作系统定义了不同的系统信号。因此有些信号出现在Unix系统内，也出现在Linux中，而有的信号出现在FreeBSD或Mac OS中，却没有出现在Linux中。这里我们只研究Linux系统中的信号。
- 默认动作：
  - Term：终止进程
  - Ign：忽略信号（默认即时对该种信号忽略操作）
  - Core：终止进程，生成Core文件。（查验进程死亡原因，用于gdb调试）
  - Stop：停止（暂停）进程
  - Cont：继续运行进程
- 注意`man 7 signal`帮助文档中可看到：`The signals SIGKILL and SIGSTOP cannot be caught, blocked, or ignored.`**这里特别强调了`9) SIGKILL`和`19) SIGSTOP`信号，不允许忽略和捕捉，只能执行默认动作。甚至不能将其设置为阻塞。**
- 另外需清楚，只有每个信号所对应的事件发生了，该信号才会被递达（但不一定递达），不应乱发信号！！

### Linux常规信号一览表
- 1)SIGHUP：当用户退出Shell时，由该Shell启动的所有进程将收到这个信号，默认动作为终止进程。
- 2)SIGINT：当用户按下了`ctrl+c`组合键时，用户终端向正在运行中的由该终端启动的程序发出此信号。默认动作为终止进程。
- 3)SIGQUIT：当用户按下`ctrl+\`组合键时产生该信号，用户终端向正在运行中的由该终端启动的程序发出此信号。默认动作为终止进程。
- 4)SIGILL：CPU检测到某进程执行了非法指令。默认动作为终止进程并产生core文件。
- 5)SIGTRAP：该信号由断点指令或其他trap指令产生。默认动作为终止进程并产生core文件。
- 6)SIGABRT：调用abort函数时产生该信号。默认动作为终止进程并产生core文件。
- 7)SIGBUS：非法访问内存地址，包括内存对齐出错，默认动作为终止进程并产生core文件。
- 8)SIGFPE：在发生致命的运算错误时发出。不仅包括浮点运算错误，还包括溢出及除数为0等所有的算法错误。默认动作为终止进程并产生core文件。
- 9)SIGKILL：无条件终止进程。本信号不能被忽略，处理和阻塞。默认动作为终止进程。它向系统管理员提供了可以杀死任何进程的方法。
- 10)SIGUSR1：用户定义的信号。即程序员可以在程序中定义并使用该信号。默认动作为终止进程。
- 11)SIGSEGV：指示进程进行了无效内存访问。默认动作为终止进程并产生core文件。
- 12)SIGUSR2：另外一个用户自定义信号，程序员可以在程序中定义并使用该信号。默认动作为终止进程。
- 13)SIGPIPE：Broken pipe向一个没有读端的管道写数据。默认动作为终止进程。
- 14)SIGALRM：定时器超时，超时的时间由系统调用alarm设置。默认动作为终止进程。
- 15)SIGTERM：程序结束信号，与SIGKILL不同的是，该信号可以被阻塞和终止。通常用来表示程序正常退出。执行Shell命令kill时，缺省产生这个信号。默认动作为终止进程。
- 16)SIGSTKFLT：Linux早期版本出现的信号，现仍保留向后兼容。默认动作为终止进程。
- 17)SIGCHLD：子进程结束时，父进程会收到这个信号。默认动作为忽略这个信号。
- 18)SIGCONT：如果进程已停止，则使其继续运行。默认动作为继续或忽略。
- 19)SIGSTOP：停止进程的执行。信号不能被忽略、处理和阻塞。默认动作为暂停进程。
- 20)SIGTSTP：停止终端交互进程的运行。按下`ctrl+z`组合键时发出这个信号。默认动作为暂停进程。
- 21)SIGTTIN：后台进程读终端控制台。默认动作为暂停进程。
- 22)SIGTTOU：该信号类似于SIGTTIN，在后台进程要向终端输出数据时发生。默认动作为暂停进程。
- 23)SIGURG   ：套接字上有紧急数据时，向当前正在运行的进程发出信号，报告有紧急数据到达。如网络带外数据到达，默认动作为忽略该信号。
- 24)SIGXCPU：进程执行时间超过了分配给该进程的CPU时间，系统产生该信号并发送给该进程。默认动作为终止进程。
- 25)SIGXFSZ：超过文件的最大长度设置。默认动作为终止进程。
- 26)SIGVTALRM：虚拟时钟超时时产生该信号。类似于SIGALRM,但是该信号只计算该进程占用CPU的使用时间。默认动作为终止进程。
- 27)SIGPROF：类似于SIGVTALRM，它不包括该进程占用CPU时间还包括执行系统调用时间。默认动作为终止进程。
- 28)SIGWINCH：窗口变化大小时发出。默认动作为忽略该信号。
- 29)SIGIO：此信号向进程指示发出了一个异步IO事件。默认动作为忽略。
- 30)SIGPWR：关机。默认动作为终止进程。
- 31)SIGSYS：无效的系统调用。默认动作为终止进程并产生core文件。
- 34)SIGRTMIN ~ 64)SIGRTMAX：Linux的实时信号，它们没有固定的含义（可以由用户自定义）。所有的实时信号的默认动作都为终止进程。

## 信号的产生

### 终端按键产生信号

```
   ctrl+c      2) SIGINT(终止/中断)      "INT" -- Interrupt
   ctrl+z      20)SIGTSTP(暂停/停止)      "T" -- Terminal终端
   ctrl+\      3) SIGQUIT(退出)
```

### 硬件异常产生信号
```
   除0操作         8) SIGFPE(浮点数例外)      "F" -- float 浮点数
   非法访问内存       11) SIGSEGV(段错误)
   总线错误         7) SIGBUS
```

### kill函数/命令产生信号
- kill命令产生信号：`kill -SIGKILL pid`
- kill函数：给指定进程发送指定信号（不一定杀死）
  - `int kill(pid_t pid, int sig);`
     - 返回值
        - 成功：0
        - 失败：-1（ID非法，信号非法，普通用户杀init进程等权级问题），设置errno。
     - 参数
        - sig：不推荐直接使用数字，应使用宏名，因为不同操作系统信号编号可能不同，但名称一致。
        - pid>0：发送信号给指定的进程。
        - pid=0：发送信号与调用kill函数进程属于同一进程组的所有进程。
        - pid<0：取|pid|发给对应进程组。
        - pid=-1：发送给进程有权限发送的系统中所有进程。
- 进程组：每个进程都属于一个进程组，进程组是一个或多个进程集合，他们相互关联，共同完成一个实体任务，每个进程组都有一个进程组长，默认进程组ID与进程组长ID相同。
- 权限保护：super用户（root）可以发送信号给任意用户，普通用户是不能向系统用户发送信号的。kill -9(root用户的pid)是不可以的。同样，普通用户也不能向其他普通用户发送信号，终止其进程。只能自己创建的进程发送信号。普通用户基本规则是：发送者实际或有效用户ID==接收者实际或有效用户ID。
- 练习：循环创建5个子进程，任一子进程用kill函数终止其父进程。
- 示例

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <sys/types.h>
   #include <signal.h>
      
   #define N 5
   
   int main(int argc, char *argv[])
   {
       int i;
       pid_t pid;
   
       for(i = 0; i < N; i++)
       {
           pid = fork();
           if(pid == 0)
               break;
           if(i == 2)
               q = pid;
       }
       if(i < N)
       {
           while(1)
           {
               printf("I am child %d, getpid() = %u \n", i+1, getpid());
               sleep(1);
           }
       }
       else
       {
           sleep(1);
           kill(q, SIGKILL);
           while(1);
       }
       // int ret = kill(getpid(), SIGKILL);
       // if(ret == -1)
       //     exit(1);
           
       return 0;
   }
   ```

### raise和abort函数

- raise函数
   - 给当前进程发送指定信号（自己给自己发） `raise(signo) == kill(getpid(), signo)`
   - `int raise(int sig);`
      - 成功：0
      - 失败：非0值
- abort函数
   - 给自己发送异常终止信号 6)SIGABRT 信号，终止并产生core文件。
   - `void abort(void);` 该函数无返回

### 软件条件产生信号
- alarm函数
  - 设置定时器（闹钟）。在指定seconds后，内核会给当前进程发送 14)SIGALRM 信号。进程收到该信号，默认动作终止。

  - 每个进程都有且只有一个定时器。

  - `unsigned int alarm(unsigned int seconds);`

    - 返回0或剩余的秒数，无失败。

  - 常用：取消定时器alarm(0)，返回旧闹钟余下秒数。

  - 例：alarm(5) --> 3sec --> alarm(4) --> 5sec --> alarm(5) --> alarm(0)

  - 定时，与进程状态无关（自然定时法）！就绪、运行、挂起（阻塞、暂停）、终止、僵尸……无论进程处于何种状态，alarm都计时。

  - 练习：编写程序，测试你使用的计算机1秒钟能数多少个数。

     ```c
     #include <stdio.h>
     #include <unistd.h>
     
     int main(void)
     {
         int i;
         alarm(1);
         for(i = 0; ; i++)
         {
             printf("%d\n", i);
         }
         return 0;
     }
     ```

  - 使用time命令查看程序执行的时间。程序运行的瓶颈在于IO，优化程序，首选优化IO。

     ```bash
     time ./alarm > out
     ```

  - 实际执行时间 = 系统时间 + 用户时间 + 等待时间


- setitimer函数
  - 设置定时器（闹钟）。可代替alarm函数。精度微秒us，可以实现周期定时。

  - `int setitimer(int which, const struct itimerval *new_value, struct itimerval *old_value);`
    - 返回值
       - 成功：0
       - 失败：-1，设置errno
    - 参数`which`：指定定时方式
       - 1、自然定时：`ITIMER_REAL --> 14)SIGLARM`，计算自然时间。
       - 2、虚拟空间计时（用户空间）：`ITIMER_VIRTUAL --> 26)SIGVTALRM`，只计算进程占用CPU时间。
       - 3、运行时计时（用户+内核）：`ITIMER_PROF --> 27)SIGPROF`，计算占用CPU及执行系统调用的时间。

  - 练习：使用setitimer函数实现alarm函数，重复计算机1秒数数程序。

     ```c
     #include <stdio.h>
     #include <stdlib.h>
     #include <sys/time.h>
     #include <unistd.h>
     
     // struct itimerval {
     //     struct timeval it_interval; /* Interval for periodic timer */
     //     struct timeval it_value;    /* Time until next expiration */
     // };
     
     // struct timeval {
     //     time_t      tv_sec;         /* seconds */
     //     suseconds_t tv_usec;        /* microseconds */
     // };
     
     unsigned int my_alarm(unsigned int sec)
     {
         struct itimerval it, oldit;
         int ret;
     
         it.it_value.tv_sec = sec;
         it.it_value.tv_usec = 0;
         it.it_interval.tv_sec = 0;
         it.it_interval.tv_usec = 0;
     
         ret = setitimer(ITIMER_REAL, &it, &oldit);
         if(ret == -1)
         {
             perror("setitimer");
             exit(1);
         }
         return oldit.it_value.tv_sec;
     }
     
     int main(void)
     {
         int i;
         my_alarm(1);
         for(i = 0; ; i++)
         {
             printf("%d\n", i);
         }
         return 0;
     }
     ```

  - 拓展练习，结合`man page`编写程序，测试it_interval、it_value这两个参数的作用。
    - 提示：
       - it_interval：用来设定两次定时任务之间间隔的时间。
       - it_value：定时的时长。
       - 两个参数都设置为0，即清0操作。

  - 示例​   

      ```c
      #include<stdio.h>
      #include <sys/time.h>
      #include <signal.h>
      
          void myfunc(int signo)
      {
          printf("hello\n");
      }
      
      int main(void)
      {
          struct itimerval it, oldit;
          signal(SIGALRM, myfunc); //注册SIGALRM信号的捕捉处理函数
      
          it.it_value.tv_sec = 5;
          it.it_value.tv_usec = 0;
      
          it.it_interval.tv_sec = 3;
          it.it_interval.tv_usec = 0;
      
          if (setitimer(ITIMER_REAL, &it, &oldit) == -1)
          {
              perror("setitimer error");
              return -1;
          }
      
          while (1)
              ;
          return 0;
      }
      ```

## 信号集的操作函数

- 内核通过读取未决信号集来判断信号是否应被处理。信号屏蔽字mask可以影响未决信号集。而我们可以在应用程序中自定义set来改变mask。已达到屏蔽指定信号的目的。

### 信号集设定

```c
sigset_t set;  //typedef unsigned long sigset_t;
int sigemptyset(sigset_t *set);            //将某个信号集清0 成功：0；失败：-1
int sigfillset(sigset_t *set);            //将某个信号集置1 成功：0；失败：-1
int sigaddset(sigset_t *set, int signum);   //将某个信号加入信号集 成功：0；失败：-1
int sigdelset(sigset_t *set, int signum);   //交某个信号清出信号集 成功：0；失败：-1
int sigismember(const sigset_t *set, int signum);//判断某个信号是否在信号集中 不在：0；在：1；出错：-1
//sigset_t类型的本质是位图。但不应该直接使用位操作，而应用使用上述函数，保证跨系统操作有效。
//对比认知select函数。
```

### sigprocmask函数
- 用来屏蔽信号、解除屏蔽也使用该函数。其本质，读取与修改进程的信号屏蔽字（PCB中）。
- 严格注意，屏蔽信号：只是将信号处理延后执行（延至解除屏蔽）；而忽略表示将信号丢弃处理。
- `int sigprocmask(int how, const sigset_t *set, sigset_t *oldset);`
   - 返回值
      - 成功：0
      - 失败：-1，设置errno
   - 参数
      - set：传入参数，是一个位图，set中哪位置1，就表示当前进程屏蔽哪个信号。
      - oldset：传出参数，保存旧的信号屏蔽集。
      - how参数取值：假设当前的信号屏蔽字为mask
         - SIG_BLOCK：当how设置为此值，set表示需要屏蔽的信号。相当于`mask = mask | set`
         - SIG_UNBLOCK：当how设置为此值，set表示需要解除屏蔽的信号。相当于`mask = mask & ~set`
         - SIG_SETMASK：当how设置为此值，set表示用于替代原始屏蔽集的新屏蔽集。相当于`mask = set`,若调用sigprocmask解除了对当前若干信号的阻塞，则在sigprocmask返回前，至少将其中一个信号递达。

### sigpending函数
- 读取当前进程的未决信号集。
- `int sigpending(sigset_t *set);`
  - 参数set为传出参数。
  - 返回值
     - 成功：0
     - 失败：-1，设置errno
- 练习：编写程序。把所有常规信号的未决状态打印至屏幕。

   ```c
   #include <stdio.h>
   #include <unistd.h>
   #include <signal.h>
   
   void printped(sigset_t *ped)
   {
       int i;
       for(i = 1; i < 32; i++) 
       {
           if(sigismember(ped, i) == 1)
           {
               putchar('1');
           }
           else
           {
               putchar('0');
           }
       }
       printf("\n");
   }
   
   int main(void)
   {
       sigset_t myset, oldset, ped;
   
       sigemptyset($myset);
   
       sigaddset(&myset, SIGQUIT);
       sigaddset(&myset, SIGINT);
       sigaddset(&myset, SIGTSTP);
       sigaddset(&myset, SIGSEGV);
       sigaddset(&myset, SIGKILL); //9,19不能屏蔽，加入也没用
   
       sigprocmask(SIG_BLOCK, &myset, &oldset);
   
       while(1)
       {
           sigpending(&ped);
           printped(&ped);
           sleep(1);
       }
   
       return 0;
   }
   ```



## 信号的捕捉

### signal函数
- 注册一个信号捕捉函数：
- `typedef void (*sighandler_t)(int);`
- `sighandler_t signal(int signum, sighandler_t handler);`
- 该函数由ANSI定义，由于历史原因在不同版本的Unix和不同版本的Linux中可能有不同的行为。因此应该尽量避免使用它，取而代之使用sigaction函数。
- `void (*signal(int signum, void (*sighandler_t)(int)))(int);`
- 能看出这个函数代表什么意思吗？注意多在复杂结构中使用typedef。
- 示例

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <errno.h>
   #include <unistd.h>
   
   typedef void (*sighandler_t)(int);
   
   void catchsigiint(int signo)
   {
       printf("-----SIGINIT-----\N");    
   }
   
   int main(void)
   {
       sighandler_t handler;
   
       handler = signal(SIGINT, catchsigiint);
       if(handler == SIG_ERR)
       {
           perror("signal error");
           exit(1);
       }
   
       while(1);
       return 0;
   }
   ```

### sigaction函数

- 修改信号处理动作（通常在Linux用其来注册一个信号的捕捉函数）
- `int sigaction(int signum, const struct sigaction *act, struct sigaction *oldact);`
  - 返回值
     - 成功：0
     - 失败：-1，设置errno
  - 参数：
     - act：传入参数，新的处理方式。
     - oldact：传出参数，旧的处理方式。
- struct sigaction

   ```c
    struct sigaction {
        void     (sa_handler)(int);
        void     (sa_sigaction)(int, siginfo_t *, void );
        sigset_t   sa_mask;
        int        sa_flags;
        void     (sa_restorer)(void);
    };

    sa_restorer：该元素是过时的，不应该使用，POSIX.1标准将不指定该元素。（弃用）
    sa_sigaction：当sa_flags被指定为SA_SIGINFO标志时，使用该信号处理程序。（很少使用）

    重点掌握：
    1、sa_handler：指定信号捕捉后和处理函数名（即注册函数）。也可赋值为SIG_IGN表忽略或SIG_DFL表执行默认动作。
    2、sa_mask：调用信号处理函数时，所要屏蔽的信号集（信号屏蔽字）。注意：仅在修理函数被调用期间屏蔽生效，是临时性设置。
    3、sa_flags：通常设置为0，表使用默认属性。
   ```

- 示例

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <siganl.h>
   #include <unistd.h>
   
   void docatch(int signo)
   {
       printf("%d signal is catched\n", signo);
   }
   
   int main(void)
   {
       int ret;
       struct sigaction act;
   
       act.sa_handler = docatch;
       sigemptyset(&act.sa_mask);
       sigaddset(&act.sa_mask, SIGQUIT);
       act.sa_flags = 0; //默认属性。信号捕捉函数执行期间，自动屏蔽本信号
   
       ret = sigaction(SIGINT, &act, NULL);
       if(ret < 0)
       {
           perror("sigaction error");
           exit(1);
       }
   
       while(1);
       return 0;
   }
   ```

- 信号捕捉特性
  - 进程正常运行时，默认PCB中有一个信号屏蔽字，假定为☆，它决定了进程自动屏蔽哪些信号。当注册了某个信号捕捉函数，捕捉到该信号以后，要调用函数。而该函数有可能执行很长时间，在这期间所屏蔽的信号不由☆来指定。而是用sa_mask来指定。调用完信号处理函数，再恢复为☆。
  - xxx信号捕捉函数执行期间，xxx信号自动被屏蔽。
  - 阻塞的常规信号不支持排队，产生多次只记录一次。（后32个实时信号支持排队）
  - 练习1：为某个信号设置捕捉函数
  - 练习2：验证在信号处理函数执行期间，该信号多次递达，那么只在处理函数之行结束后，处理一次。
  - 练习3：验证sa_mask在捕捉函数执行期间的屏蔽作用。

### 内核实现信号捕捉过程
![内核实现信号捕捉过程](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e5%86%85%e6%a0%b8%e5%ae%9e%e7%8e%b0%e4%bf%a1%e5%8f%b7%e6%8d%95%e6%8d%89%e8%bf%87%e7%a8%8b.png)

## 竞态条件（时序竞态）
### pause函数
- 调用该函数可以造成进程主动挂起，等待信号唤醒。调用该系统调用的进程将处于阻塞状态（主动放弃CPU）直到有信号递达将其唤醒。
- `int pause(void);`，返回值：-1，并设置errno为EINTR。
- 返回值
  - ① 如果信号的默认处理是终止进程，则进程终止，pause函数没有机会返回。
  - ② 如果信号的默认处理动作是忽略，进程继续处于挂起状态，pause函数不返回。
  - ③ 如果信号的处理动作是捕捉，则【调用完信号处理函数之后，pause返回-1】，errno设置为EINTR，表示“被信号中断”。想想我们还有哪个函数只有出错返回值。
  - ④ pause收到的信号不能被屏蔽，如果被屏蔽，那么pause就不能被唤醒。
- 练习，使用pause和alarm来实现sleep函数。
  - 注意，unslept = alarm(0)的用法。
  - 例如：睡觉，alarm(10)闹铃。
  - 正常：10后闹铃将我唤醒，这时额外设置alarm(0)取消闹铃，不会出错。
  - 异常：5分钟，被其他事物唤醒，alarm(0)取消闹铃防止打扰。
  - 实现示例：

     ```c
     #include <stdio.h>
     #include <stdlib.h>
     #include <unistd.h>
     #include <signal.h>
     #include <errno.h>
     
     void catch_signalrm(int signo)
     {
         printf("%d signal is catched.", signo);
     }
     
     unsigned int mysleep(unsigned int seconds)
     {
         int ret;f
         struct sigaction act, oldact;
         act.sa_handler = catch_signalrm;
         sigemptyset(&act.sa_mask);
         act.sa_flags = 0;
     
         ret = sigaction(SIGALRLM, &act, &oldact);
         if(ret == -1)
         {
             perror("sigaction error");
             exit(1);
         }
     
         alarm(seconds);
         ret = pause(); // 主动挂起，等信号
         if(ret == -1 && errno == EINTR)
         {
             printf("pause sucess\n");
         }
     
         ret = alarm(0); //闹铃清零
         sigaction(SIGALRM, &oldact, NULL); //恢复SIGALRM信号旧有的处理方式。
         return ret;
     }
     
     int main(void)
     {
         while(1)
         {
             mysleep(3);
             printf("-------------------\n");
         }
         return 0;
     }
     ```

### 时序竞态

- 前导例
  - 设想如下场景：
     - 欲睡觉，定闹钟10分钟，希望10分钟后闹铃将自己唤醒。
     - 正常：定时，睡觉，10分钟后被闹钟唤醒。
     - 异常：闹钟定好后，被唤走，外出劳动，20分钟后劳动结束。回来继续睡觉计划，但劳动期间闹钟已经响过，不会再将我唤醒。

- 时序问题分析
  - 回顾，借助pause和alarm实现的mysleep函数。设想如下时序：
  - 1、注册SIGALRM信号处理函数(sigaction...)
  - 2、调用alarm(1)函数设定闹钟1秒。
  - 3、函数调用刚结束，开始倒计时1秒。当前进程失去CPU，内核调度优先级高的进程（有多个）取代当前进程。当前进程无法获得CPU，进入就绪等待CPU。
  - 4、1秒后，闹钟超时，内核向当前进程发送SIGALRM信号（自然定时法，与进程状态无关），高优先级进程尚未执行完，当前进程仍处于就绪态，信号无法处理（未决）。
  - 5、优先级高的进程执行完，当前进程获得CPU资源，内核调度回当前进程执行。SIGALRM信号递达，信号设置捕捉，执行处理函数sig_alarm。
  - 6、信号处理函数执行结束，返回当前进程主控流程，pause()被调用挂起等待。（欲等待alarm函数发送的SIGALRM信号将自己唤醒）。
  - 7、SIGALRM信号已经处理完毕，pause不会等到。

- 解决时序问题
  - 可以通过设置屏蔽SIGALRM的方法来控制程序执行逻辑，但无论如何设置，程序都有可能在“解除信号屏蔽”与”挂起等待信号“这两个操作间隙失去CPU资源。除非将这两步骤合并成一个”原子操作“。sigsuspend函数具备这个功能。在对时序要求严格的场合下都应该使用sigsuspend替换pause。
  - `int sigsuspend(const sigset_t *mask);`,挂起等待信号。
  - sigsuspend函数调用期间，进程信号屏蔽字由其参数mask指定。
  - 可将某个信号（如SIGALRM）从临时信号屏蔽字mask中删除，这样在调用sigsuspend时将解除对该信号的屏蔽，然后挂起等待，当sigsuspend返回时，进程的信号屏蔽字恢复为原来的值。如果原来对该信号是屏蔽态，sigsuspend函数返回后仍然屏蔽该信号。
  - 改进版mysleep

     ```c
     #include <stdio.h>
     #include <stdlib.h>
     #include <unistd.h>
     #include <signal.h>
     #include <errno.h>
     
     void sig_alrm(int signo)
     {
         printf("%d signal is catched.", signo);
     }
     
     unsigned int mysleep(unsigned int seconds)
     {
         int ret;f
         struct sigaction newact, oldact;
         sigset_t newmask, oldmask, suspmask;
     
         //1、为SIGALRM设置捕捉函数，一个空函数
         newact.sa_handler = sig_alrm;
         sigemptyset(&newact.sa_mask);
         newact.sa_flags = 0;
         sigaction(SIGALRM, &newact, &oldact);
     
         //2、设置阻塞信号集，阻塞SIGALRM信号
         sigemptyset(&newmask);
         sigaddset(&newmask, SIGALRM);
         sigprocmask(SIG_BLOCK, &newmask, &oldmask);
     
         //3、定时n秒，到时后可以产生SIGALRM信号
         alarm(seconds);
     
         //4、构造一个调用sigsuspend临时有效的阻塞信号集，在临时阻塞信号集里解除SIGALRM的阻塞
         suspmask = oldmask;
         sigdelset(&suspmask, SIGALRM);
     
         //5、sigsuspend调用期间，采用临时阻塞信号集suspmask替换原有阻塞信号集
         //这个信号集中不包含SIGALR信号，同时挂起等待
         //当sigsuspend被信号唤醒返回时，恢复原有的阻塞信号集
         sigsuspend(&suspmasks);
     
         unslept = alarm(0);
         //6、恢复SIGALRM原有的处理动作
         sigaction(SIGALRM, &oldact, NULL);
         //7、解除对SIGALRM的阻塞
         sigprocmask(SIG_SETMASK, &oldmask, NULL);
         return (unslept);
     }
     
     int main(void)
     {
         while(1)
         {
             mysleep(3);
             printf("-------------------\n");
         }
         return 0;
     }
     ```

- 总结
  - 竞态条件，跟系统负载有很紧密的关系，体现出信号的不可靠性。系统负载越严重，信号不可靠性越强。
  - 不可靠由其实现原理所致。信号是通过软件方式实现（跟内核调度高度依赖，延时性强），每次系统调用结束后，或中断处理结束后，需通过扫描PCB中的未决信号集，来判断是否应处理某个信号。当系统负载过重时，会出现时序混乱。
  - 这种意外情况只能在编写程序过程中，提早预见，主动规避，而无法通过gdb程序调试等其他手段弥补。且由于该错误不具规律性，后期捕捉和重现十分困难。

### 全局变量异步I/O
- 分析如下父子进程交替的数数程序。当捕捉函数里面的sleep取消，程序即会出现问题。请分析原因。

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <signal.h>
   
   int n = 0; flag = 0;
   
   void sys_err(char *str)
   {
       perror(str);
       exit(1);
   }
   
   void do_sig_child(int num)
   {
       printf("I am child %d\t%d\n", getpid(), n);
       n+=2;
       flag = 1;
       //sleep(1);
   }
   
   void do_sig_parent(int num) 
   {
       printf("I am parent %d\t%d\n", getpid(), n);
       n+=2;
       flag = 1;//数数完成
       //sleep(1);
   }
   
   int main(void)
   {
       pid_t pid;
       struct sigaction act;
   
       if((pid = fork()) < 0)
       {
           sys_err("fork");
       }
       else if(pid > 0 )
       {
           n = 1;
           sleep(1);
           act.sa_handler = do_sig_parent;
           sigemptyset(&act.sa_mask);
           act.sa_flags = 0;
           sigaction(SIGUSR2, &act, NULL); //注册自己的信号捕捉函数
   
           do_sig_parent(0);
   
           while(1)
           {
               // wait for signal
               if(flag == 1)//父进程数数完成
               {
                   kill(pid, SIGUSR1);
                   flag = 0;//标志已经给子进程发送完信号
               }
           }
       }
       else if(pid == 0)
       {
           n = 2;
           act.sa_handler = do_sig_child;
           sigemptyset(&act.sa_mask);
           act.sa_flags = 0;
           sigaction(SIGUSR1, &act, NULL);//父进程数数完成发送SIGUSR1给子进程。
   
           while(1)
           {
               // wait for signal
               if(flag == 1)
               {
                   kill(getppid(), SIGUSR2);
                   flag = 0;
               }
           }
       }
   }
   ```

- 示例中，通过flag变量标记程序实行进度。flag置1表示数数完成，flag置0表示给对方发送信号完成。

- 问题出现的位置，在父子进程kill函数之后需要紧接着调用flag，将其置0，标记信号已经发送。但在这期间很有可能被kernel调度，失去执行权利，而对方获取了执行时间，通过发送信号回调捕捉函数，从而修改了全局的flag。

- 如何解决该问题呢？可以使用后续课程讲到的“锁”机制。当操作全局变量的时候，通过加锁、解锁来解决该问题。

- 现阶段，我们在编程期间如若使用全局变量，应在主观上注意**全局变量的异步IO**可能造成的问题。

### 可/不可重入函数
- 一个函数在调用执行期间（尚未调用结束），由于某种时序又被重复调用，称之为“重入”。根据函数实现的方法可分为“可重入函数”和“不可重入函数”两种。看如下时序。
![不可重入函数](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e4%b8%8d%e5%8f%af%e9%87%8d%e5%85%a5%e5%87%bd%e6%95%b0.png)
- 显示，insert函数是不可重入函数，重入调用，会导致意外结果呈现。究其原因，是该函数内部实现使用了全局变量。

- 注意事项
   - 1、定义可重入函数，函数内不能含有全局变量及static变量，不能使用malloc、free。
   - 2、信号捕捉函数应设计为可重入函数。
   - 3、信号处理程序可以调用的可重入函数可参阅man 7 signal。
   - 4、没有包含在上述列表中的函数大多是不可重入的，其原因为：
      - 使用静态数据结构
      - 调用了malloc和free
      - 是标准I/O函数

## SIGCHLD信号
### SIGCHLD的产生条件
- 子进程终止时
- 子进程接收到SIGSTOP信号停止时
- 子进程处在停止态，接受到SIGCONT后唤醒时

### 借助SIGCHLD信号回收子进程
- 子进程结束运行，其父进程会收到SIGCHLD信号。该信号的默认处理动作是忽略。可以捕捉该信号，在捕捉函数中完成子进程状态的回收。

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <errno.h>
   #include <sys/types.h>
   #include <sys/wait.h>
   #include <signal.h>
      
   void sys_err(str)
   {
       perror(str);
       exit(1);
   }
   
   void do_sig_child(int signo)
   {
       int status;
       pid_t pid;
   
       while((pid = waitpid(0, &status, WNOHANG)) > 0){
           if(WIFEXITED(status))
               printf("-----------child %d exit %d \n", pid, WEXITSTATUS(status));
           else if(WIFSIGNALED(status))
               printf("child %d cancel signal %d \n", pid, WTERMSIG(status));
       }
   }
   
   int main(void)
   {
       pid_t pid;
       int i;
       //阻塞SIGCHLD
       for(i = 0; i < 10; i++){
           if((pid = fork()) == 0)
               break;
           else if(pid < 0)
               sys_err("fork");
       }
   
       if(pid == 0){   //10个子进程
           int n = 1;
           while(n--){
               printf("child ID %d \n", getpid());
               sleep(1);
           }
           return i+1;
       }else if(pid > 0){
           //SIGCHLD阻塞
           struct sigaction act;
   
           act.sa_handler = do_sig_child;
           sigemptyset(&act.sa_mask);
           act.sa_flags = 0;
           sigaction(SIGCHLD, &act, NULL);
           //解除对SIGCHLD的阻塞
   
           while(1){
               printf("Parent ID %d \n", getpid());
               sleep(1);
           }
       }
   
       return 0;
   }
   ```

- 分析该例子。结合 17)SIGCHLD信号默认动作，掌握不使用捕捉函数回收子进程的方式。
- 如果每创建一个子进程后不使用sleep可以吗？可不可以将程序中捕捉函数内部的while替换为if？为什么？
- 思考：信号不支持排队，当正在执行SIGCHLD捕捉函数时，再过来一个或多个SIGCHLD信号怎么办？

### 子进程结束status处理方式

- `pid_t waitpid(pid_t pid, int *status, int options)`
   - options
      - WNOHANG
         - 没有子进程结束，立即返回。
      - WUNTRACED
         - 子进程已经停止，立即返回（但不是通过调用ptrace函数调用）。即使没有指定此选项，也将提供已停止的子进程的状态。
      - WCONTINUED
         - 一个已停止的子进程被SIGCONT信号递达恢复，立即返回。

### SIGCHLD信号注意问题



## 信号传参
### 发送信号传参
- sigqueue函数对应kill函数，但可在向指定进程发送信号的同时携带参数

   ```c
   int sigqueue(pid_t pid, int sig, const union sigval value);
      成功：0
      失败：-1，设置errno
   
   union sigval{
      int sival_int;
      void *sival_ptr;
   }
   ```

- 向指定进程发送指定信号的同时，携带数据。但，如传地址，需注意，不同进程之间虚拟地址空间各自独立，将当前进程地址传递给另一进程没有实际意义。

### 捕捉信号传参

```c
int sigaction(int signum, const struct sigaction *act, struct sigaction *oldact);
struct sigaction {
   void     (*sa_handler)(int);
   void     (*sa_sigaction)(int, siginfo_t *, void *);
   sigset_t   sa_mask;
   int        sa_flags;
   void     (*sa_restorer)(void);
};
```

- 当注册信号捕捉函数，希望获取更多信号相关信息，不应使用sa_handler而应该使用sa_sigaction。但此时的sa_flags必须指定为SA_SIGINFO。siginfo_t是一个成员十分丰富的结构体类型，可以携带各种与信号相关的数据。

## 中断系统调用
- 系统调用可分为两类：慢速系统调用和其他系统调用。
   - 1、慢速系统调用：可能会使进程永远阻塞的一类。如果在阻塞期间收到一个信号，该系统调用就被中断，不再继续执行（早期）；也可以设定系统调用是否重启。如：read、write、pause、wait...
   - 2、其他系统调用：getpid、getppid、fork...
- 结合pause,回顾慢速系统调用：
   - 慢速系统调用被中断的相关行为，实际上就是pause的行为：如：read
      - 1、想中断pause，信号不能被屏蔽。
      - 2、信号的处理方式必须是捕捉（默认、忽略都不可以）。
      - 3、中断后返回-1，设置errno为EINTR（表示“被信号中断”）。
- 可修改sa_flags参数来设置被信号中断后系统调用是否重启。SA_INTERRURT不重启。SA_RESTART重启。
- 扩展了解：sa_flagsf还有很多可选参数，适用于不同情况。如：捕捉到信号后，在执行捕捉函数期间，不希望自动阻塞该信号，可将sa_flags设置为SA_NODEFER，除非sa_mask中包含该信号。

## 终端
- 在Unix系统中，用户通过终端登录系统后得到一个Shell进程，这个终端成为Shell进程的控制终端（Controlling Terminal），进程中，控制终端是保存在PCB中的信息，而fork会复制PCB中的信息，因此由Shell进程启动的其它进程的控制终端也是这个终端。默认情况下（没有重定向），每个进程的标准输入、标准输出和标准错误输出都指向控制终端，进程从标准输入读也就是读用户的键盘输入，进程往标准输出或标准错误输出写也就是输出到显示器上。信号中还进过，在控制终端输入一些特殊的控制键可以给前台进程发信号，例如ctrl+c表示SIGINT,ctrl+\表示SIGQUIT。
- Alt+Ctrl+[F1-F6]，字符终端，pts(pseudo terminal slave)指伪终端。
- Alt+F7，图形终端。
- SSH、Telnet...，网络终端。
### 终端的启动流程
- 文件与I/O中讲过，每个进程都可以通过一个特殊的设备文件/dev/tty访问它的控制终端。事实上每个终端设备都对应一个不同的设备文件，/dev/tty提供了一个通用的接口，一个进程要访问它的控制终端既可以通过/dev/tty，也可以通过该终端设备所对应的设备文件来访问。ttyname函数可以由文件夹描述符查出对应的文件名，该文件描述符必须指向一个终端设备而不能是任意文件。
- 简单来说，一个Linux系统启动，大致经历如下步骤：

      init --> fork --> exec --> getty --> 用户输入帐号 --> login --> 输入密码 --> exec --> bash

- 硬件驱动程序负责读写实际的硬件设备，比如从键盘读入字符和把字符输出到显示器，线路规程像一个过滤器，对于某些特殊字符并不是让它直接通过，而是做特殊处理，比如在键盘上按下ctrl+z，对应的字符并不会被用户程序的read读到，而是被线程规程截获，解释成SIGTSTP信号发给前台进程，通常会使该进程停止。线路规程应该过滤哪些字符和做哪些特殊处理是可以配置的。

![终端设备模块](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e7%bb%88%e7%ab%af%e8%ae%be%e5%a4%87%e6%a8%a1%e5%9d%97.png)

- line disciline：线路规程，用来过滤键盘输入的内容。

### ttyname函数
- 由文件描述符查出对应的文件名

- `char *ttyname(int fd);`

  - 成功：终端名
  - 失败：NULL，设置errno

- 下面我们借助ttyname函数，通过实验看一下各种不同的终端所对应的设备文件名。

    ```c
    #include<unistd.h>
    #include <stdio.h>
    
    int main(void)
    {
        printf("fd 0: %s\n", ttyname(0));
        printf("fd 1: %s\n", ttyname(1));
        printf("fd 2: %s\n", ttyname(2));
        return 0;
    }
    ```


### 网络终端

- 虚拟终端或串口终端的数目是有限的，虚拟终端（字符控制终端）一般就是/dev/tty1~/dev/tty6六个，串口终端的数目也不超过串口的数目。然而网络终端或图形窗口的数目却是不受限制的，这是通过伪终端（Pseudo TTY）实现的。一套伪终端由一个主设备（PTY Master）和一个从设备（PTY Slave）组成。主设备在概念上相当于键盘和显示器，只不过它不是真正的硬件而是一个内核模块，操作它的也不是用户而是另一个进程。从设备和上面介绍的/dev/tty1这样的终端设备模块类似，只不过它的底层驱动程序不是访问硬件而是访问主设备。网络终端或图形终端的Shell进程以及它启动的其它进程，都会认为自己的控制终端是伪终端从设备，例如/dev/pts/0、/dev/pts/1等。下面以telnet为例说明网络登录和使用伪终端的过程。

![网络终端](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e7%bd%91%e7%bb%9c%e7%bb%88%e7%ab%af.png)

- TCP/IP协议栈：在数据包上添加报头。
- 如果telnet客户端和服务器之间的网络延迟较大，我们会观察到按下一个键之后要过几分钟才能回显到屏幕上。这说明我们每按一个键telnet客户端都会立刻把该字符发送给服务器，然后这个字符经过伪终端主设备和从设备之后被Shell进程读取，同时回显到伪终端从设备，回显的字符再经过伪终端主设备、telnet服务器和网络发回给telnet客户端，显示给用户看。也许你会觉得吃惊，但真的是这样：每按一个键都要在网络上走个来回。

## 进程组
### 概念和特性
- 进程组，也称之为作业。BSD于1980年前后向Unix中增加的一个新特性。代表一个或多个进程的集合。每个进程都属于一个进程组。在waitpid函数和kill函数的参数中都曾使用到。操作系统设计的进程组的概念，是为了简化对多个进程的管理。
- 当父进程，创建子进程的时候，默认子进程与父进程属于同一进程组。进程组ID==第一个进程ID（组长进程）。所以，组长进程标识：其进程组ID==其进程ID。
- 可以使用`kill -SIGKILL -进程组ID（负的）`来将整个进程组内的进程全部杀死。
- 组长进程可以创建一个进程组，创建该进程组中的进程，然后终止。只要进程组中有一个进程存在，进程组就存在，与组长进程是否终止无关。
- 进程组生存期：进程组创建到最后一个进程离开（终止或转移到另一个进程组）。
- 一个进程可以为自己或子进程设置进程组ID。

### 进程组操作函数
- getpgrp函数
  - 获取当前进程的进程组ID
  - `pid_t getpgrp(void); `
     - 总是返回调用者的进程组ID。

- getpgid函数
  - 获取指定进程的进程组ID
  - `pid_t getpgid(pid_t pid);`
     - 成功：0
     - 失败：-1，设置errno
  - 如果pid = 0,那么该函数作用和getpgrp一样。
  - 练习：查看进程对应的进程组ID

- setpgid函数
  - 改变进程默认所属的进程组。通常可用来加入一个现有的进程组或创建一个新进程组。
  - `int setpgid(pid_t pid, pid_t pgid);`
     - 成功：0
     - 失败：-1，设置errno
  - 将参1对应的进程，加入参2对应的进程组中。
  - 注意
     - 1、如改变进程为新的组，应fork后，exec前。
     - 2、权级问题。非root进程只能改变自己创建的子进程，或有权限操作的进程。
  - 练习：修改子进程的进程组ID

- 示例​   

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   
   int main(void)
   {
       pid_t pid;
       if((pid = fork()) < 0){ 
           perror("fork");
           exit(1);
       }else if(pid == 0){ 
           printf("child PID == %d\n", getpid());
           printf("child Group ID == %d\n", getpgid(0)); //返回组ID
           //printf("child Group ID == %d\n", getpgrp()); //返回组ID
           sleep(7);
           printf("----Group ID of child is changed to %d\n", getpgid(0));
           exit(0);
       }else if(pid > 0){ 
           sleep(1);
           setpgid(pid, pid);//让子进程自立门户，成为进程组组长，以它的pid为进程组id
   
           sleep(13);
           printf("\n");
           printf("parent PID == %d\n", getpid());
           printf("parent's parent process PID == %d\n", getppid());
           printf("parent Group ID == %d\n", getpgid(0));
   
           sleep(5);
           setpgid(getpid(), getppid());//改变父进程的组ID为父进程的父进程
           printf("\n -----Group ID of parent is changed to %d \n", getpgid(0));
   
           while(1);
       }   
       return 0;
   }
   ```



## 会话

### 创建会话
- 创建一个会话需要注意以下6点注意事项：
   - 1、调用进程不能是进程组组长，该进程变成新会话首进程（session header）。
   - 2、该进程成为一个新进程组的组长进程。
   - 3、需有root权限（ubuntu不需要）。
   - 4、新会话丢弃原有的控制终端，该会话没有控制终端。
   - 5、该调用进程是组长进程，则出错返回。
   - 6、建立新会话时，先调用fork，父进程终止，子进程调用setsid

### getsid函数
- 获取进程所属的会话ID。
- `pid_t getsid(pid_t pid);`
   - 成功：返回调用进程的会话ID
   - 失败：-1，设置errno
   - pid为0表示察看当前进程session ID。
- ps ajx命令查看系统中的进程。参数a表示不仅当前用户的进程，也列出所有其他用户的进程，参数x表示不仅列出有控制终端的进程，也列出所有无控制终端的进程，参数j表示列出与作业控制相关的信息。
- 组长进程不能成为新会话首进程，新会话首进程必定会成为组长进程。

### setsid函数
- 创建一个会话，并以自己的ID设置进程组ID，同时也是新会话的ID。

- `pid_t setsid(void);`
  - 成功：返回调用进程的会话ID
  - 失败：-1，设置errno

- 练习：fork一个子进程，并使其创建一个新会话。查看进程组ID、会话ID前后变化。

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   
   int main(void)
   {
       pid_t pid;
   
       if((pid = fork()) < 0){ 
           perror("fork error");
           exit(1);
       } else if(pid == 0){ 
           printf("child process PID is %d\n", getpid());
           printf("Group ID of child is %d\n", getpgid(0));
           printf("Session ID of child is %d\n", getsid(0));
   
           sleep(0);
           setsid();//子进程非组长进程，故其成为新会话首进程，且成为组长进程。该进程组ID即为会话进程
   
           printf("Changed:\n");
   
           printf("child process PID is %d\n", getpid());
           printf("Group ID of child is %d\n", getpgid(0));
           printf("Session ID of child is %d\n", getsid(0));
   
           sleep(20);
   
           exit(0);
       }   
   
       return 0;
   }
   ```



## 守护进程

- Daemon（精灵）进程，是Linux中的后台服务进程，通常独立于控制终端并且周期性地执行某种任务或等待处理某些发生的事件。一般采用以d结尾的名字。
- Linux后台的一些系统服务进程，没有控制终端，不能直接和用户交互。不受用户登录、注销的影响，一直在运行着，他们都是守护进程。如：预读入缓输出机制的实现；ftp服务器；nfs服务器等。
- 创建守护进程，最关键的一步是调用setsid函数创建一个新的Session，并成为Session Leader。

### 创建守护进程模型
- 1、创建子进程，父进程退出。所有工作在子进程中进行，形式上脱离了控制终端。
- 2、在子进程中创建新会话。setsid函数，使子进程完全独立出来，脱离控制。
- 3、改变当前目录为根目录。chdir函数，防止占用可卸载的文件系统，也可以换成其他路径。
- 4、重设文件权限掩码。umask函数，防止继承的文件创建屏蔽字拒绝某些权限，增加守护进程灵活性。
- 5、关闭文件描述符。继承的打开文件不会用到，浪费系统资源，无法卸载。
- 6、开始执行守护进程核心工作。
- 7、守护进程退出处理程序模型。
- 示例

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <sys/types.h>
   #include <sys/stat.h>
   #include <fcntl.h>
   
   int main(void)
   {
       pid_t pid, sid;
       int ret;
   
       pid = fork();
       if(pid > 0)
       {   
           exit(1);
       }   
   
       sid = setsid();
   
       ret = chdir("/home/super/");
       if(ret == -1) 
       {   
           perror("chdir error");
           exit(1);
       }   
   
       umask(0022);
   
       close(STDIN_FILENO);
       open("/dev/null", O_RDWR);
       dup2(0, STDOUT_FILENO);
       dup2(0, STDERR_FILENO);
   
       while(1);
   
       return 0;
   }
   ```
