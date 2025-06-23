.global _start
.extern itoa
.extern printNum

.section .text
_start:
    mov x19, #244
    bl itoa
    bl printNum

    mov x19, #40000
    bl itoa
    bl printNum

    mov x19, #23048
    bl itoa
    bl printNum

    mov x19, #3500
    bl itoa
    bl printNum

    mov x19, #2341
    bl itoa
    bl printNum

    mov x0, #0
    mov x8, #93
    svc 0
