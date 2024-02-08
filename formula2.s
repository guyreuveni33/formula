#206398596 Guy Reuveni
#208189126 Niv Swisa

.section .data
    .align 16
    one_vector: .float 1.0, 1.0, 1.0, 1.0
.text
.global formula2
.type formula2,@function
  //float x[] = {1.0,2.0,5.0,4.0,2.0,2.0,2.0,2.0};
  //float y[] = {3.0,1.0,2.0,3.0,2.0,2.0,2.0,1.0};
 #5,2,10,2,10,2,5,2
formula2:
    push %rbp
    movq %rsp, %rbp
    vmovaps one_vector(%rip) , %xmm7    # xmm7=(1.0,1.0...)
    vmovaps one_vector(%rip) , %xmm4    # xmm4=(1.0,1.0...)

    xor %r8,%r8
    xor %r9,%r9
    xor %rcx,%rcx
    xor %rax,%rax
    movq %rdx,%rax
    xor %rdx,%rdx
    movq $4,%rcx
    idivq %rcx
    cmpq $0,%rax
    je conditions_one
    movq %rax,%r9
    vmovaps one_vector(%rip) , %xmm8    # xmm7=(1.0,1.0...)
    loop_low_value:
    vmovaps (%rdi,%r8), %xmm0
    vmovaps (%rsi,%r8), %xmm1
    addq $16,%r8
    vmovaps one_vector(%rip) , %xmm7    # xmm7=(1.0,1.0...)
    vsubps %xmm1,%xmm0,%xmm3 #(Xi-Yi)
    vmulps %xmm3,%xmm3,%xmm3 #(Xi-Yi)^2
    vaddps %xmm7,%xmm3,%xmm3 #(Xi-Yi)^2+1
    vshufps $0x4E, %xmm3, %xmm3, %xmm6
    vmulps %xmm6, %xmm3, %xmm3
    vshufps $0xB1, %xmm3, %xmm3, %xmm6
    vmulps %xmm6, %xmm3, %xmm3
    xor %r10,%r10
    vmulps %xmm3, %xmm8,%xmm8
    decq %rax
    cmpq $0,%rax
    jne loop_low_value
    vmovaps one_vector(%rip) , %xmm4    # xmm7=(1.0,1.0...)
    //subq $16,%r8
    conditions_one:
    cmpq $0, %rdx
    je next_step
    cmpq $1, %rdx
    je one_remainder
    cmpq $2, %rdx
    je two_remainder

    three_remainder:
    xorq %rax,%rax
    movl (%rdi,%r8), %eax
    movq %rax,%xmm0
    xorq %rax,%rax
    movl (%rsi,%r8), %eax
    movq %rax,%xmm1
    addq $4,%r8

    vsubps %xmm1,%xmm0,%xmm3 #(Xi-Yi)
    vmulps %xmm3,%xmm3,%xmm3 #(Xi-Yi)^2
    vaddps %xmm7,%xmm3,%xmm3 #(Xi-Yi)^2+1
    vmulps %xmm3,%xmm4,%xmm4

    two_remainder:
    xorq %rax,%rax
    movl (%rdi,%r8), %eax
    movq %rax,%xmm0
    xorq %rax,%rax
    movl (%rsi,%r8), %eax
    movq %rax,%xmm1
    addq $4,%r8

    vsubps %xmm1,%xmm0,%xmm3 #(Xi-Yi)
    vmulps %xmm3,%xmm3,%xmm3 #(Xi-Yi)^2
    vaddps %xmm7,%xmm3,%xmm3 #(Xi-Yi)^2+1
    vmulps %xmm3,%xmm4,%xmm4

    one_remainder:
    xorq %rax,%rax
    movl (%rdi,%r8), %eax
    movq %rax,%xmm0
    xorq %rax,%rax
    movl (%rsi,%r8), %eax
    movq %rax,%xmm1

    vsubps %xmm1,%xmm0,%xmm3 #(Xi-Yi)
    vmulps %xmm3,%xmm3,%xmm3 #(Xi-Yi)^2
    vaddps %xmm7,%xmm3,%xmm3 #(Xi-Yi)^2+1
    vmulps %xmm3,%xmm4,%xmm4
    cmpq $0,%r9
    je conditions_three
    vmulps %xmm4, %xmm8,%xmm8
    shufps $0x0,%xmm8,%xmm8
    next_step:
    xorq %r8,%r8

    cmpq $0,%r9
    je conditions_two
    pxor %xmm2,%xmm2
    loop_upper_value:
    vmovaps (%rdi,%r8), %xmm0
    vmovaps (%rsi,%r8), %xmm1
    addq $16,%r8
    pxor %xmm15,%xmm15
    vmulps %xmm0,%xmm1,%xmm15 #Xk*Yk
    vdivps %xmm8,%xmm15,%xmm15
    haddps %xmm15,%xmm15 #sum_x
    haddps %xmm15,%xmm15 #sum_x
    vaddps %xmm15,%xmm2,%xmm2
    decq %r9
    cmpq $0,%r9
    jne loop_upper_value
    conditions_two:
    cmpq $0, %rdx
    je finish
    cmpq $1, %rdx
    je one_left
    cmpq $2, %rdx
    je two_left

    three_left:
    xorq %rax,%rax
    movl (%rdi,%r8), %eax
    movq %rax,%xmm0
    xorq %rax,%rax
    movl (%rsi,%r8), %eax
    movq %rax,%xmm1
    addq $4,%r8

    vmulps %xmm0,%xmm1,%xmm10 #Xk*Yk
    vdivps %xmm8,%xmm10,%xmm10
    vaddps %xmm10,%xmm2,%xmm2 #sum_x
    //haddps %xmm2,%xmm2 #sum_x

    two_left:
    xorq %rax,%rax
    movl (%rdi,%r8), %eax
    movq %rax,%xmm0
    xorq %rax,%rax
    movl (%rsi,%r8), %eax
    movq %rax,%xmm1
    addq $4,%r8

   vmulps %xmm0,%xmm1,%xmm10 #Xk*Yk
   vdivps %xmm8,%xmm10,%xmm10
   vaddps %xmm10,%xmm2,%xmm2 #sum_x

    one_left:
    xorq %rax,%rax
    movl (%rdi,%r8), %eax
    movq %rax,%xmm0
    xorq %rax,%rax
    movl (%rsi,%r8), %eax
    movq %rax,%xmm1

    vmulps %xmm0,%xmm1,%xmm10 #Xk*Yk
    vdivps %xmm8,%xmm10,%xmm10
    vaddps %xmm10,%xmm2,%xmm2 #sum_x
    jmp finish

conditions_three:
    xorq %r8,%r8
    cmpq $0, %rdx
    je finish
    cmpq $1, %rdx
    je one_left_small
    cmpq $2, %rdx
    je two_left_small

three_left_small:
    xorq %rax,%rax
    movl (%rdi,%r8), %eax
    movq %rax,%xmm0
    xorq %rax,%rax
    movl (%rsi,%r8), %eax
    movq %rax,%xmm1
    addq $4,%r8

    vmulps %xmm0,%xmm1,%xmm10 #Xk*Yk
    vdivps %xmm4,%xmm10,%xmm10
    vaddps %xmm10,%xmm2,%xmm2 #sum_x
    //haddps %xmm2,%xmm2 #sum_x

    two_left_small:
    xorq %rax,%rax
    movl (%rdi,%r8), %eax
    movq %rax,%xmm0
    xorq %rax,%rax
    movl (%rsi,%r8), %eax
    movq %rax,%xmm1
    addq $4,%r8

    vmulps %xmm0,%xmm1,%xmm10 #Xk*Yk
    vdivps %xmm4,%xmm10,%xmm10
    vaddps %xmm10,%xmm2,%xmm2 #sum_x

    one_left_small:
    xorq %rax,%rax
    movl (%rdi,%r8), %eax
    movq %rax,%xmm0
    xorq %rax,%rax
    movl (%rsi,%r8), %eax
    movq %rax,%xmm1

    vmulps %xmm0,%xmm1,%xmm10 #Xk*Yk
    vdivps %xmm4,%xmm10,%xmm10
    vaddps %xmm10,%xmm2,%xmm2 #sum_x


    finish:
    pxor %xmm0,%xmm0
    movq %xmm2, %xmm0
    movq %rbp, %rsp
    pop %rbp
    ret
