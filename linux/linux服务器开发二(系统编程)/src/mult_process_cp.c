#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/wait.h>

void err_int(int ret, const char *err)
{
    if(ret == -1)
    {
        perror(err);
        exit(1);
    }
}

void err_str(char *ret, const char *err)
{
    if(ret == MAP_FAILED)
    {
        perror(err);
        exit(1);
    }
}

int main(int argc, char *argv[])
{

}
