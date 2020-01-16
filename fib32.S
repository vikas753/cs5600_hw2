######################################
#
#  32-bit fibonacci assembly code (i386)
#
#######################################

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
# Subroutine to calculate fibonacci of a number
# note : For every call of a function or subroutine it is preceded by
# push and pop of registers it would be using ( basically we are using
# caller save convention )
fib:
  enter $0 , $0
  push %ebx
  push %ecx 

  mov 8(%ebp) , %ebx
  cmp $0 , %ebx  # Check if the argument is zero then return 0 as result
  je .zeroLabel
  cmp $1 , %ebx   # Check if the argument is one then return 1 as result
  je .oneLabel
  dec %ebx       # below lines of code perform fib(n-1) + fib(n-2)
  push %ebx
  call fib       # fib(n-1)
  pop %ebx

  mov %eax , %ecx
  dec %ebx
  push %ecx           
  push %ebx
  call fib       # fib(n-2)
  pop %ebx
  pop %ecx

  add %ecx , %eax
  jmp .endFunction
.zeroLabel:
  mov $0 , %eax
  jmp .endFunction
.oneLabel:
  mov $1 , %eax
.endFunction:
  pop %ecx
  pop %ebx
  leave
  ret

/* variable mapping
  long xx : %eax
*/

main:
    enter $0, $0
    mov 8(%ebp) , %ecx
    cmp $2 , %ecx
    jne .usageLabel
    mov 12(%ebp), %ecx
    mov 4(%ecx), %eax
    push %eax
    call atoi
    cmp $0 , %eax
    jl .usageLabel   # Check if the value to the fibonacci is >= 0
    mov %eax , %ebx  # Make a temporary copy of the argument entered
    push %ebx
    push %eax
    call fib
    pop %ebx
    add $4, %esp

    push %eax
    push %ebx
    push $output_fmt
    call printf
    add $8, %esp
    jmp .endProgram

.usageLabel:
    push $usage_fmt
    call printf

.endProgram:

    leave
    ret

    .data
usage_fmt:   .string "Usage: ./fib N , where N >= 0 \n "
output_fmt:  .string "fib(%ld) = %ld\n"
