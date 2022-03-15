main:
        push    {r7, lr}
        sub     sp, sp, #16
        add     r7, sp, #0
        mov     r3, #10
        str     r3, [r7, #12]
        mov     r3, #10
        str     r3, [r7, #8]
        ldr     r0, [r7, #12]
        ldr     r1, [r7, #8]
        bl      multiplication(int, int)
        str     r0, [r7, #4]
        ldr     r0, [r7, #4]
        ldr     r1, [r7, #12]
        bl      addition(int, int)
        str     r0, [r7, #4]
        ldr     r0, [r7, #12]
        ldr     r1, [r7, #4]
        bl      subtraction(int, int)
        str     r0, [r7, #4]
        ldr     r0, [r7, #12]
        ldr     r1, [r7, #4]
        bl      division(int, int)
        str     r0, [r7, #4]
        ldr     r3, [r7, #4]
        mov     r0, r3
        add     r7, r7, #16
        mov     sp, r7
        pop     {r7, pc}
addition(int, int):
        push    {r7}
        sub     sp, sp, #20
        add     r7, sp, #0
        str     r0, [r7, #4]
        str     r1, [r7, #0]
        ldr     r2, [r7, #4]
        ldr     r3, [r7, #0]
        adds    r3, r2, r3
        str     r3, [r7, #12]
        ldr     r3, [r7, #12]
        mov     r0, r3
        add     r7, r7, #20
        mov     sp, r7
        pop     {r7}
        bx      lr
subtraction(int, int):
        push    {r7}
        sub     sp, sp, #20
        add     r7, sp, #0
        str     r0, [r7, #4]
        str     r1, [r7, #0]
        ldr     r2, [r7, #0]
        ldr     r3, [r7, #4]
        subs    r3, r2, r3
        str     r3, [r7, #12]
        ldr     r3, [r7, #12]
        mov     r0, r3
        add     r7, r7, #20
        mov     sp, r7
        pop     {r7}
        bx      lr
multiplication(int, int):
        push    {r7}
        sub     sp, sp, #20
        add     r7, sp, #0
        str     r0, [r7, #4]
        str     r1, [r7, #0]
        ldr     r3, [r7, #4]
        ldr     r2, [r7, #0]
        mul     r3, r2, r3
        str     r3, [r7, #12]
        ldr     r3, [r7, #12]
        mov     r0, r3
        add     r7, r7, #20
        mov     sp, r7
        pop     {r7}
        bx      lr
division(int, int):
        push    {r7, lr}
        sub     sp, sp, #16
        add     r7, sp, #0
        str     r0, [r7, #4]
        str     r1, [r7, #0]
        ldr     r0, [r7, #0]
        ldr     r1, [r7, #4]
        bl      __aeabi_idiv
        mov     r3, r0
        str     r3, [r7, #12]
        ldr     r3, [r7, #12]
        mov     r0, r3
        add     r7, r7, #16
        mov     sp, r7
        pop     {r7, pc}
