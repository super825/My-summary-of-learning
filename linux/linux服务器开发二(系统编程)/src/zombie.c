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