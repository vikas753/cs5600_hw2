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
    printf("%s" , argv[2]);
    if(strcmp(argv[2], "+") || strcmp(argv[2], "*") ||  strcmp(argv[2], "/") || strcmp(argv[2], "-") )
    {
      int op1 = atoi(argv[1]);
      int op2 = atoi(argv[3]);

      if(strcmp(argv[2], "+"))
      {
        printf(" %ld + %ld = %ld " , op1 , op2 , (op1 + op2)); 
      }
      else if(strcmp(argv[2], "*"))
      {
	 printf(" %ld * %ld = %ld " , op1 , op2 , (op1 * op2)); 
      }
      else if(strcmp(argv[2], "-"))
      {
         printf(" %ld - %ld = %ld " , op1 , op2 , (op1 - op2)); 
      }      
      else if(strcmp(argv[2], "/"))
      {
	 printf(" %ld / %ld = %ld " , op1 , op2 , (op1 / op2)); 
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

