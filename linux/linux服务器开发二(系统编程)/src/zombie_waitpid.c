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
        //waitpid(q, NULL, 0);//回收第三个子进程
        //while(waitpid(-1, NULL, 0)); //等价于wait(NULl),阻塞回收任意子进程
        do
        {
            //非阻塞回收任意子进程
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