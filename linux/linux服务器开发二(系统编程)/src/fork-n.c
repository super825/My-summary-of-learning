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
            //不上子进程现创建孙子进程
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