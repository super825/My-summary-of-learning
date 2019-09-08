#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char * argv[])
{
    pid_t pid;
    pid = fork();
    if(pid == -1)
    {
        perror("fork error");
        exit(1);
    }
    else if (pid > 0)
    {
        sleep(1);
        printf("parent");
    }
    else
    {
        execlp("ls", "ls", "-l", "-a", NULL);
    }
    
    return 0;
}