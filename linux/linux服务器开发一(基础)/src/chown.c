#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char * argv[])
{
    if(argc < 2)
    {
        printf("chown filename\n");
        exit(1);
    }
    
    int ret = chown(argv[1], 116, 125);
    if(ret == -1)
    {
        perror("chown");
        exit(1);
    }
    return 0;
}