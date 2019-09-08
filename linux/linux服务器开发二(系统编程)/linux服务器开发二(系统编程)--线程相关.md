[TOC]

## 线程概念

### 什么是线程

- LWP：Light Weight Process，轻量级的进程，本质仍是进程（在Linux环境下）。
- 进程：独立地址空间，拥有PCB。
- 线程：也有PCB，但没有独立的地址空间（共享）。
- 进程与线程的区别：在于是否共享地址空间。
	- 独居（进程）。
	- 合租（线程）。
- Linux下：
	- 线程：最小的执行单位。
	- 进程：最小分配资源单位，可看成是一个线程的进程。

![线程](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e7%ba%bf%e7%a8%8b.png)

- 安装man文档

   ```bash
   sudo apt-get install glibc-doc
   sudo apt-get install manpages-posix-dev
   ```

### Linux内核线程实现原理
- 类Unix系统中，早期是没有“线程”概念的，80年代才引入，借助进程机制实现出了线程的概念。因此在这类系统中，进程和线程关系密切。
- 1、轻量级进程（light-weight process），也有PCB，创建线程使用的底层函数和进程一样，都是clone。
- 2、从内核里看进程和线程是一样的，都有各自不同的PCB，但是PCB中指向内存资源的三级页表是相同的。
- 3、进程可以蜕变成线程。
- 4、线程可看做寄存器和栈的集合。
- 5、在Linux下，线程是最小的执行单位；进程是最小的分配资源单位。
- 察看LWP号：`ps -Lf pid`，查看指定线程的LWP号。

![三级映射](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e4%b8%89%e7%ba%a7%e6%98%a0%e5%b0%84.png)

- 三级映射：进程PCB --> 页目录（可看成数组，首地址位于PCB中） --> 页表 --> 物理页面 --> 内存单元
	- 参考《Linux内核源代码情景分析》 -- 毛德操

![进程与线程](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e8%bf%9b%e7%a8%8b%e4%b8%8e%e7%ba%bf%e7%a8%8b.png)

- 对于进程来说，相同的地址（同一个虚拟址）在不同的进程中，反复使用而不冲突。原因是他们虽虚拟址一样，但页目录、页表、物理页面各不相同。相同的虚拟址，映射到不同的物理页面内存单元，最终访问不同的物理页面。
- 但线程不同！两个线程具有各自独立的PCB，但共享同一个页目录，也就共享同一个页表和物理页面。所以两个PCB共享一个地址空间。
- 实际上，无论是创建的fork，还是创建线程的pthread_create，底层实现都是调用同一个内核函数clone。
- 如果复制对方的地址空间，那么就产生一个“进程”；如果共享对方的地址空间，就产生一个“线程”。
- 因此：Linux内核是不区分进程和线程的。只有用户层面上进行区分。所以，线程所有操作函数pthread_*是库函数，而非系统调用。

### 线程共享资源
- 1、文件描述符表
- 2、每种信号的处理方式。
- 3、当前工作目录。
- 4、用户ID和组ID。
- 5、内存地址空间（.text/.data/.bss/heap/共享库）

### 线程非共享资源
- 1、线程ID。
- 2、处理器现场和栈指针。
- 3、独立的栈空间（用户空间栈）。
- 4、errno变量.
- 5、信号屏蔽字。
- 6、调度优先级。

### 线程优点、缺点
- 优点
	- 1、提高程序并发性。
	- 2、开销小。
	- 3、数据通信、共享数据方便。
- 缺点
	- 1、库函数，不稳定。
	- 2、调试、编写困难、gdb不支持。
	- 3、对信号支持不好。
- 优点相对突出，缺点均不是硬伤。Linux下由于实现方法导致进程、线程差别不是很大。



## 线程控制原语

### pthread_self函数
- 获取线程ID。其作用对应进程中getpid()函数。
- `pthread_t pthread_self(void);` - 返回值：成功：0；失败：无！
- 线程ID：pthread_t类型，本质：在Linux下为无符号整数（%lu），其他系统中可能是结构体实现。
- 线程ID是进程内部，识别标志。（两个进程间，线程ID允许相同）。
- 注意：不应使用全局变量pthread_t tid，在子线程中通过pthread_create传出参数来获取线程ID，而应使用pthread_self。

### pthread_create函数
- 创建一个新线程。其作用，对应进程中fork()函数。
- `int pthread_create(pthread_t *thread, const pthread_attr_t *attr, void *(*start_routine) (void *), void *arg);`
- 返回值：成功：0；失败：错误号。Linux环境下，所有线程特点，失败均直接返回错误号。
- 参数
  - pthread_t：当前Linux中可理解为：`typedef unsigned long int pthread_t;`
  - 参数1：传出参数，保存系统为我们分配好的线程ID。
  - 参数2：通常传NULL，表示使用线程默认属性。若想使用具体属性也可以修改该参数。
  - 参数3：函数指针，指向线程主函数（线程体），该函数运行结束，则线程结束。
  - 参数4：线程主函数执行期间所使用的参数。
- 在一个线程中调用pthread_create()创建新的线程后，当前线程从pthread_create()返回继续往下执行，而新的线程所执行的代码由我们传给pthread_create的函数指针start_routine决定。start_routine函数接收一个参数，是通过pthread_create的arg参数传递给它的，该参数的类型为void *，这个指针按什么类型解释由调用者自己定义。start_routine返回时，这个线程就退出了，其它线程可以调用pthread_join得到start_routine的返回值，类似于父进程调用wait(2)得到子进程的退出状态，稍后详细介绍pthread_join。
- pthread_create成功返回后，新创建的线程ID被填写到thread参数指向的内存单元。我们知道进程ID的类型是pid_t，每个进程的ID在整个系统中是唯一的，调用getpid(2)可以获得当前进程ID，是一个正整数值。线程ID的类型是thread_t，它只是当前进程中保证是唯一的，不同的系统中thread_t这个类型有不同的实现，这可能是一个整数值，也可能是一个结构体，也可能是一个地址，所以不能简单地当成整数用printf打印，调用pthread_self(3)可以获得当前线程的ID。
- attr参数表示线程属性，本节不深入讨论线程属性，所有代码例子都传NULL给attr参数，表示线程属性取缺省值，感兴趣的读者可以参考APUE。
- 【练习】：创建一个新线程，打印线程ID。注意：链接线程库-lpthread

  - 由于pthread_create的错误码不保存在errno中，因此不能直接用perror(3)打印错误信息，可以先用strerror(3)把错误码转换成错误信息再打印。如果任意一个线程调用了exit或_exit，则整个进程的所有线程都会终止，由于从main函数return也相当于调用exit，为了防止新创建的线程还没有得到执行就终止，我们在main函数return之前延时1秒，这只是一种权宜之计，即使主线程等待1秒，内核也不一定会调度新创建的线程执行，下一节我们会看到更好的方法。

- 示例

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <pthread.h>
   #include <string.h>  
   
   void *thread_func(void *arg)
   {
       printf("In thread: thread id = %lu, pid = %u\n", pthread_self(), getpid());
       return NULL;
   }
   
   int main()
   {
       pthread_t tid;
       int ret;
   
       printf("In main1: thread id = %lu, pid = %u\n", pthread_self(), getpid());
   
       ret = pthread_create(&tid, NULL, thread_func, NULL);
       if(ret != 0){
           fprintf(stderr, "pthread_create error:%s\n", strerror(ret));
           exit(1);
       } 
   
       sleep(1);
       printf("In main2: thread id = %lu, pid = %u\n", pthread_self(), getpid());
       return 0;
   }
   ```

- 【练习】：循环创建多个线程，每个线程打印自己是第几个被创建的线程。（类似于进程循环创建子进程）
- 拓展思考：将pthread_create函数参数4修改为`(void *)&i`，将线程主函数内改为`i = *((int *)arg)`是否可以？不可以。
- 示例	

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <pthread.h>
   #include <string.h>
   	
   void *thread_func(void *arg)
   {
       int i = (int)arg;
       sleep(i);
       printf("%dth thread: thread id = %lu, pid = %u\n", i+1, pthread_self(), getpid());
       return NULL;
   }
   
   int main()
   {
       pthread_t tid;
       int ret, i;
   
       for (i = 0; i<5; i++){
           ret = pthread_create(&tid, NULL, thread_func, (void *)i);
           if(ret != 0){ 
               fprintf(stderr, "pthread_create error:%s\n", strerror(ret));
               exit(1);        }   
       }   
   
       sleep(i);
       return 0;
   }
   ```

- 线程与共享
  - 线程间共享全局变量
  - 【牢记】：线程默认共享数据段、代码段等地址空间，常用的是全局变量。而进程不共享全局变量，只能借助mmap。
  - 【练习】：设计程序，验证线程之间共享全局数据。	

     ```c
     #include <stdio.h>
     #include <pthread.h>
     #include <stdlib.h>
     #include <unistd.h>
     
     int var = 100;
     
     void *tfn(void *arg)
     {
         var = 200;
         printf("thread\n");
         return NULL;
     }
     
     int main(void)
     {
         printf("At first var = %d\n", var);
     
         pthread_t tid;
         pthread_create(&tid, NULL, tfn, NULL);
         sleep(1);
     
         printf("After pthread_create, var = %d\n", var);                                                  
         return 0;
     }
     ```

### pthread_exit函数

- 将单个线程退出。
- `void pthread_exit(void *retval);`

  - 参数：retval表示线程退出状态，通常传NULL。
- 思考：使用exit将指定线程退出，可以吗？
- 结论：线程中，禁止使用exit函数，会导致进程内所有线程全部退出。
- 在不添加sleep控制输出顺序的情况下，pthread_create在循环中，几乎瞬间创建5个线程，但只有第1个线程有机会输出（或者第2个也有，也可能没有，取决于内核调度），如果第3个线程执行了exit，将整个进程退出了，所以全部线程退出了。
- 所以，多线程环境中，应尽量少用，或者不使用exit函数，取而代之使用pthread_exit函数，将单个线程退出。任何线程里exit导致进程退出，其他线程未工作结束，主控线程退出时不能return或exit。
- 另注意：pthread_exit或者return返回的指针所指向的内存单元必须是全局的或者是用malloc分配的，不能在线程函数的栈上分配，因为当其它线程得到这个返回指针时线程函数已经退出了。
- 【练习】：编写多线程程序，总结exit、return、pthread_exit各自退出效果。
  - return：返回到调用者那里去。
  - pthread_exit：将调用该函数的线程退出。
  - exit：将进程退出。
- 示例

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <pthread.h>
   #include <string.h>
   
   void *thread_func(void *arg)
   {
       int i = (int)arg;
       printf("%dth thread: thread id = %lu, pid = %u\n", i+1, pthread_self(), getpid());
       return NULL;
   }
   
   int main()
   {
       pthread_t tid;
       int ret, i;
   
       for (i = 0; i<5; i++){
           ret = pthread_create(&tid, NULL, thread_func, (void *)i);
           if(ret != 0){
               fprintf(stderr, "pthread_create error:%s\n", strerror(ret));
               exit(1);
           }
       }                                                                                                 
   
       pthread_exit(NULL);
   }
   ```

### pthread_join函数

- 阻塞等待线程退出，获取线程退出状态。其作用，对应进程中waitpid()函数。
- `int pthread_join(pthread_t thread, void **retval);` 成功：0；失败：错误号。
- 参数：thread：线程ID（【注意】不是指针）； retval：存储线程结束状态。
- 对比记忆：
  - 进程中：main返回值、exit参数-->int；等待子进程结束, wait函数参数-->int *
  - 线程中：线程主函数返回值、pthread_exit-->void *；等待线程结束 pthread_join函数参数-->void **
- 【练习】：参数retval非空用法。	

   ```c
   #include <stdio.h>
   #include <unistd.h>
   #include <stdlib.h>
   #include <pthread.h>
   
   typedef struct{
       int a;
       int b;
   } exit_t;
   
   void *tfn(void *arg)                                                                                  
   {
       exit_t * ret;
       ret = malloc(sizeof(exit_t));
   
       ret->a = 100;
       ret->b = 300;
   
       pthread_exit((void *)ret);
   }
   
   int main(void)
   {
       pthread_t tid;
       exit_t * retval;
   
       pthread_create(&tid, NULL, tfn, NULL);
   
       //调用pthread_join可以获取线程的退出状态
       pthread_join(tid, (void **)&retval);
       printf("a = %d, b = %d\n", retval->a, retval->b);
   
   	free(retval);
       return 0;
   }
   ```

- 调用该函数的线程将挂起等待，直到ID为thread的线程终止。thread线程以不同的方法终止，通过pthread_join得到的终止状态是不同的，总结如下：
  - 1、如果不thread线程通过return返回，retval所指向的单元里存放的是thread线程函数的返回值。
  - 2、如果thread线程被别的线程调用pthread_cancel异常终止掉，retval所指向的单元里存放的是常数PTHREAD_CALCELED。
  - 3、如果thread线程是自己调用pthread_exit终止的，retval所指向的单元存放的是传给pthread_exit的参数。
  - 4、如果对thread线程的终止状态不感兴趣，可以传NULL给retval参数。
- 【练习】：使用pthread_join函数将循环创建的多个子线程回收。

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <pthread.h>
   
   int var = 100;
   
   void * tfn(void * arg)
   {
       int i;
       i = (int)arg;
   
       sleep(i);
       if(i == 1){ 
           var = 333;
           printf("var = %d\n", var);
           return var;
       } else if (i == 3)
       {   
           var = 777;
           printf("I'm %dth pthread, pthread_id = %lu\n  var = %d\n", i+1, pthread_self(), var);
           pthread_exit((void *)var);
       } else {
           printf("I'm %dth pthread, pthread_id = %lu\n  var = %d\n", i+1, pthread_self(), var);
           pthread_exit((void *)var);
       }   
   
       return NULL;
   }
   
   int main(void)
   {
       pthread_t tid[5];
       int i;
       int *ret[5];
   
       for(i = 0; i < 5; i++)
           pthread_create(&tid[i], NULL, tfn, (void *)i);
   
       for(i = 0; i < 5; i++){
           pthread_join(tid[i], (void **)&ret[i]);
           printf("-------%d 's ret = %d\n'", i, (int)ret[i]);
       }
   
       printf("I'm main pthread tid = %lu\t var = %d\n", pthread_self(), var);
   
       sleep(i);
       return 0;
   }
   ```

### pthread_detach函数

- 实现线程分隔
- `int pthread_detach(pthread_t thread);`，成功：0；失败：错误号。
- 线程分离状态：指定该状态，线程主动与主控线程断开关系。线程结束后，其退出状态不由其他线程获取，而直接自己自动释放。网络、多线程服务器常用。
- 进程若有该机制，将不会产生僵尸进程。僵尸进程的产生主要由于进程死后，大部分资源被释放，一点残留资源存于系统中，导致内核认为该进程仍存在。
- 也可以使用pthread_create函数参2(线程属性)来设置线程分离。
- 【练习】：使用pthread_detach函数实现线程分离。
- 一般情况下，线程终止后，其终止状态一直保留到其它线程调用pthread_join获取它的状态为止。但是线程也可以被置为detach状态，**这样的线程一旦终止就立刻回收它占用的所有资源，而不保留终止状态**。不能对一个已经处于detach状态的线程调用pthread_join，这样的调用将返回EINVAL错误。也就是说，如果已经对一个线程调用了pthread_detach就不能再调用pthread_join了。

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <string.h>
   #include <pthread.h>
   
   void *tfn(void *arg)
   {
       int n = 3;
       while(n--){
           printf("thread count %d\n", n); 
           sleep(1);
       }   
   
       return (void *)1;
   }
   
   int main(void)
   {
       pthread_t tid;
       void *tret;
       int err;
   
   #if 0                                                                                                 
       //通过线程属性来设置游离态
       pthread_attr_t attr;
       pthread_attr_init(&attr);
       pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
       pthread_create(&tid, &attr, tfn, NULL);
   #else
       pthread_create(&tid, NULL, tfn, NULL);
       //让线程分离-----自动退出，无系统残留资源
       pthread_detach(tid);
   #endif
   
       while(1){
           err = pthread_join(tid, &tret);
           printf("------------err = %d\n", err);
           if(err != 0)
               fprintf(stderr, "thread_join error : %s\n", strerror(err));
           else
               fprintf(stderr, "thread exit code %d\n", (int)tret);
       }   
   }
   ```

### pthread_cancel函数

- 杀死（取消）线程。其作用，对应进程中kill()函数。
- `int pthread_cancel(pthread_t thread);`，成功：0；失败：错误号。
- 【注意】：线程的取消并不是实时的，而有一定的延时。需要等待线程到达某个取消点（检查点）。
- 类似于玩游戏存档，必须到达指定的场所（存档点，如：客栈、仓库、城里等）才能存储进度。杀死线程也不是立刻就能完成，必须要到达取消点。
- 取消点：是线程检查是否被取消，并按请求进行动作的一个位置。通常是一些系统调用create、open、pause、close、read、write...执行命令man 7 pthreads可以查看具备这些取消点的系统调用列表。也可参阅APUE.12.7取消选项小节。
- 可粗略认为一个系统调用（进入内核）即为一个取消点。如线程中没有取消点，可以通过调用pthread_testcancel函数自行设置一个取消点。
- 被取消的线程，退出值定义在Linux的pthread库中。常数PTHREAD_CANCELED的值是-1。可以头文件pthread.h中找到它的定义：`#define PTHREAD_CANCELED((void *)-1)`。因此当我们对一个已经被取消的线程使用pthread_join回收时，得到的返回值为-1。
- 【练习】：终止线程的三种方法。注意“取消点”的概念。	

   ```c
   #include <stdio.h>
   #include <unistd.h>
   #include <pthread.h>
   #include <stdlib.h>
   
   void *tfn1(void *arg)
   {
       printf("thread 1 returning\n");
       return (void *)111;
   }
   
   void *tfn2(void *arg)
   {
       printf("thread 2 exiting\n");
       pthread_exit((void *)222);
   }
   
   void *tfn3(void *arg)
   {
       while(1){
           //printf("thread 3: I'm going to die in 3 seconds ... \n");
           //sleep(1);
           pthread_testcancel(); //自己添加取消点
       }   
   
       return (void *)666;
   }
   
   int main()
   {
       pthread_t tid;
       void *tret = NULL;
   
       pthread_create(&tid, NULL, tfn1, NULL);
       pthread_join(tid, &tret);
       printf("thread 1 exit code = %d\n\n", (int)tret);
   
       pthread_create(&tid, NULL, tfn2, NULL);
       pthread_join(tid, &tret);
       printf("thread 2 exit code = %d\n\n", (int)tret);
   
       pthread_create(&tid, NULL, tfn3, NULL);
       sleep(3);
       pthread_cancel(tid);
       pthread_join(tid, &tret);
       printf("thread 3 exit code = %d\n", (int)tret);
   }
   ```

### pthread_equal函数

- 比较两个线程ID是否相等。
- `int pthread_equal(pthread_t t1, pthread_t t2);`
- 有可能Linux在未来线程ID pthread_t类型被修改为结构体实现。

### 控制原语对比

		进程				线程
		fork			pthread_create		创建
		exit			pthread_exit		退出
		wait			pthread_join		等待
		kill			pthread_cancel		杀死
		getpid			pthread_self		取得ID
						pthread_detach		分离



## 线程属性

- 本节作为指引性介绍，Linux下线程的属性是可以根据实际项目需要进行设置，之前我们讨论的线程都是采用线程的默认属性，默认属性已经可以解决绝大多数开发时遇到的问题。如我们对程序的性能提出更高的要求，那么需要设置线程属性，比如可以通过设置线程栈的大小来降低内存的使用，增加最大线程个数。

   ```c
   typedef struct{
       int						etachstate;		//线程的分离状态
       int 					schedpolicy;	//线程调度策略
       struct sched_param		schedparam;		//线程的调度参数
       int						inheritsched;	//线程的继承性
       int						scope;			//线程的作用域
       size_t					guardsize;		//线程栈末尾的警戒缓冲区大小
       int 					stackaddr_set;	//线程的栈设置
       void*					stackaddr;		//线程的位置
       size_t					stacksize;		//线程的大小
   } pthread_attr_t;
   ```

- 主要结构体成员
  - 1、线程分离状态
  - 2、线程栈大小（默认平均分配）
  - 3、线程栈警戒缓冲区大小（位于栈末尾）

- 属性值不能直接设置，须使用相关函数进行操作，初始化的函数为pthread_attr_init，这个函数必须在pthread_create函数之前调用。之后须用pthread_attr_destroy函数来释放资源。

- 线程属性主要包括如下属性：作用域（scope）、栈尺寸（stack size）、栈地址（stack address）、优先级（priority）、分离的状态（detached state）、调度策略和参数（scheduling policy and parameters）。默认的属性为非绑定、非分离、缺省的堆栈、与父进程同样级别的优先级。

### 线程属性初始化
- 注意：应先初始化线程属性，再pthread_create创建线程。
- 初始化线程属性。
	- `int pthread_attr_init(pthread_attr_t *attr);`，成功：0； 失败：错误号。
- 销毁线程属性所占用的资源。
	- `int pthread_attr_destroy(pthread_attr_t *attr);`，成功：0；失败：错误号。

### 线程的分离状态
- 线程的分离状态决定一个线程以什么样的方式来终止自己。
- 非分离状态：线程的默认属性是非分离状态，这种情况下，原有的线程等待创建的线程结束。只有当pthread_join()函数返回时，创建的线程才算终止，才能释放自己占用的系统资源。
- 分离状态：分离线程没有被其他的线程等待，自己运行结束了，线程也就终止了，马上释放系统资源。应该根据自己的需要，选择适当的分离状态。
- 线程分离状态的函数：
- 设置线程属性，分离or非分离。

  - `int pthread_attr_setdetachstate(pthread_attr_t *attr, int detachstate);`
- 获取线程属性，分离or非分离
  - `int pthread_attr_getdetachstate(pthread_attr_t *attr, int *detachstate);`
  - 参数：
  	- attr：已经初始化的线程属性
  	- detachstate：
  		- PTHREAD_CREATE_DETACHED（分离线程）
  		- PTHREAD_CREATE_JOINABLE（非分离线程）
- 这里要注意的一点是，如果设置一个线程为分离线程，而这个线程运行又非常快，它很可能在pthread_create函数返回之前就终止了，它终止以后就可能将线程号和系统资源移交给其他的线程使用，这样调用pthread_create的线程就得到了错误的线程号。要避免这种情况可以采取一定的同步措施，最简单的方法之一是可以在被创建的线程里调用pthread_cond_timedwait函数，让这个线程等待一会儿，留出足够的时间让函数pthread_create返回。设置一段等待时间，是在多线程编程里常用的方法。但是注意不要使用诸如wait()之类的函数，它们是使整个进程睡眠，并不能解决同步的问题。	

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <pthread.h>
   #include <string.h>
   
   void *thread_func(void *arg)
   {
       pthread_exit((void *)11);
   }
   
   int main()
   {
       pthread_t tid;
       int ret;
       pthread_attr_t attr;
   
       ret = pthread_attr_init(&attr);
       if(ret != 0){ 
           fprintf(stderr, "pthread_attr_init error:%s\n", strerror(ret));
           exit(1);
       }   
   
       pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
   
       ret = pthread_create(&tid, &attr, thread_func, NULL);
       if(ret != 0){ 
           fprintf(stderr, "pthread_create error:%s\n", strerror(ret));
           exit(1);
       }   
   
       ret = pthread_join(tid, NULL);
       if(ret != 0){ 
           fprintf(stderr, "pthread_join error:%s\n", strerror(ret));
           exit(1);
       }   
   
       pthread_exit((void *)1);                                                                          
       return 0;
   }
   ```

### 线程的栈地址

- POSIX.1 定义了两个常量_POSIX_THREAD_ATTR_STACKADDR和_POSIX_THREAD_ATTR_STACKSIZE
- 检测系统是否支持栈属性。也可以给sysconf函数传递_SC_THREAD_ATTR_STACKADDR或_SC_THREAD_ATTR_STACKSIZE来进行检测。
- 当进程栈地址空间不够用时，指定新建线程使用由malloc分配的空间作为自己的栈空间。通过pthread_attr_setstack和pthread_attr_getstack两个函数分别设置和获取线程的栈地址。
- `int pthread_attr_setstack(pthread_attr_t *attr, void *stackaddr, size_t stacksize);`
	- 成功：0；失败：错误号
- `int pthread_attr_getstack(const pthread_attr_t *attr, void **stackaddr, size_t *stacksize);`
	- 成功：0；失败：错误号
- 参数
	- attr：指向一个线程属性的指针。
	- stackaddr：返回获取的栈地址。
	- stacksize：返回获取的栈大小。

### 线程的栈大小
- 当系统中有很多线程时，可能需要减小每个线程栈的默认大小，防止进程的地址空间不够用，当线程调用的函数会分配很大的局部变量或函数调用层次很深时，可能需要增大线程栈的默认大小。
- 函数pthread_attr_getstacksize和pthread_attr_setstacksize提供设置。
- int pthread_attr_setstacksize(pthread_attr_t *attr, size_t stacksize);
	- 成功：0；失败：错误号
- int pthread_attr_getstacksize(const pthread_attr_t *attr, size_t *stacksize);
	- 成功：0；失败：错误号
- 参数
	- attr：指向一个线程属性的指针。
	- stacksize：返回线程的栈大小。

### 线程属性控制示例

```c
#include <stdio.h>
#include <pthread.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

#define SIZE 0X10000

void *th_fun(void *arg)
{
    while(1)
        sleep(1);
}

int main()
{
    pthread_t tid;
    int err, detachstate, i = 1;
    pthread_attr_t attr;
    size_t stacksize;
    void *stackaddr;

    pthread_attr_init(&attr);
    pthread_attr_getstack(&attr, &stackaddr, &stacksize);
    pthread_attr_getdetachstate(&attr, &detachstate);

    //默认是分离态
    if(detachstate == PTHREAD_CREATE_DETACHED)
        printf("thread detached\n");
    //默认是非分离
    else if (detachstate == PTHREAD_CREATE_JOINABLE)
        printf("thread join\n");
    else
        printf("thread un known\n");

    //设置线程分离属性
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);

    while(1){
        //在堆上申请内存，指定线程栈的起始地址和大小
        stackaddr = malloc(SIZE);
        if(stackaddr == NULL){
            perror("malloc");
            exit(1);
        }
        stacksize = SIZE;
        //借助线程的属性，修改线程栈空间大小
        pthread_attr_setstack(&attr, stackaddr, stacksize);

        err = pthread_create(&tid, &attr, th_fun, NULL);
        if(err != 0){
            printf("%s\n", strerror(err));
            exit(1);
        }

        printf("%d\n", i++);
    }

    pthread_attr_destroy(&attr);
}
```



## NPTL

- 1、察看当前pthread库版本getconf GNU_LIBPTHREAD_VERSION
- 2、NPTL实现机制（POSIX），Native POSIX Thread Library
- 3、使用线程库时gcc指定-lpthread



## 线程使用注意事项

- 1、主线程退出其他线程不退出，主线程退出应调用pthread_exit
- 2、避免僵尸线程
	- pthread_join
	- pthread_detach
	- pthread_create，指定分离属性
	- 被join线程可能在join函数返回前就释放完自己的所有内存资源，所以不应当返回被回收线程栈中的值。
- 3、malloc和mmap申请的内存可以被其他线程释放。
- 4、应避免在多线程模型中调用fork，除非马上exec，子进程中只有调用fork的线程存在，其他线程在子进程中均pthread_exit。
- 5、信号的复杂语义很难和多线程共存，应避免在多线程引入信号机制。



## 同步

- 所谓同步，即同时起步，协调一致。不同的对象，对“同步”的理解方式略有不同。如，设备同步，是指在两个设备之间规定一个共同的时间参考；数据库同步，是指让两个或多个数据库内容保持一致，或者按需要部分保持一致；文件同步，是指让两个或多个文件夹里的文件保持一致。等等
- 而，编程中、通信中所说的同步与生活中大家印象中的同步概念略有差异。“同”字应是指协同、协助、互相配合。主旨在协同步调，按预定的先后次序运行。
### 线程同步
- 同步即协同步调，按预定的先后次序运行。
- 线程同步，指一个线程发出某一功能调用时，在没有得到结果之前，该调用不返回。同时其它线程为保证数据一致性，不能调用该功能。
- 举例1：银行存款5000。柜台，折：取3000；提款机，卡：取3000。剩余：2000
- 举例2：内存中100字节，线程T1欲填入全1，线程T2欲填入全0。但如果T1执行了50个字节失去CPU，T2执行，会将T1写过的内容覆盖。当T1两次获得CPU继续从失去CPU的位置向后写入1，当执行结束，内存中的100字节，既不是全1，也不是全0。
- 产生的现象叫做“与时间有关的错误”（time related）。为了避免这种数据混乱，线程需要同步。
- “同步”的目的，是为了避免数据混乱，解决与时间有关的错误。实际上，不仅线程间需要同步，进程间、信号间等等都需要同步机制。
- 因此，所有“多个控制流，共同操作一个共享资源”的情况，都需要同步。
### 数据混乱原因
- 1、资源共享（独享资源则不会）。
- 2、调度随机（意味着数据访问会出现竞争）。
- 3、线程间缺乏必要的同步机制。
- 以上3点中，前两点不能改变，欲提高效率，传递数据，资源必须共享。只要共享资源，就一定会出现竞争。只要存在竞争关系，数据就很容易出现混乱。
- 所有只能从第三点着手解决。使多个线程在访问共享资源的时候，出现互斥。
## 互斥mutex
- Linux中提供一把互斥锁mutex(也称之为互斥量)。
- 每个线程在对资源操作前都尝试先加锁，成功加锁才能操作，操作结束解锁。
- 资源还是共享的，线程间也还是竞争的，但通过“锁”就将资源的访问变成互斥操作，而后与时间有关的错误也不会再产生了。
![锁](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e9%94%81.png)
- 但，应注意：同一时刻，只能有一个线程持有该锁。
- 当A线程对某个全局变量加锁访问，B在访问前尝试加锁，拿不到锁，B阻塞。C线程不去加锁，而直接访问该全局变量，依然能够访问，但会出现数据混乱。
- 所以，互斥锁实质上是操作系统提供的一把“建议锁”（又称“协同锁”），建议程序中有多线程访问共享资源的时候使用该机制。但并没有强制限定。
- 因此，即使有了mutex，如果有线程不按规则来访问数据，依然会造成数据混乱。
### 主要应用函数
- 基本操作
	- pthread_mutex_init函数
	- pthread_mutex_destroy函数
	- pthread_mutex_lock函数
	- pthread_mutex_trylock函数
	- pthread_mutex_unlock函数
	- 以上5个函数的返回值都是：成功返回0，失败返回错误号。
	- pthread_mutex_t 类型，其本质是一个结构体。为简化理解，应用时可忽略其实现细节，简单当成整数看待。
	- pthread_mutex_t mutex; 变量mutex只有两种取值1、0。
- pthread_mutex_init函数
	- 初始化一个互斥锁（互斥量） --> 初值可看作1。
	- `int pthread_mutex_init(pthread_mutex_t * restrict mutex, const pthread_mutexattr_t * restrict attr);`
	- 参1：传出参数，调用时应传&mutex。
	- restrict关键字：只用于限制指针，告诉编译器，所有修改该指针指向内存中内容的操作，只能通过本指针完成。不能通过除本指针以外的其他变量或指针修改。
	- 参2：互斥量属性。是一个传入参数，通常传NULL，选用默认属性（线程间共享）。参APUE.12.4同步属性
		- 静态初始化：如果互斥锁mutex是静态分配的（定义在全局，或加了static关键字修饰），可以直接使用宏进行初始化。e.g.  `pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;`
		- 动态初始化：局部变量应采用动态初始化。e.g.`pthread_mutex_init(&mutex, NULL);`
- pthread_mutex_destroy函数
	- 销毁一个互斥锁。
	- `int pthread_mutex_destroy(pthread_mutex_t *mutex);`
- pthread_mutex_lock函数
	- 加锁。可理解为将mutex--（或1）
	- `int pthread_mutex_lock(pthread_mutex_t *mutex);`
- pthread_mutex_unlock函数
	- 解锁。可理解为将mutex++(或+1)
	- `int pthread_mutex_unlock(pthread_mutex_t *mutex);`
- pthread_mutex_trylock函数
	- 尝试加锁。
	- `int pthread_mutex_trylock(pthread_mutex_t *mutex);`

### 加锁与解锁
- lock与unlock
	- lock尝试加锁，如果加锁不成功，线程阻塞，阻塞到持有该互斥量的其他线程锁为止。
	- unlock主动解锁函数，同时将阻塞在该锁上的所有线程全部唤醒，至于哪个线程先被唤醒，取决于优先级、调度。默认：先阻塞、先唤醒。
	- 例如：T1、T2、T3、T4使用一把mutex锁。T1加锁成功，其他线程均阻塞，直至T1解锁。T1解锁后，T2、T3、T4均被唤醒，并自动再次尝试加锁。
	- 可假想mutex锁init成功初值为1。lock功能是将mutex--，unlock将mutex++。
- lock与trylock
	- lock加锁失败会阻塞，等待锁释放。
	- trylock加锁失败直接返回错误号（如：EBUSY），不阻塞。
### 加锁步骤测试
- 看如下程序：该程序是非常典型的，由于共享、竞争而没有加任何同步机制，导致产生于时间有关的错误，造成数据混乱。	

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <pthread.h>
   #include <string.h>
   
   void *tfn(void *arg)
   {
       srand(time(NULL));
       while(1){
           printf("hello "); 
           //模拟长时间操作共享资源，导致CPU易主，产生与时间有关的错误
           sleep(rand() % 3); 
           printf("world\n");
           sleep(rand() % 3); 
       }
   
       return NULL;
   }
   
   int main(void)
   {
       pthread_t tid;
       srand(time(NULL));
   
       pthread_create(&tid, NULL, tfn, NULL);
       while(1){
           printf("HELLO "); 
           sleep(rand() % 3); 
           printf("WORLD\n");
           sleep(rand() % 3); 
       }
   
       return 0;
   }
   ```

- 【练习】：修改该程序，使用mutex互斥锁进行同步。
  - 1、定义全局互斥锁，初始化init(&m, NULL)互斥量，添加对应的destroy。
  - 2、两个线程while中，两次printf前后，分别加lock和unlock。
  - 3、将unlock挪至第二个sleep后，发现交替现象很难出现。

    - 线程在操作完共享资源后本应该立即解锁，但修改后，线程抱着锁睡眠。睡醒解锁后又立即加锁，这两个库函数本身不会阻塞。
    - 所以在这两行代码之间失去CPU的概率很小。因此，另外一个线程很难得到加锁的机会。
  - 4、main中加flag=5将flag在while中--，这时，主线程输出5次后试图销毁锁，但子线程未将锁释放，无法完成。
  - 5、main中加pthread_cancel()将子线程取消。	

     ```c
     #include <stdio.h>
     #include <stdlib.h>
     #include <unistd.h>
     #include <pthread.h>
     #include <string.h>
     
     //定义锁
     pthread_mutex_t mutex;
     
     void *tfn(void *arg)
     {
         srand(time(NULL));
         while(1){
             //加锁
             pthread_mutex_lock(&mutex);
             printf("hello "); 
             //模拟长时间操作共享资源，导致CPU易主，产生与时间有关的错误
             sleep(rand() % 3); 
             printf("world\n");
             //解锁
             pthread_mutex_unlock(&mutex);
             sleep(rand() % 3); 
     		//添加检查点
             pthread_testcancel();
         }
     
         return NULL;
     }
     
     int main(void)
     {
         int flag = 5;
         pthread_t tid;
         srand(time(NULL));
     
         //锁初始化
         pthread_mutex_init(&mutex, NULL);  //mutex = 1
     
         pthread_create(&tid, NULL, tfn, NULL);
         while(flag--){
             //加锁
             pthread_mutex_lock(&mutex);
             printf("HELLO ");
             sleep(rand() % 3);
             printf("WORLD\n");
             //解锁
             pthread_mutex_unlock(&mutex);
             sleep(rand() % 3);
         }
     	//取消子线程
         pthread_cancel(tid);
         pthread_join(tid, NULL);
         //锁销毁
         pthread_mutex_destroy(&mutex);
         return 0;
     }
     ```

- **结论：在访问共享资源前加锁，访问结束后立即解锁。锁的“粒度”应越小越好。**



## 死锁

- 1、线程试图对同一个互斥量A加锁两次。
- 2、线程1拥有A锁，请求获得B锁；线程2拥有B锁，请求获得A锁。
![死锁](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e6%ad%bb%e9%94%81.png)
- 【作业】：编写程序，实现上述死锁现象。



## 读写锁

- 与互斥量类似，但读写锁允许更高的并行性。其特性为：写独占，读共享。

### 读写锁状态

- 1、读模式下加锁状态（读锁）。
- 2、写模式下加锁状态（写锁）。
- 3、不加锁状态。

### 读写锁特性
- 1、读写锁是“写模式加锁”时，解锁前，所有对该锁加锁的线程都会被阻塞。
- 2、读写锁是“读模式加锁”时，如果线程以读模式对其加锁会成功；如果线程以写模式加锁会阻塞。
- 3、读写锁是“读模式加锁”时，既有试图以写模式加锁的线程，也有试图以读模式加锁的线程。那么读写锁会阻塞随后的读模式锁请求。优先满足写模式锁。**读锁、写锁并行阻塞，写锁优先级高**。
- 读写锁也叫共享-独占锁。当读写锁以读模式锁住时，它是以共享模式锁住的；当它以写模式锁住时，它是以独占模式锁住的。**写独占、读共享**。
- 读写锁非常适合于对数据结构读的次数远大于写的情况。

### 主要应用函数
- 基本操作
  - pthread_rwlock_init函数
  - pthread_rwlock_destroy函数
  - pthread_rwlock_rdlock函数
  - pthread_rwlock_wrlock函数
  - pthread_rwlock_tryrdlock函数
  - pthread_rwlock_trywrlock函数
  - pthread_rwlock_unlock函数
  - 以上7个函数的返回值都是：成功返回0，失败直接返回错误号。
  - pthread_rwlock_t类型，用于定义一个读写锁变量。
  - pthread_rwlock_t rwlock;

- 示例

   ```c
   #include <stdio.h>
   #include <unistd.h>
   #include <pthread.h>
   
   int counter;
   pthread_rwlock_t rwlock;
   
   void *th_write(void *arg)
   {
       int t;
       int i = (int)arg;
   
       while(1){
           t = counter;
           usleep(1000);
   
           pthread_rwlock_wrlock(&rwlock);                                                               
           printf("======write %d: %lu: counter=%d ++counter=%d\n", i, pthread_self(), t, ++counter);
           pthread_rwlock_unlock(&rwlock);
   
           usleep(5000);
       }   
   
       return NULL;
   }
   
   void *th_read(void *arg)
   {
       int i = (int)arg;
       while(1){
           pthread_rwlock_rdlock(&rwlock);
           printf("======read %d: %lu: %d\n", i, pthread_self(), counter);
           pthread_rwlock_unlock(&rwlock);
   
           usleep(900);
       }   
   
       return NULL;
   }
   
   //3个线程不定时写全局资源，5个线程不定时读同一全局资源
   int main()
   {
       int i;
       pthread_t tid[8];
       //初始读写锁
       pthread_rwlock_init(&rwlock, NULL);
   
       for(i = 0; i < 3; i++)
           pthread_create(&tid[i], NULL, th_write, (void *)i);
   
       for(i = 0; i < 5; i++)
           pthread_create(&tid[i+3], NULL, th_read, (void *)i);
   
       for(i = 0; i < 8; i++)
           pthread_join(tid[i], NULL);
   
       //释放读写锁
       pthread_rwlock_destroy(&rwlock);
       return 0;
   }   
   ```



## 条件变量

- 条件变量本身不是锁！但它也可以造成阻塞。通常与互斥锁配合使用。给多线程提供一个会合的场所。

### 主要应用函数
- 基本操作
  - pthread_cond_init函数
  - pthread_cond_destroy函数
  - pthread_cond_wait函数
  - pthread_cond_timedwait函数
  - pthread_cond_signal函数
  - pthread_cond_broadcast函数
  - 以上6个函数的返回值都是：成功返回0，失败直接返回错误号。
  - pthread_cond_t类型，用于定义条件变量。
  - pthread_cond_t cond;

- pthread_cond_init函数
  - 初始化一个条件变量
  - `int pthread_cond_init(pthread_cond_t * restrict cond, const pthread_condattr_t * restrict attr);`
  - 参2：attr表条件变量属性，通常为默认值，传NULL即可。
  - 也可以使用静态初始化的方法，初始化条件变量：`pthread_cond_t cond = PTHREAD_COND_INITIALIZED;`

- pthread_cond_destroy函数
  - 销毁一个条件变量
  - `int pthread_cond_destroy(pthread_cond_t *cond);`

- pthread_cond_wait函数
  - 阻塞等待一个条件变量
  - `int pthread_cond_wait(pthread_cond_t * restrict cond, pthread_mutex_t * restrict mutex);`
  - 函数作用：
    - 1、阻塞等待条件变更cond（参1）满足

    - 2、释放已掌握的互斥锁（解锁互斥量）相当于`pthread_mutex_unlock(&mutex);`

    - 1和2两步为同一个原子操作。

    - 3、当被唤醒，pthread_cond_wait函数返回时，解除阻塞并重新申请获取互斥锁

        ```c
        pthread_mutex_lock(&mutex);
        ```

- pthread_cond_timedwait函数
  - 限时等待一个条件变量

  - `int pthread_cond_timedwait(pthread_cond_t * restrict cond, pthread_mutex_t * restrict mutex, const struct timespec * restrict abstime);`

  - 参3：参看`man sem_timedwait`函数，查看struct timespec结构体。

     ```c
     struct timespec{
     	time_t tv_sec;  /*seconds*/ 秒
     	long tv_nsec;  /*nanoseconds*/ 纳秒
     };
     ```

  - 形参abstime：绝对时间。
    - 如：time(NULL)返回的就是绝对时间。而alarm(1)是相对时间，相对当前时间定时1秒钟。

       ```c
       struct timespec t = {1,0};
       pthread_cond_timedwait(&cond, &mutex, &t);
       //只能定时到1970年1月1日 00：00：01秒（早已经过去）
       ```

    - 正确用法：
      - time_t cur = time(NULL); 获取当前时间。
      - struct timespec t; 定义tiemspec结构体变量t
      - t.tv_sec = cur + 1; 定时1秒
      - pthread_cond_timedwait(&cond, &mutex, &t); 传参

    - 在讲解setitimer函数时我们还提到另一种时间类型

       ```c
       struct timeval{
       	time_t tv_sec;  /*seconds*/ 秒
       	suseconds_t tv_usec;  /*microseconds*/ 微秒
       };
       ```

- pthread_cond_signal函数
  - 唤醒至少一个阻塞在条件变量上的线程。
  - `int pthread_cond_signal(pthread_cond_t *cond);`

- pthread_cond_broadcast函数
  - 唤醒全部阻塞在条件变量上的线程。
  - `int pthread_cond_broadcast(pthread_cond_t *cond);`

### 生产消费者条件变量模型

- 线程同步典型的案例即为生产消费者模型，而借助条件变量来实现这一模型，是比较常见的一种方法。假定有两个线程，一个模拟生产者行为，一个模拟消费者行为。两个线程同时操作一个共享资源（一般称之为汇聚），生产向其中添加产品，消费者从中消费掉产品。
  ![生产者消费者模型](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e7%94%9f%e4%ba%a7%e8%80%85%e6%b6%88%e8%b4%b9%e8%80%85%e6%a8%a1%e5%9e%8b.png)
- 看如下示例，使用条件变量模拟生产者、消费者问题：

   ```c
   /*借助条件变量模拟，生产者-消费者问题*/
   #include <stdlib.h>
   #include <stdio.h>
   #include <unistd.h>
   #include <pthread.h>
   
   /*链表作为共享数据，需被互斥量保护*/
   struct msg {
       struct msg *next;
       int num;
   };
   
   struct msg *head;
   struct msg *mp;
   
   /*静态初始化一个条件变量和一个互斥量*/
   pthread_cond_t has_product = PTHREAD_COND_INITIALIZER;
   pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
   
   void *consumer(void *p)
   {
       for(;;){
           pthread_mutex_lock(&lock);
           while(head == NULL){ //头指针为空，说明没有节点
               pthread_cond_wait(&has_product, &lock);
           }
           mp = head;
           head = mp->next; //模拟消费掉一个产品
           pthread_mutex_unlock(&lock);
   
           printf("-Consume ---%d\n", mp->num);
           free(mp);
           sleep(rand() % 5);
       }
   }
   
   void *producer(void *p)
   {
       for(;;){
           mp = malloc(sizeof(struct msg));
           //模拟生产一个产品
           mp->num = rand() % 1000 + 1;
           printf("-Produce ---%d\n", mp->num);
   
           pthread_mutex_lock(&lock);
           mp->next = head;
           head = mp;
           pthread_mutex_unlock(&lock);
           //将等待在该条件变量上的一个线程唤醒
           pthread_cond_signal(&has_product);
           sleep(rand() % 5);
       }
   }
   
   int main(int argc, char * argv)
   {
       pthread_t pid, cid;
       srand(time(NULL));
   
       pthread_create(&pid, NULL, producer, NULL);
       pthread_create(&cid, NULL, consumer, NULL);
   
       pthread_join(pid, NULL);
       pthread_join(cid, NULL);
   
       return 0;
   }
   ```

### 条件变量的优点：
- 相较于mutex而言，条件变量可以减少竞争。
- 如直接使用mutex，除了生产者、消费者之间要竞争互斥量以外，消费者之间也要竞争互斥量，但如果汇聚（链表）中没有数据，消费者之间竞争互斥锁是无意义的。有了条件变量机制以后，只有生产者完成生产，才会引起消费者之间竞争。提高了程序效率。



## 信号量

- 进化版的互斥锁（1-->N）。
- 由于互斥锁的粒度比较大，如果我们希望在多个线程间对某一对象的部分数据进行共享，使用互斥锁是没有办法实现的，只能将整个数据对象锁住。这样虽然达到了多线程操作共享数据时保证正确性的目的，却无形中导致线程的并发性下降。线程从并行执行，变成了串行执行。与直接使用单进程无异。
- 信号量，是相对折中的一种处理方式，既能保证同步，数据不混乱，又能提高线程并发。
### 主要应用函数
- 函数列表
  - sem_init函数
  - sem_destroy函数
  - sem_wait函数
  - sem_post函数
  - sem_trywait函数
  - sem_timedwait函数
  - 以上6个函数的返回值都是：成功返回0，失败返回-1，同时设置`errno`。（注意，它们没有pthread前缀）。
  - sem_t类型，本质仍是结构体。但应用期间可简单看作为整数，忽略实现细节（类似于使用文件描述符）。
  - sem_t sem; 规定信号量sem不能<0。头文件`<semaphore.h>`
- 信号量基本操作：
  - sem_wait：
  	- 1、信号量大于0，则信号量--。（类比`pthread_mutex_lock`）
  	- 2、信号量等于0，造成线程阻塞
  - sem_post：
  	- 将信号量++，同时唤醒阻塞在信号量上的线程。（类比`pthread_mutex_unlock`）
  - 但，由于`sem_t`的实现对用户隐藏，所有所谓的++、--操作只能通过函数来实现，而不能直接++、--符号。
  - **信号量的初值，决定了占用信号量的线程的个数**。
- sem_init函数
  - 初始化一个信号量。
  - `int sem_init(sem_t *sem, int pshared, unsigned int value);`
  - 参1：sem信号量。
  - 参2：pshared取0用于线程间；取非0（一般为1）用于进程间。
  - 参3：value指定信号量初值。
- sem_destroy函数
  - 销毁一个信号量。
  - `int sem_destroy(sem_t *sem);`
- sem_wait函数
  - 给信号量加锁 --
  - `int sem_wait(sem_t *sem);`
- sem_post函数
  - 给信号量解锁 ++
  - `int sem_post(sem_t *sem);`
- sem_trywait函数
  - 尝试对信号量加锁 --。（与sem_wait的区别类比lock和trylock）
  - `int sem_trywait(sem_t *sem);`
- sem_timedwait函数
  - 限时尝试对信号量加锁--
  - `int sem_timedwait(sem_t *sem, const struct timespec *abs_timeout);`
  - 参2：abs_timeout采用的是绝对时间。
### 生产者消费者信号量模型
- 【练习】：使用信号量完成线程间同步，模拟生产者，消费者问题。	

   ```c
   //信号量实现生产者消费者问题
   #include <stdio.h>
   #include <unistd.h>                                                                                   
   #include <pthread.h>
   #include <stdlib.h>
   #include <semaphore.h>
   
   #define NUM 5
   
   int queue[NUM]; //全局数组实现环形队列
   sem_t blank_number, product_number; //空格子信号量，产品信号量
   
   void *producer(void *arg)
   {
       int i = 0;
       while(1) {
           sem_wait(&blank_number); //生产者将空格子数--，为0则阻塞等待
           queue[i] = rand() % 1000 + 1; //生产一个产品
           printf("----Produce----%d\n", queue[i]);
           sem_post(&product_number); //将产品数++
   
           i = (i+1) % NUM; //借助下标实现环形
           sleep(rand() % 3); 
       }   
       return NULL;
   }
   
   void *consumer(void *arg)
   {
       int i = 0;
       while(1){
           sem_wait(&product_number); //消费者将产品数--，为0则阻塞等待
           printf("--Consume---%d\n", queue[i]);
           queue[i] = 0; //消费一个产品
           sem_post(&blank_number); //消费掉以后，将空格子数++
   
           i = (i+1) % NUM; //借助下标实现环形
           sleep(rand() % 3); 
       }   
       return NULL;
   }
   
   int main()
   {
       pthread_t pid, cid;
   
       sem_init(&blank_number, 0, NUM); //初始化空格子信号量为5
       sem_init(&product_number, 0, 0); //产品数为0
                                                                                                         
       pthread_create(&pid, NULL, producer, NULL);
       pthread_create(&cid, NULL, consumer, NULL);
   
       pthread_join(pid, NULL);
       pthread_join(cid, NULL);
   
       sem_destroy(&blank_number);
       sem_destroy(&product_number);
       return 0;
   }
   ```

- 分析
  - 规定
    - 如果队列中有数据，生产者不能生产，只能阻塞。
    - 如果队列中没有数据，消费者不能消费，只能等待数据。
  - 定义两个信号量：S满 = 0， S空 = 1（S满代表满格的信号量，S空表示空格的信号量，程序起始，格子一定为空）。
  - 所以有：

     ```c
     T生产者主函数 ｛
     	sem_wait(S空);
     	生产...
     	sem_post(S满)
     ｝
     T消费者主函数 ｛
     	sem_wait(S满);
     	消费...
     	sem_post(S空)
     ｝
     ```
  - 假设：线程到达的顺序是：T生、T生、T消。
  - 那么：
    - T生1到达，将S空-1，生产，将S满+1
    - T生2到达，S空已经为0，阻塞
    - T消到达，将S满-1，消费，将S空+1
  - 三个线程到达的顺序是：T生1、T生2、T消。而执行的顺序是T生1、T消、T生2
  - 这里，【S空】表示空格子的总数，代表可占用信号量的线程总数-->1。其实这样的话，信号量就等同于互斥锁。
  - 但，如果S空=2、3、4……就不一样了，该信号量同时可以由多个线程占用，不再是互斥的形状。因此我们说信号量是互斥锁的加强版。
  - 【推演练习】：理解上述模型，推演，如果是两个消费者，一个生产者，是怎么样的情况。
  - 【作业】：结合生产者消费者信号量模型，揣摩`sem_timedwait`函数作用。编程实现，一个线程读用户输入，另一个线程打印“hello world”。如果用户无输入，则每隔5秒向屏幕打印一个“hello world”；如果用户有输入，立刻打印“hello world”到屏幕。



## 进程间同步

- 进程间也可以使用互斥锁，来达到同步的目的。但应在`pthread_mutex_init`初始化之前，修改其属性为进程间共享。`mutex`的属性修改函数主要有以下几个。
### 互斥量mutex
- 主要应用函数
  - pthread_mutexattr_t mattr类型：用于定义mutex锁的【属性】。
  - pthread_mutexattr_init函数：初始化一个mutex属性对象。
  	- `int pthread_mutexattr_init(pthread_mutexattr_t *attr);`
  - pthread_mutexattr_destroy函数：销毁mutex属性对象（而非销毁锁）。
  	- `int pthread_mutexattr_destroy(pthread_mutexattr_t *attr);`
  - pthread_mutexattr_setpshared函数：修改mutex属性。
  	- `int pthread_mutexattr_setpshared(pthread_mutexattr_t *attr, int pshared);`
  	- 参2：pshared取值
  		- 线程锁：`PTHREAD_PROCESS_PRIVATE`(mutex的默认属性即为线程锁，进程间私有)
  		- 进程锁：`PTHREAD_PROCESS_SHARED`
- 进程间mutex示例	

   ```c
   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <string.h>
   #include <fcntl.h>
   #include <pthread.h>
   #include <sys/mman.h>
   #include <sys/wait.h>
   
   struct mt {
   	int num;
   	pthread_mutex_t mutex;
   	pthread_mutexattr_t mutexattr;
   };
   
   int main()
   {
   	int i;
   	struct mt *mm;
   	pid_t pid;
   
   	mm = mmap(NULL, sizeof(*mm), PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANON, -1, 0);
   	memset(mm, 0, sizeof(*mm));
   
   	pthread_mutexattr_init(&mm->mutexattr); //初始化mutex属性对象
   	pthread_mutexattr_setpshared(&mm->mutexattr, PTHREAD_PROCESS_SHARED); //修改属性为进程间共享
   
   	pthread_mutex_init(&mm->mutex, &mm->mutexattr); //初始化一把mutex锁
   
   	pid = fork();
   	if(pid == 0){
   		for(i = 0; i < 10; i++){
   			pthread_mutex_lock(&mm->mutex);
   			(mm->num)++;
   			printf("-Child------------num++   %d\n", mm->num);
   			pthread_mutex_unlock(&mm->mutex);
   			sleep(1);
   		}
   	} else if(pid > 0){
   		for(i = 0; i < 10; i++){
   			sleep(1);
   			pthread_mutex_lock(&mm->mutex);
   			mm->num+=2;
   			printf("-------parent-----num+=2  %d\n", mm->num);
   			pthread_mutex_unlock(&mm->mutex);
   		}
   		wait(NULL);
   	}
   
   	pthread_mutexattr_destroy(&mm->mutexattr); //销毁mutex属性对象
   	pthread_mutex_destroy(&mm->mutex); //销毁mutex
   	munmap(mm,sizeof(*mm)); //释放映射区
   	return 0;
   }
   ```

### 文件锁
- 借助`fcntl`函数来实现锁机制。操作文件的进程没有获得锁时，可以打开，但无法执行`read`、`write`操作。
- `fcntl`函数：获取、设置文件访问控制属性。
- `int fcntl(int fd, int cmd, ... /* arg */ );`

  - 参2：
    - `F_SETLK(struct flock *)`，设置文件锁（trylock）。
    - `F_SETLKW(struct flock *)`，设置文件锁（lock）W --> wait
    - `F_GETLK(struct flock *)`，获取文件锁

  - 参3：

     ```c
     struct flock {
        ...
        short l_type;    /* 锁的类型: F_RDLCK, F_WRLCK, F_UNLCK */
        short l_whence;  /* 偏移位置: SEEK_SET, SEEK_CUR, SEEK_END */
        off_t l_start;   /* 起始偏移：1000*/
        off_t l_len;     /* 长度：0表示整个文件加锁 */
        pid_t l_pid;     /* 持有该锁的进程ID：F_GETLK, F_OFD_GETLK */
        ...
     };
     ```

- 进程间文件锁示例	

   ```c
   #include <stdio.h>
   #include <sys/types.h>
   #include <sys/stat.h>
   #include <fcntl.h>
   #include <unistd.h>
   #include <stdlib.h>
   
   void sys_err(char *str){
       perror(str);
       exit(1);
   }
   
   int main(int argc, char *argv[])
   {
       int fd;
       struct flock f_lock;
   
       if(argc < 2){
           printf("./a.out filename\n");
           exit(1);
       }
   
       if((fd = open(argv[1], O_RDWR)) < 0)
           sys_err("open");
   
       f_lock.l_type = F_WRLCK; //选用写锁
       //f_lock.l_type = F_RDLCK; //选用读锁
   
       f_lock.l_whence = SEEK_SET;
       f_lock.l_start = 0;
       f_lock.l_len = 0; //0表示整个文件加锁
   
       fcntl(fd, F_SETLKW, &f_lock);
       printf("get flock\n");
   
       sleep(10);
   
       f_lock.l_type = F_UNLCK;
       fcntl(fd, F_SETLKW, &f_lock);
       printf("un flock\n");
   
       close(fd);
       return 0;
   }
   ```

   - 依然遵循”读共享、写独占“特性。但！如若进程不加锁直接操作文件，依然可访问成功，但数据势必出现混乱。
   - 【思考】：多线程中，可以使用文件锁吗？
   	- 多线程间共享文件夹描述符，而给文件加锁，是通过修改文件描述符所指向的文件结构体中的成员变量来实现的。因此，**多线程中无法使用文件锁**。

## 哲学家用餐模型分析
![哲学家吃饭问题图示](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e5%93%b2%e5%ad%a6%e5%ae%b6%e5%90%83%e9%a5%ad%e9%97%ae%e9%a2%98%e5%9b%be%e7%a4%ba.png)
### 多线程版
- 选用互斥锁`mutex`，如创建5个，`pthread_mutex_t m[5];`
- 模型抽象：
  - 5个哲学家 --> 5个线程； 5支筷子 --> 5把互斥锁； int left（左手）， right（右手）。

  - 5个哲学家使用相同的逻辑，可通用一个线程主函数，`void *tfn(void *arg)`，使用参数来表示线程编号：`int i = (int)arg;`

  - 哲学家线程根据编号知道自己第几个哲学家，而后选定锁，锁住，吃饭。否则哲学家thinking。

  - 5支筷子，在逻辑上形成环，分别对应5个哲学家。

      ```
      A		B		C		D		E
      	0		1		2		3		4
      ```


      ![哲学家吃饭问题](http://images.cnblogs.com/cnblogs_com/zfc2201/928468/o_%e5%93%b2%e5%ad%a6%e5%ae%b6%e5%90%83%e9%a5%ad%e9%97%ae%e9%a2%98.png)

  - 所以有：

     ```c
     if(i == 4)
     	left = i, right = 0;
     else
     	left = i, right = i + 1;
     ```

  - 振荡：如果每个人都攥着自己左手的锁，尝试去拿右手锁，拿不到则将锁释放。过会儿五个人又同时再攥着左手锁尝试拿右手锁，依然拿不到。如此往复形成另外一种极端死锁的现象--振荡。

  - 避免振荡现象：只需5个人中，任意一个人，拿锁的方向与其他人相逆即可（如：E，原来：左：4，右：0；现在：左：0，右：4）。

  - 所以以上if else语句应改为

     ```c
     if(i == 4)
     	left = 0, right = i;
     else
     	left = i, right = i + 1;
     ```

  - 而后，首先让哲学家尝试加左手锁：

     ```c
     while(1){
     	pthread_mutex_lock(&m[left]); 如果加锁成功，函数返回再加右手锁，如果失败，应立即释放左手锁，等待。
     	若左右手都加锁成功 --> 吃 --> 吃完 --> 释放锁（应先释放右手、再释放左手，是加锁顺序的逆序）
     }
     ```

  - 主线程（main）中，初始化5把锁，销毁5把锁，创建5个线程（并将i传递给线程主函数），回收5个线程。

  - 避免死锁的方法
    - 1、当得不到所有所需资源时，放弃已经获得的资源，等待。
    - 2、保证资源的获取顺序，要求每个线程获取资源的顺序一致。如：A获取顺序1、2、3；B顺序应也是1、2、3。若B为3、2、1则易出现死锁现象。

### 多进程版
- 相较于多线程需注意问题：

  - 需注意如何共享信号量（注意：坚决不能使用全局变量`sem_t s[5]`）
- 实现：
  - main函数中：
    - 循环`sem_init(&s[i], 0, 1); `将信号量初始值设为1，信号量变为互斥锁。
    - 循环`sem_destroy(&s[i]);`
    - 循环创建5个进程。`if(i<5)`中完成子进程的代码逻辑。
    - 循环回收5个子进程。

  - 子进程中：	

      ```c
      if(i == 4)
      	left = 0, right = 4;
      else
      	left = i, right = i + 1;
      
      while(1){
      	使用sem_wait(&s[left])锁左手，尝试锁右手，若成功 --> 吃；若不成功 --> 将左手锁释放。
      	吃完后，先释放右手锁，再释放左手锁。
      }
      ```

  - 【重点注意】
    - 直接将`sem_t s[5]`放在全局位置，试图用于子进程间共享是错误的！应将其定义放置与`mmap`共享映射区中。
    - main中：
    	- `sem_t *s = mmap(NULL, sizeof(sem_t)*5, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANON, -1, 0);`
    	- 使用方式：将`s`当成数组首地址看待，与使用数组`s[5]`没有差异。