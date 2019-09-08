#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <string.h>

void *thread_func(void *arg)
{
    int i = (int)arg;
    printf("%dth thread: thread id = %lu, pid = %u\n", i+1, pthread_self(), getpid());
    return NULL;
}

int main()
{
    pthread_t tid;
    int ret, i;

    for (i = 0; i<5; i++){
        ret = pthread_create(&tid, NULL, thread_func, (void *)i);
        if(ret != 0){
            fprintf(stderr, "pthread_create error:%s\n", strerror(ret));
            exit(1);
        }
    }

    pthread_exit(NULL);
}
