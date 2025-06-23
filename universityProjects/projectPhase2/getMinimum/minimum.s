//.global calculateMinimum
.global _start

.section .bss
buffer: .skip 8156
numSalida: .space 10

.section .text

_start:
    mov x0, 0              // fd 0 = stdin
    ldr x1, =buffer        // buffer destino
    mov x2, #8156           // bytes a leer
    mov x8, 63             // syscall number for read (Linux AArch64)
    svc #0                 // syscall

    // Declaración de variables
    ldr x1, =buffer         // x1 = dir(buffer)
    mov x2, x1              // x2 = dir(buffer) --> esta es la que se irá modificando
    mov x3, #0              // x3 = cantDigitosNumero
    mov x4, #0              // x4 = numero mas pequeño
    mov x5, #0              // x5 = numero en binario
    mov x6, #1              // x6 = multiplicador 10^n
    mov x8, #10             // x8 = constante 10
    mov x9, 0               // x9 = number counter
    // x10 == dígito individual

obtainSizeOfNum:
    ldrb w10, [x2]
    cmp w10, #36
    b.eq  returnMinimumNumber
    cmp w10, #10
    b.eq calculateNum
    add x2, x2, 1           // apunta al siguiente dígito
    add x3, x3, 1           // cantDigitos++
    b obtainSizeOfNum

calculateNum:
    sub x3, x3, 1
    ldrb w7, [x1, x3]       // w7 = mem(x1 + x3)
    sub x7, x7, #48         // asciiToInt(w7)
    madd x5, x7, x6, x5     // x5 = x5 + (x7*x6)
    
    cmp x3, 0
    b.eq compareNumber
    mul x6, x6, x8
    b calculateNum

compareNumber:
    cmp x9, 0
    b.eq switchNumber

    cmp x5, x4
    b.lt switchNumber

    b analizeNextNumber

switchNumber:
    mov x4, x5
    b analizeNextNumber

analizeNextNumber:
    add x2, x2, 1           // move to next number
    mov x1, x2              // set the start of the next number
    mov x3, #0              // reset the digit counter
    add x9, x9, 1           // #words = #words + 1
    mov x5, #0              // x5 = 0 --> vuelve a su valor inicial
    mov x6, #1              // reset multiplicator to its initial value
    b obtainSizeOfNum

returnMinimumNumber:
    // set initial values
    mov x3, 0               // counter of digits
    mov x5, x4              // x5 = temp result
    b countResultDigits

countResultDigits:
    add x3, x3, 1           // #digits = #digits + 1
    sdiv x5, x5, x8             // num = num/10
    cmp x5, #0              // x5 == 0 -> writeResult
    b.eq writeTmp
    b countResultDigits

writeTmp:
    mov x6, x3
    ldr x9, =numSalida
    b writeResult

writeResult:
    mov x5, x4              // copy result 1234
    sdiv x5, x5, x8         // divide tmp 1234/10 = 123
    msub x7, x5, x8, x4     // x7 = 1234 - (123*10) = 1234 - 1230 = 4
    add x7, x7, #48             // numToAscii(x7)
    sub x3, x3, 1
    strb w7, [x9, x3]

    sdiv x4, x4, x8
    cmp x4, 0
    b.eq printNumber
    b writeResult

printNumber:
    mov x0, 1
    ldr x1, =numSalida
    mov x2, x6
    mov x8, #64
    svc 0

    mov x8, #93
    svc 0