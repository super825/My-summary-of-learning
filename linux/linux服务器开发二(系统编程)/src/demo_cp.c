#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/mman.h>

#difine T_NUM 50
#define ITEMS 50

void err_sys(void *str)
{
    perror(str);
    exit(1);
}

void err_usr(char *str)
{
    fputs(str, stderr);
    exit(1);
}

typedef struct{
    int off, size, t_no;
} arg_t;

char *s, *d;
int *done;
int n = T_NUM;

void *tfn(void *arg)
{
    arg_t *arg_p;
    int i;
    char *p, *q;

    arg_p = (arg_t *)arg;
    p = s + arg_p->off, q = d + arg_p->off;
    for(i = 0; i < arg_p->size; i++){
        *q++ = *p++;
        done[arg_p->t_no]++;
        usleep(10);
    }

    return NULL;
}

void *display(void *arg)
{



}
