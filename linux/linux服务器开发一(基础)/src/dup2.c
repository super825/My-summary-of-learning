#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main()
{
    int fd = open("english.txt", O_RDWR);
    if(fd == -1)
    {
        perror("open");
        exit(1);
    }
    
    int fd1 = open("a.txt", O_RDWR);
    if(fd1 == -1)
    {
        perror("open");
        exit(1);
    }
    
    printf("file open fd = %d\n", fd);
    printf("file open fd1 = %d\n", fd1);
    
    //����dup2��fd1��fdͬʱָ����a.txt
    int ret = dup2(fd1, fd);
    if(ret == -1)
    {
        perror("dup2");
        exit(1);
    }
    printf("current fd = %d\n", ret);
    char * buf = "��Ҫ������^_^����������������������\n";
    
    write(fd, buf, strlen(buf));
    write(fd1, "hello, world!", 13);
    
    close(fd);
    close(fd1);
    return 0;
}