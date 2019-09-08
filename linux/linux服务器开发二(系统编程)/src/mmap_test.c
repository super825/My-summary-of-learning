#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mmap.h>

void sys_err(char *str)
{
    perror(str);
    exit(1);
}

int main(int argc, char *argv[])
{
    char *p = NULL;
    int fd = open("test.txt", O_CREAT|O_REWR, 0644);
    if(fd < 0)
    {
        sys_err("open error");
    }

    int len = ftruncate(fd, 4);
    if(len == -1)
    {
        sys_err("ftruncate error");
    }

    p = mmap(NULL, 4, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
    if(p == MAP_FAILED)
    {
        sys_err("mmap error");
    }

    strcpy(p, "abc");  //写数据

    int ret = munmap(p, 4);
    if(ret == -1)
    {
        sys_err("munmap error");
    }
    close(fd);

    return 0;
}