#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main(void)
{
    pid_t pid;
    int fd[2];

    pipe(fd);
    pid = fork();

    //子进程
    if(pid == 0){
        //子进程从管道中读数据，关闭写端
        close(fd[1]);
        //让wc从管道中读取数据
        dup2(fd[0], STDIN_FILENO);
        //wc命令默认从标准读入取数据
        execlp("wc", "wc", "-l", NULL);
    }else {
        //父进程向管道中写数据，关闭读端
        close(fd[0]);
        //将ls的结果写入管道中
        dup2(fd[1], STDOUT_FILENO);
        //ls输出结果默认对应屏幕
        execlp("ls", "ls", NULL);
    }

    return 0;
}