#######################################
##
##  Fibonacci of a number assembly
##  code ( AMD64 ASM )
##
######################################

  .global main

  .text
/*
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
*/

fib:
  enter $0 , $0
  push %rbx
  push %rcx
  mov $0 , %rbx
  cmp %rbx , %rdi  # Check if an argument is >= 0 , rdx : arg
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
 
/*
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
*/

main:
  enter $0, $0
  mov 8(%rsi) , %rdi
  mov $0 , %rbx
  call atol 
  mov %rax, %rdi     ## variable xx
  cmp %rbx , %rdi    ## Check if the source argument is >= 0 else goto usage .
   
  jl .usageLabel  
  mov %rdi , %r8
  call fib
  mov %rax , %rdx    ## rax : fibResult
  mov %r8 , %rsi
  mov $output_fmt, %rdi
  mov $0, %al
  call printf
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
usage_fmt :  .string "Usage: ./fib N , where N > = 0 \n"
