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

/* In case of an error , return code would be 1 */
int
main(int argc, char* argv[])
{
    /* Number of arguments should be 2 */
    if(argc == 2)
    {
        long xx = atol(argv[1]);
        if(xx < 0)
        {
            printf("Usage: ./fib N , where N >= 0\n");
            return 1;      
        }
        else
        {    
            long fibResult = fib(xx);
            printf("fib(%ld) = %ld\n", xx , fibResult);
            return 0;
	}
    }
    else
    {
	printf("Usage: ./fib N , where N >= 0\n");
        return 1;
    }
}

