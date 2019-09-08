#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char * argv[])
{
    char * val;
    const char * name = "ABD";
    
    val = getenv(name);
    printf("1, %s = %s\n", name, val);//ABD = NULL
    
    setenv(name, "day-and-night", 1);
    
    val = getenv(name);
    printf("2, %s = %s\n", name, val);//ABD = day-and-night
       
    int ret = unsetenv(name);
    printf("ret = %d \n", ret);//0
    
    val = getenv(name);
    printf("3, %s = %s \n", name, val);//ABD = NULL
 
    return 0;
}