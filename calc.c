////////////////////////////////////
//
// Simple command line calculator 
//
////////////////////////////////////

#include <stdio.h>
#include <stdlib.h>

#define NUM_VALID_ARGS 4

void usage()
{
   printf("Usage: ./calc N op N  \n\t");
}

int
main(int argc, char* argv[])
{
  if(argc!=NUM_VALID_ARGS) 
  {
    usage();	  
  }
  else
  { 
    if(strcmp(argv[2], "+") || strcmp(argv[2], "*") ||  strcmp(argv[2], "/") || strcmp(argv[2], "-") )
    {
      int op1 = atoi(argv[1]);
      int op2 = atoi(argv[3]);

      if(argv[2][0] == '+')
      {
        printf("%ld + %ld = %ld \n" , op1 , op2 , (op1 + op2)); 
      }
      else if(argv[2][0] == '*')
      {
	 printf("%ld * %ld = %ld \n" , op1 , op2 , (op1 * op2)); 
      }
      else if(argv[2][0] == '-')
      {
         printf("%ld - %ld = %ld \n" , op1 , op2 , (op1 - op2)); 
      }      
      else if(argv[2][0] == '/')
      {
	 printf("%ld / %ld = %ld \n" , op1 , op2 , (op1 / op2)); 
      }
      else
      {
	usage();      
      }
    }
    else
    {
      usage();	    
    }    
  }
  return 0;
}

