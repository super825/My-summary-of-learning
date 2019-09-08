#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <dirent.h>

int get_file_count(char * root)
{
    DIR * dir = NULL;
    dir = opendir(root);
    if(dir == NULL)
    {
        perror("opendir");
        exit(1);
    }
    
    struct dirent * ptr = NULL;
    char path[1024] = {0};
    int total = 0;
    while(ptr = readdir(dir) != NULL)
    {
        //过滤.和..
        if(strcmp(ptr->d_name, ".") == 0 || strcmp(ptr->d_name, "..") == 0)
        {
            continue;
        }
        //如果是目录
        if(ptr->d_type == DT_DIR)
        {
            sprintf(path, "%s/%s", root, ptr->d_name);
            total += getFileNum(path);
        }
        //如果是文件
        if(ptr->d_type == DT_REG)
        {
            total++;            
        }
    }
    
    closedir(dir);
    return total;
}

int main(int argc, char * argv[])
{
    if(argc < 2)
    {
        printf("./a.out dir\n");
        exit(1);
    }
    
    int total = get_file_count(argv[1]);
    printf("%s has file numbers %d\n", argv[1], total);
    
    return 0;
}