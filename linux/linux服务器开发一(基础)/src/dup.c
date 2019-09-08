#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main()
{
    int fd = open("a.txt", O_RDWR);
    if(fd == -1)
    {
        perror("open");
        exit(1);
    }
    
    printf("file open fd = %d\n", fd);
    
    //�ҵ������ļ���������==��һ��==���õ��ļ�������
    //������ָ�����ļ����Ƶ����������󣬷������������
    int ret = dup(fd);
    if(ret == -1)
    {
        perror("dup");
        exit(1);
    }
    printf("dup fd = %d\n", ret);
    char * buf = "���Ǻ��������ľȱ��𣿣���\n";
    char * buf1 = "���ү�ģ����ǳ���Գ������\n";
    
    write(fd, buf, strlen(buf));
    write(ret, buf1, strlen(buf1));
    
    close(fd);
    return 0;
}