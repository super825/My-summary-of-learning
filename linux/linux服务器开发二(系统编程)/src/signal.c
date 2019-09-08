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