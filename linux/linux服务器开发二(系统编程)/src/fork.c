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
        printf("I'm child, pid = %u, ppid = %u \n", getpid(), getppid());
        sleep(1);
    }
    
    printf("father process exec end...");
    return 0;
}