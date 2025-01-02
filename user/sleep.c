#include "kernel/types.h"
#include"user/user.h"



int
main(int argc, char *argv[])
{
  

  if(argc <= 1){
    fprintf(1,"请输入时间，单位ms");
    exit(0);
  }
  sleep(atoi(argv[1]));



  exit(0);
}

