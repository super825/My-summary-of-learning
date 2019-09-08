#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <string.h>

void *thread_func(void *arg)
{
    pthread_exit((void *)11);
}

int main()
{
    pthread_t tid;
    int ret;
    pthread_attr_t attr;

    ret = pthread_attr_init(&attr);
    if(ret != 0){
        fprintf(stderr, "pthread_attr_init error:%s\n", strerror(ret));
        exit(1);
    }

    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);

    ret = pthread_create(&tid, &attr, thread_func, NULL);
    if(ret != 0){
        fprintf(stderr, "pthread_create error:%s\n", strerror(ret));
        exit(1);
    }

    ret = pthread_join(tid, NULL);
    if(ret != 0){
        fprintf(stderr, "pthread_join error:%s\n", strerror(ret));
        exit(1);
    }

    pthread_exit((void *)1);
    return 0;
}
