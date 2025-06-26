.global _start

.section .bss
outputNumber: .space 1
inputSelection: .space 2

.section .data
headPointerMsg: .asciz "\n-> Ahora estas apuntando a la cabeza"
end_headPointerMsg:
.equ size_headPointerMsg, end_headPointerMsg - headPointerMsg

actualValueMsg: .asciz "\nValor actual: "
end_actualValueMsg:
.equ size_actualValueMsg, end_actualValueMsg - actualValueMsg

menuMsg: .asciz "\n\n1. Ir al numero siguiente\n2. Volver a la cabeza\n0. Salir.\nElige una opcion: "
end_menuMsg:
.equ size_menuMsg, end_menuMsg-menuMsg

menuFinalMsg: .asciz "\n\n1. Volver a la cabeza\n2. Salir.\nHaz llegado al final de la lista, elige una opcion: "
end_menuFinalMsg:
.equ size_menuFinalMsg, end_menuFinalMsg-menuFinalMsg


.section .text
_start:
    // valores a insertar
    mov x5, 3
    mov x4, 2
    mov x3, 1
    mov x6, 0               // offset in stack

    sub sp, sp, 32          // add space to stack
    str x5, [sp, 16]        // add first value to linked list (x5 = 3)
    str x4, [sp, 8]         // add second value to linked list (x4 = 2)
    str x3, [sp]            // add third value to linked list (x3 = 1)
    ldr x5, =outputNumber

head:
    mov x6, 0
    mov x0, 1
    ldr x1, =headPointerMsg
    mov x2, size_headPointerMsg
    mov x8, 64
    svc 0

    b printActualValue

printActualValue:
    ldr x7, [sp, x6]
    add x7, x7, 48
    strb w7, [x5]

    mov x0, 1
    ldr x1, =actualValueMsg
    mov x2, size_actualValueMsg
    mov x8, 64
    svc 0

    mov x0, 1
    ldr x1, =outputNumber
    mov x2, 1
    mov x8, 64
    svc 0

    cmp x6, #16
    b.eq printFinalMenu

    b printMainMenu

printMainMenu:
    mov x0, 1
    ldr x1, =menuMsg
    mov x2, size_menuMsg
    mov x8, 64
    svc 0

    mov x0, 0
    ldr x1, =inputSelection
    mov x2, 2
    mov x8, 63
    svc 0

    ldr x3, =inputSelection
    ldrb w7, [x3]

    cmp w7, #49
    b.eq siguiente

    cmp w7, #50
    b.eq head

    cmp w7, #51
    b.eq exit

    b printMainMenu

printFinalMenu:
    mov x0, 1
    ldr x1, =menuFinalMsg
    mov x2, size_menuFinalMsg
    mov x8, 64
    svc 0

    mov x0, 0
    ldr x1, =inputSelection
    mov x2, 2
    mov x8, 63
    svc 0

    ldr x3, =inputSelection
    ldrb w7, [x3]

    cmp w7, #49
    b.eq head

    cmp w7, #50
    b.eq exit

    b exit

siguiente:
    add x6, x6, 8
    b printActualValue

exit:
    add sp, sp, 32          // remove space from stack
    mov x0, 0
    mov x8, 93
    svc 0
