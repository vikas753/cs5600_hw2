    .global main

    .text
main:
    enter $0, $0

    mov 12(%ebp), %ecx
    mov 4(%ecx), %eax
    push %eax
    call atoi
    add $4, %esp

    push %eax
    push $output_fmt
    call printf
    add $8, %esp

    leave
    ret

    .data
output_fmt:  .string "fib(3) = %ld\n"
