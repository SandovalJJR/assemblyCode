.section .bss
word: .space 5

.section .text
.global _start
_start:
    ldr X1, =word   // Save direction of word
    MOV W0, #72     // 
    STRB W0, [X1], 1
    MOV W0, #79
    STRB W0, [X1], 1
    MOV W0, #76
    STRB W0, [X1], 1
    MOV W0, #65
    STRB W0, [X1], 1
    MOV W0, 10
    STRB W0, [X1] 

    MOV X0, 1
    ldr X1, =word
    MOV X2, #5
    MOV X8, #64
    SVC 0

    MOV X8, #93
    SVC 0
    

    32 bits = 1 byte

    421

    421/10 -> 42
    421 - (42*10) = 421 - 420 = 1
    1 + 48 = 49

    [52][50][49][10]

    421\n223\n24$ 

    long = 3
    x = 1

    
    
