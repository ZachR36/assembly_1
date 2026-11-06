.text

    .globl relation_code
    .type relation_code, @function
relation_code:
    movq $0, %rax
    cmpq %rsi, %rdi
    jge signed_not_smaller
    addq $1, %rax
    cmpq %rsi, %rdi
    jae unsigned_not_smaller
    addq $2, %rax
    jmp relation_done

signed_not_smaller:
    jae unsigned_not_smaller
    addq $2, %rax
    jmp relation_done
unsigned_not_smaller:
    jmp relation_done
relation_done:
    ret

    .globl clamp_long
    .type clamp_long, @function
clamp_long:
    movq $0, %rax
    cmpq %rsi, %rdi
    jl x_lower
    cmpq %rdx, %rdi
    jg x_higher
    jmp neither
x_lower:
    movq %rsi, %rax
    jmp clamp_done
x_higher:
    movq %rdx, %rax
    jmp clamp_done
neither:
    movq %rdi, %rax
    jmp clamp_done
clamp_done:
    ret

    .globl weighted_sum8
    .type weighted_sum8, @function
weighted_sum8:
    movq $0, %rax
    addq %rdi, %rax
    imulq $2, %rsi
    addq %rsi, %rax
    imulq $3, %rdx
    addq %rdx, %rax
    imulq $4, %rcx
    addq %rcx, %rax
    imulq $5, %r8
    addq %r8, %rax
    imulq $6, %r9
    addq %r9, %rax
    movq 8(%rsp), %rdi
    imulq $7, %rdi
    addq %rdi, %rax
    movq 16(%rsp), %rdi
    imulq $8, %rdi
    addq %rdi, %rax
    ret

    .globl alternating_sum
    .type alternating_sum, @function
alternating_sum:
    movq $0, %rax
    movq $1, %rsi
    cmpq $0, %rdi
    jg odd_case
    ret # If it's already 0, just return 0
odd_case:
    addq %rsi, %rax
    addq $1, %rsi
    cmpq %rsi, %rdi
    jge even_case
    jmp sum_complete
even_case:
    subq %rsi, %rax
    addq $1, %rsi
    cmpq %rsi, %rdi
    jge odd_case
    jmp sum_complete
sum_complete:
    ret


    .globl recursive_power
    .type recursive_power, @function
recursive_power:
    # Check base case (exponent == 0)
    # If base case, jump to base_case
    cmpq $0, %rsi
    je base_case

    # Save original base on stack
    # Decrement exponent
    pushq %rdi
    subq $1, %rsi
    call recursive_power

    # Restore original base
    movq (%rsp), %rdi
    addq $8, %rsp
    # Multiply recursive result by base
    imulq %rdi, %rax
    ret

base_case:
    movq $1, %rax
    ret

    .globl combine_helpers
    .type combine_helpers, @function
combine_helpers:
    movq $0, %rax
    pushq %rsi
    call helper_square
    movq (%rsp), %rdi
    movq %rax, (%rsp)
    call helper_affine
    addq (%rsp), %rax
    addq $8, %rsp
    ret

    .section .note.GNU-stack,"",@progbits
