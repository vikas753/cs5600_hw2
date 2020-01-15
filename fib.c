////////////////////////////////////
//
// Fibonacci of a number 
//
////////////////////////////////////

#include <stdio.h>
#include <stdlib.h>

long fib(long arg)
{
  if(arg == 0)
  { 
    return 0;
  }	  
  else if(arg == 1)
  {
    return 1;
  }
  else
  {
    return fib(arg-1) + fib(arg-2);	  
  }
}

int
main(int argc, char* argv[])
{
    long xx = atol(argv[1]);
    if(xx < 0)
    {
      printf("Usage: ./fib N , where N >= 0 \n");	    
    }
    else
    {    
      long fibResult = fib(xx);
      printf("fib(%ld) = %ld\n", xx , fibResult);
    }
    return 0;
}

