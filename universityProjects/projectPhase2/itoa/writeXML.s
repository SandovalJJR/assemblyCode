//.global writeWML
.global _start
.extern itoa

.section .bss
fileName: .space 30
writeBuffer: .space 2048

.section .data
welcomeMsg: .asciz "\nBienvenido, escribe el nombre que tendra el archivo XML (no mas de 25 digitos).\n" // length = 81
fileNameMsg: .asciz "\nNombre del archivo: " // length = 21

.section .text
//writeXML:
_start:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    // Write the welcome msg
    mov x0, #1
    ldr x1, =welcomeMsg
    mov x2, #81
    mov x8, #64
    svc #0

    // Write the fileName msg
    mov x0, #1
    ldr x1, =fileNameMsg
    mov x2, #21
    mov x8, #64
    svc #0

    // request a text entry
    mov x0, #0
    ldr x1, =fileName
    mov x2, #30
    mov x8, #63
    svc #0

    mov x4, #0              // x4 = counter and file name length
    ldr x9, =fileName

// ------------------------REMOVE BREAK LINE IN FILE NAME-----------------------------------------

removeBreakLine:
    ldrb w7, [x9, x4]
    cmp w7, #10
    b.eq setPositionToNull
    add x4, x4, 1
    b removeBreakLine

setPositionToNull:
    mov w7, #0
    strb w7, [x9, x4]
    
    // set initial conditions
    mov x3, #0              // x3 = position counter
    ldr x10, =writeBuffer   // x10 = dir(writeBuffer)


openEstadisticasTag:
    mov w7, #60             // <
    strb w7, [x10, x3]
    add x3, x3, 1
    
    mov w7, #101            // 'e'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #115            // 's'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #116            // 't'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97             // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #100            // 'd'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105            // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #115            // 's'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #116            // 't'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105            // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #99             // 'c'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97             // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #115            // 's'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62             // '>'
    strb w7, [x10, x3]
    add x3, x3, #1


openMeanTag:
    mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #109        // 'm'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #101        // 'e'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #100        // 'd'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

    // set values to mean
    mov x19, #24
    bl itoa
    mov x5, #0          // counter

meanValue:
    ldrb w7, [x20, x5]
    strb w7, [x10, x3]
    add x3, x3, 1
    sub x21, x21, 1
    cmp x21, 0
    b.eq closeMeanTag
    add x5, x5, 1
    b meanValue

closeMeanTag:
     mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #47         // '/'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #109        // 'm'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #101        // 'e'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #100        // 'd'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

openMedianTag:
    mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #109        // 'm'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #101        // 'e'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #100        // 'd'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #110        // 'n'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

    // set values to median
    mov x19, #507
    bl itoa
    mov x5, #0          // counter

medianValue:
    ldrb w7, [x20, x5]
    strb w7, [x10, x3]
    add x3, x3, 1
    sub x21, x21, 1
    cmp x21, 0
    b.eq closeMedianTag
    add x5, x5, 1
    b medianValue

closeMedianTag:
    mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #47         // '/'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #109        // 'm'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #101        // 'e'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #100        // 'd'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #110        // 'n'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

openModeTag: 
    mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #109        // 'm'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #111        // 'o'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #100        // 'd'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

    // set values to mode
    mov x19, #221
    bl itoa
    mov x5, #0          // counter

modeValue:
    ldrb w7, [x20, x5]
    strb w7, [x10, x3]
    add x3, x3, 1
    sub x21, x21, 1
    cmp x21, 0
    b.eq closeModeTag
    add x5, x5, 1
    b modeValue

closeModeTag:
    mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #47         // '/'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #109        // 'm'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #111        // 'o'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #100        // 'd'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

openMinTag:
    mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #109        // 'm'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #110        // 'n'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

    // set values to Minimum
    mov x19, #221
    bl itoa
    mov x5, #0          // counter

minValue:
    ldrb w7, [x20, x5]
    strb w7, [x10, x3]
    add x3, x3, 1
    sub x21, x21, 1
    cmp x21, 0
    b.eq closeMinTag
    add x5, x5, 1
    b minValue

closeMinTag:
    mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #47         // '/'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #109        // 'm'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #110        // 'n'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

openMaxTag:
    mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #109        // 'm'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #120        // 'x'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

    // set values to maximum
    mov x19, #221
    bl itoa
    mov x5, #0          // counter

maxValue:
    ldrb w7, [x20, x5]
    strb w7, [x10, x3]
    add x3, x3, 1
    sub x21, x21, 1
    cmp x21, 0
    b.eq closeMaxTag
    add x5, x5, 1
    b maxValue

closeMaxTag:
    mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #47         // '/'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #109        // 'm'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #120        // 'x'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

openDeviationTag:
    mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #100        // 'd'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #101        // 'e'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #115        // 's'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #118        // 'v'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #99         // 'c'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #111        // 'o'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #110        // 'n'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

    // set values to deviation
    mov x19, #221
    bl itoa
    mov x5, #0          // counter

deviationValue:
    ldrb w7, [x20, x5]
    strb w7, [x10, x3]
    add x3, x3, 1
    sub x21, x21, 1
    cmp x21, 0
    b.eq closeDeviationTag
    add x5, x5, 1
    b deviationValue

closeDeviationTag:
    mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #47         // '/'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #100        // 'd'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #101        // 'e'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #115        // 's'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #118        // 'v'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #99         // 'c'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #111        // 'o'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #110        // 'n'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

openVarianceTag:
    mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #118        // 'v'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #114        // 'r'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #110        // 'n'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #122        // 'z'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

    // set values to variance
    mov x19, #24
    bl itoa
    mov x5, #0          // counter

varianceValue:
    ldrb w7, [x20, x5]
    strb w7, [x10, x3]
    add x3, x3, 1
    sub x21, x21, 1
    cmp x21, 0
    b.eq closeVarianceTag
    add x5, x5, 1
    b varianceValue

closeVarianceTag:
    mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #47         // '/'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #118        // 'v'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #114        // 'r'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #110        // 'n'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #122        // 'z'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

openMovilMeanTag:
    mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #109        // 'm'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #109        // 'm'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #111        // 'o'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #118        // 'v'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #108        // 'l'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

    // set values to movil mean
    mov x19, #24
    bl itoa
    mov x5, #0          // counter

movilMeanValue:
    ldrb w7, [x20, x5]
    strb w7, [x10, x3]
    add x3, x3, 1
    sub x21, x21, 1
    cmp x21, 0
    b.eq closeMovilMeanTag
    add x5, x5, 1
    b movilMeanValue

closeMovilMeanTag:
    mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #47         // '/'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #109        // 'm'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #109        // 'm'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #111        // 'o'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #118        // 'v'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #108        // 'l'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

openExponentialSoftenerTag:
        mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #115        // 's'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #117        // 'u'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #118        // 'v'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #122        // 'z'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #100        // 'd'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #111        // 'o'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

    // set values to exponential softener
    mov x19, #24
    bl itoa
    mov x5, #0          // counter

exponentialSoftenerValue:
    ldrb w7, [x20, x5]
    strb w7, [x10, x3]
    add x3, x3, 1
    sub x21, x21, 1
    cmp x21, 0
    b.eq closeExponentialSoftenerTag
    add x5, x5, 1
    b exponentialSoftenerValue

closeExponentialSoftenerTag:
    mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #47         // '/'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #115        // 's'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #117        // 'u'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #118        // 'v'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #122        // 'z'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #100        // 'd'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #111        // 'o'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

closeStatisticsTag:
    mov w7, #60         // '<'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #47         // '/'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #101        // 'e'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #115        // 's'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #116        // 't'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #100        // 'd'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #115        // 's'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #116        // 't'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #105        // 'i'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #99         // 'c'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #97         // 'a'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #115        // 's'
    strb w7, [x10, x3]
    add x3, x3, #1

    mov w7, #62         // '>'
    strb w7, [x10, x3]
    add x3, x3, #1

// ----------------------------------------------- WRITE XML FILE -------------------------

writeXmlFile:
    mov x12, x3
    // open file
    mov x0, -100        // open
    ldr x1, =fileName   // filename address
    mov x2, 101         // O_WRONLY | O_CREATE
    mov x3, 0777        // permissions
    mov x8, 56          // openat
    svc #0              // syscall
    mov x9, x0          // store file descriptor
    
    // write file
    mov x0, x9          // file descriptor
    ldr x1, =writeBuffer     // buffer address
    mov x2, x12          // size address
    mov x8, 64          // write
    svc 0               // syscall

    // close file
    mov x0, x9          // file descriptor
    mov x8, 57          // close
    svc 0               // syscall

    // exit
    mov x0, 0           // return vale
    mov x8, 93          // exit
    svc 0               // syscall
