.global _start

.section .data
readFileSectionWelcome: .asciz "Welcome to the upload-file section!\n" // length = 36
fileNameRequest: .asciz "\nWrite the file name: " // msg length = 22
sumPrintMsg: .asciz "\nThe sum of the numbers is: " // msg length = 28

.section .bss
fileName: .space 30
buffer: .skip 512
asciiValue: .space 30

.section .text
_start:
    // Print the welcome msg
    mov x0, #1
    ldr x1, =readFileSectionWelcome
    mov x2, #36
    mov x8, #64
    svc 0

    // Request the file name text
    mov x0, #1
    ldr x1, =fileNameRequest
    mov x2, #22
    mov x8, #64
    svc 0

    // file name request
    mov x0, #0
    ldr x1, =fileName
    mov x2, #30
    mov x8, #63
    svc 0

    mov x5, 0           // x5 = word counter
    ldr x6, =fileName   // x6 = dir(fileName)

findLineBreak:
    ldrb w7, [x6]
    cmp w7, #10
    b.eq deleteLineBreak
    add x6, x6, 1
    add x5, x5, 1
    b findLineBreak

deleteLineBreak:
    mov w9, #0
    ldr x4, =fileName
    strb w9, [x4, x5]

openFile:
    mov x0, -100
    ldr x1, =fileName
    mov x2, #0
    mov x8, #56
    svc #0
    mov x9, x0

    mov x0, x9
    ldr x1, =buffer
    mov x2, 512        // size address
    mov x8, 63          // read
    svc 0               // syscall


 // Declaración de variables iniciales
    // x1 = dir(buffer)
    mov x3, #0              // x3 = suma de los numeros
    mov x4, #0              // x4 = numero en binario
    mov x5, #10             // x5 = constante 10
    mov x6, #0              // x6 = suma total

parse_number:
    ldrb w4, [x1]           // leer byte del buffer
    cmp w4, #0              // es 'null'?
    b.eq itoa          // si es 'null', returnMinimumNumber
    cmp w4, #10             // es '\n'?
    b.eq sumNumber      // si es '\n', addNumber

    sub w4, w4, #48       // convertir de ASCII a número
    mul x3, x3, x5          // x3 *= 10
    add x3, x3, x4         // x3 += dígito
    add x1, x1, 1           // apunta al siguiente dígito
    b parse_number

sumNumber:
    add x6, x6, x3
    add x1, x1, 1
    mov x3, #0
    b parse_number

itoa:    
    mov x4, x6             // x4 = x6 = number value returned fron another function
    ldr x20, =asciiValue     // x20 = dir(asciiValue)
    mov x6, #0              // x6 = offset
    mov w7, #0              // constant in reset function
    mov x8, #10             // x8 = 10 (constant)

resetValue:
    cmp x6, #30
    b.ge asciiConverter
    strb w7, [x20, x6]
    add x6, x6, 1
    b resetValue

asciiConverter:
    // set initial values
    mov x9, x4              // copy of the number returned
    mov x6, #0              // set character counter
    b digitsCounter

digitsCounter:
    sdiv x9, x9, x8
    add x21, x21, 1
    cmp x9, #0
    b.eq conditionsSetter
    b digitsCounter

conditionsSetter:
    mov x6, x21             // copy of the quantity of digits

convertionProcess:
    mov x9, x4
    sdiv x9, x9, x8         // 1234/10 = 123
    msub x7, x9, x8, x4    // x7 = 1234 - (123*10) = 1234 - 1230 = 4 (remove last value)
    add x7, x7, #48         // int to ascii
    sub x6, x6, 1
    strb w7, [x20, x6]

    sdiv x4, x4, x8
    cmp x4, #0
    b.eq printNumber
    b convertionProcess

printNumber:
    mov x0, #1
    ldr x1, =sumPrintMsg
    mov x2, #28
    mov x8, #64
    svc #0

    ldr x2, =asciiValue
    add x2, x2, x21
    mov w1, #10
    strb w1, [x2]
    add x21, x21, 1

    mov x0, #1
    ldr x1, =asciiValue
    mov x2, x21
    mov x8, #64
    svc #0

    mov x0, #0
    mov x8, #93
    svc #0
