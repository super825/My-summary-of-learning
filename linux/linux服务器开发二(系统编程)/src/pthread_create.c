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
