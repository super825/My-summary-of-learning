#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char * argv[])
{
    int fd;
    int flag;
    
    //�����ַ���
    char * p = "we are family!";
    cahr * q = "yes, man.";
    
    //ֻд�ķ�ʽ�ҿ��ļ�
    fd = open("test.txt", O_WRONLY);
    if(fd == -1)
    {
        perror("open");
        exit(1);
    }
    
    //�����µ����ݣ��ò��ֻḲ��ԭ���ɵ�����
    if(write(fd, p, strlen(p)) == -1)
    {
        perror("write");
        exit(1);
    }
    
    //ʹ��F_GETFL����õ��ļ�״̬��־
    flag = fcntl(fd, F_GETFL, 0);
    if(flag == -1)
    {
        perror("fcntl");
        exit(1);
    }
    
    //���ļ�״̬��־��ӡ�׷��д��ѡ��
    flag |= O_APPEND;
    //���ļ�״̬�޸�Ϊ׷��д
    if(fcntl(fd, F_SETFL, flag) == -1)
    {
        perror("fcntl -- append write");
        exit(1);
    }
    
    //�ٴ����������ݣ������ݻ�׷�ӵ������ݵĺ���
    if(write(fd, q, strlen(q)) == -1)
    {
        perror("write again");
        exit(1);
    }
    
    //�ر��ļ�
    close(fd);
    return 0;
}