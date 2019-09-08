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