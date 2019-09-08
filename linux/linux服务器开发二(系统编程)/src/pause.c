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

    ret = alarm(0); //闹钟清零
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