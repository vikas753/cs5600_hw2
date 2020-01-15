/*

   AMD64 assembly version of commmand line
   calculator

*/

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

/*
variable mapping
  argc : %rdi
  argv : %rsi
  op1  : %r8
  op2  : %rsi
*/

main:
  enter $0 , $0
  cmp $4 , %rdi
  jne .usageLabel
  mov %rsi , %r8
  mov 16(%rsi) , %rcx   # argv[2]
  mov (%rcx) , %rcx     # value of argv[2]
  mov 8(%rsi) , %rdi    # argv[1]
  push %rcx
  push %rsi
  call atol             # Convert argv[1] to integer op1
  pop %rsi
  mov 24(%rsi) , %rdi
  mov %rax , %rbx       # r8 : op1
  call atol             # Convert argv[3] to integer op2
  pop %rcx
  mov %rbx , %rsi
  mov %rax , %rdx
  cmpb $43 , %cl # argv[2] : %cl , check for +
  je .addLabel
  cmpb $45 , %cl # argv[2] : %cl , check for -
  je .minusLabel
  cmpb $42 , %cl # argv[2] : %cl , check for *
  je .productLabel
  cmpb $47 , %cl # argv[2] : %cl , check for *
  je .divLabel
  jmp .usageLabel
.addLabel:
  mov %rdx , %r8        # r8 : op1
  add %rsi , %r8        # rsi : op2 + r8 : op1 -> add : r8
  mov %r8 , %rcx
  mov $add_fmt, %rdi
  mov $0, %al
  call printf
  jmp .endProgram
.minusLabel:
  mov %rsi , %r8        # r8 : op1
  sub %rdx , %r8        # rsi : op2 - r8 : op1 -> subtract : r8
  mov %r8 , %rcx
  mov $sub_fmt, %rdi
  mov $0, %al
  call printf
  jmp .endProgram
.productLabel:
  mov %rsi , %r8        # r8 : op1
  imul %rdx , %r8        # rsi : op2 * r8 : op1 -> product : r8
  mov %r8 , %rcx
  mov $mul_fmt, %rdi
  mov $0, %al
  call printf
  jmp .endProgram
.divLabel:
  mov %rdx , %r8         # r8  : op2
  mov %rsi , %rax        # rax : op1
  mov $0 , %rdx          # rdx : prefix number
  idiv %r8        # rdx : rax :: op1 / r8 : op2 -> divided value : r8
  mov %r8 , %rdx
  mov %rax , %rcx
  mov $div_fmt, %rdi
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
add_fmt:  .string "%ld + %ld = %ld\n"
sub_fmt:  .string "%ld - %ld = %d\n"
mul_fmt:  .string "%ld * %ld = %d\n"
div_fmt:  .string "%ld / %ld = %d\n"
usage_fmt :  .string "./calc N op N \n"
test_fmt : .string "%ld \n"
