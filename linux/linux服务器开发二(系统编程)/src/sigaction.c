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