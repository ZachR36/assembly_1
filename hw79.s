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
    # TODO: Problem 3
    movq $0, %rax
    ret

    .globl alternating_sum
    .type alternating_sum, @function
alternating_sum:
    # TODO: Problem 4
    movq $0, %rax
    ret

    .globl recursive_power
    .type recursive_power, @function
recursive_power:
    # TODO: Problem 5
    movq $0, %rax
    ret

    .globl combine_helpers
    .type combine_helpers, @function
combine_helpers:
    # TODO: Problem 6
    movq $0, %rax
    ret

    .section .note.GNU-stack,"",@progbits
