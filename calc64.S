    .global main
     
    .text
/*
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
        printf("%ld + %ld = %d \n" , op1 , op2 , (op1 + op2)); 
      }
      else if(argv[2][0] == '*')
      {
	 printf(" %ld * %ld = %d \n" , op1 , op2 , (op1 * op2)); 
      }
      else if(argv[2][0] == '-')
      {
         printf(" %ld - %ld = %d \n" , op1 , op2 , (op1 - op2)); 
      }      
      else if(argv[2][0] == '/')
      {
	 printf(" %ld / %ld = %d \n" , op1 , op2 , (op1 / op2)); 
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
*/

main:
  enter $0 , $0
  cmp $4 , %rdi # Number of arguments should be 4 in argc : %rdi
  jne .usageLabel
  cmpb $''+' , %dl # Check if the operand , argv[2] is '+' 
  je .addLabel
  jmp .usageLabel
.addLabel:
  mov %rcx , %rdx  # Make a temporary copy of argv[3] in %rdx
  add %rsi , %rcx
  mov $add_fmt , %rdi
  jmp .endProgram

.usageLabel:   ## Usage subroutine
  mov $usage_fmt, %rdi
  mov $0, %al
  call printf

.endProgram:
  leave
  ret

  .data
output_fmt:  .string "fib(%ld) = %ld\n"
usage_fmt :  .string "./calc64 N op N \n"
add_fmt   :  .string " %ld + %ld = %ld " 
