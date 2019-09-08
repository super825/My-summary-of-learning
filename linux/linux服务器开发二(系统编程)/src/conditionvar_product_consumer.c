/*借助条件变量模拟，生产者-消费者问题*/
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <pthread.h>

/*链表作为共享数据，需被互斥量保护*/
struct msg {
    struct msg *next;
    int num;
};

struct msg *head;
struct msg *mp;

/*静态初始化一个条件变量和一个互斥量*/
pthread_cond_t has_product = PTHREAD_COND_INITIALIZER;
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

void *consumer(void *p)
{
    for(;;){
        pthread_mutex_lock(&lock);
        while(head == NULL){ //头指针为空，说明没有节点
            pthread_cond_wait(&has_product, &lock);
        }
        mp = head;
        head = mp->next; //模拟消费掉一个产品
        pthread_mutex_unlock(&lock);

        printf("-Consume ---%d\n", mp->num);
        free(mp);
        sleep(rand() % 5);
    }
}

void *producer(void *p)
{
    for(;;){
        mp = malloc(sizeof(struct msg));
        //模拟生产一个产品
        mp->num = rand() % 1000 + 1;
        printf("-Produce ---%d\n", mp->num);

        pthread_mutex_lock(&lock);
        mp->next = head;
        head = mp;
        pthread_mutex_unlock(&lock);
        //将等待在该条件变量上的一个线程唤醒
        pthread_cond_signal(&has_product);
        sleep(rand() % 5);
    }
}

int main(int argc, char * argv)
{
    pthread_t pid, cid;
    srand(time(NULL));

    pthread_create(&pid, NULL, producer, NULL);
    pthread_create(&cid, NULL, consumer, NULL);

    pthread_join(pid, NULL);
    pthread_join(cid, NULL);

    return 0;
}
