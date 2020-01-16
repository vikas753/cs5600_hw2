#######################################
##
##  Fibonacci of a number assembly
##  code ( AMD64 ASM )
##
######################################

  .global main

#if 0
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
#endif

  .text
fib:
  enter $0 , $0
  push %rbx
  push %rcx
  mov $0 , %rbx
  cmp %rbx , %rdi  # Check if an argument is >= 0 
  je .zeroLabel     # if arg == 0 , then return 0

  mov $1 , %rbx
  cmp %rbx , %rdi
  je .oneLabel      # if arg == 1 , then return 1

  dec %rdi         # calculate fib(n-1)
  mov %rdi , %rbx
  call fib
  mov %rax , %rcx

  mov %rbx , %rdi
  dec %rdi         # calculate fib(n-2)
  call fib
  add %rcx , %rax  # final fibonacci value = fib(n-1) + fib(n-2)
  jmp .endFunction

  .oneLabel:
  mov $1 , %rax
  jmp .endFunction

  .zeroLabel:
  mov $0 , %rax

  .endFunction:
  pop %rcx
  pop %rbx
  leave 
  ret 

/* variable mapping
   long xx : %rdi  
*/

main:
  enter $0, $0
  push %rbx
  push %r8
  add $16 , %rsp
  cmp $2 , %rdi
  jne .usageLabel
  mov 8(%rsi) , %rdi
  mov $0 , %rbx
  call atol 
  mov %rax, %rdi
  cmp %rbx , %rdi    ## Check if the source argument is >= 0 else goto usage .
   
  jl .usageLabel  
  mov %rdi , %r8
  call fib
  mov %rax , %rdx
  mov %r8 , %rsi
  mov $output_fmt, %rdi
  mov $0, %al
  call printf
  jmp .endProgram

.usageLabel:   ## Usage subroutine
  mov $usage_fmt, %rdi
  mov $0, %al
  call printf
  mov $1 , %rax

.endProgram:
  pop %r8
  pop %rbx
  leave
  ret

  .data
output_fmt:  .string "fib(%ld) = %ld\n"
usage_fmt :  .string "Usage: ./fib N , where N > = 0 \n"
