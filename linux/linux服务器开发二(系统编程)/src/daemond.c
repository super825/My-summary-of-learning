#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(void)
{
    pid_t pid, sid;
    int ret;

    pid = fork();
    if(pid > 0)
    {
        exit(1);
    }

    sid = setsid();

    ret = chdir("/home/super/");
    if(ret == -1)
    {
        perror("chdir error");
        exit(1);
    }

    umask(0022);

    close(STDIN_FILENO);
    open("/dev/null", O_RDWR);
    dup2(0, STDOUT_FILENO);
    dup2(0, STDERR_FILENO);

    while(1);

    return 0;
}
