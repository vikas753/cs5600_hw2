######################################
#
#  32-bit fibonacci assembly code (i386)
#
#######################################

    .global main

    .text
# Subroutine to calculate fibonacci of a number
# note : For every call of a function or subroutine it is preceded by
# push and pop of registers it would be using ( basically we are using
# caller save convention )
fib:
  enter $0 , $0
  
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
  leave
  ret

main:
    enter $0, $0

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
