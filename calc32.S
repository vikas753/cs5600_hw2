/*
  32-bit command line calculator assembly code
*/

 .global main
 .text

/*

C code

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

*/

/* variable mapping
   %eax : argc
   %eax : argv[1]
   %esi : op1
   %ebx : *argv
   %edi : op2 ,
   %dx  : operator symbol
*/

main:
  enter $0 , $0
  push %edx
  push %ebx
  push %ecx
  mov 8(%ebp) , %eax   # argc : %eax
  cmp $4 , %eax
  jne .usageLabel
  mov 12(%ebp) , %ebx

  mov 4(%ebx) , %eax   # argv[1] : %eax
  push %eax
  call atoi
  mov %eax , %esi
 
  mov 12(%ebx) , %eax  # argv[3] , op2
  push %eax
  call atoi
  mov %eax , %edi  
  
  mov 8(%ebx) , %edx   # argv[2] : operator symbol
  mov (%edx) , %edx
  mov $255 , %ecx
  and %edx , %ecx
  cmpb $'+' , %ecx
  je .addLabel
  cmpb $'-' , %ecx
  je .subLabel     
  cmpb $'*' , %ecx
  je .mulLabel    
  cmpb $'/' , %ecx
  je .divLabel
  jmp .usageLabel 
  jmp .endProgram
.addLabel : 
  mov %edi , %ebx
  add %esi , %edi
  push %edi
  push %ebx
  push %esi
  push $add_fmt
  call printf
  mov %edi , %eax
  jmp .endProgram
.subLabel :
  mov %edi , %ebx
  sub %esi , %edi
  neg %edi
  push %edi
  push %ebx
  push %esi
  push $sub_fmt
  call printf
  mov %edi , %eax
  jmp .endProgram
.mulLabel :
  mov %edi , %ebx
  imul %esi , %edi
  push %edi
  push %ebx
  push %esi
  push $mul_fmt
  call printf
  mov %edi , %eax
  jmp .endProgram
.divLabel : 
  mov $0 , %edx
  mov %esi , %eax
  idiv %edi
  push %eax
  push %edi
  push %esi
  push $div_fmt
  call printf
  jmp .endProgram
.usageLabel:
    push $usage_fmt
    call printf
    mov $-1 , %eax
.endProgram:
    pop %ecx
    pop %ebx
    pop %edx
    leave
    ret

    .data
usage_fmt:   .string "Usage: ./calc32 N op N\n "
add_fmt  :   .string "%ld + %ld = %ld\n"
sub_fmt  :   .string "%ld - %ld = %d\n"
mul_fmt  :   .string "%ld * %ld = %ld\n"
div_fmt  :   .string "%ld / %ld = %ld\n"
