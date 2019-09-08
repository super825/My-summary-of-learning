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