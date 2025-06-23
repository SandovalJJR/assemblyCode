/* print itoa: convert and print an 
integer to ascii representation.
Luis Espino 2024 */

.global _start

.text
_start:
	ldr x0, =str		// load addr of str     x0 = dir(str)
	mov x1, 12345		// number to convert    x1 = 12345
	mov x2, 10		    // base number          x2 = 10
	mov x3, 0		    // number size = 0      x3 = 0
	mov x4, x1		    // copy of number       x4 = 12345

getsize:
	udiv x4, x4, x2		// remove last digit    x4 = 12345/10 = 1234
	add x3, x3, 1		// increment size       x3 = 1
	cmp x4, 0		    // if number != 0       1234 != 0 ---> de nuevo
	bne getsize		    // goto getsize         x4 = 0, x3 = 5
	
	add x0, x0, x3		// str addr offset      x0 = dir(str) + 5
	mov w5, 10		    // newline ascii        w5 = 10
	strb w5, [x0]		// store newline        mem(x0 = str + 5) = 10
	sub x0, x0, 1		// decrement offset     x0 = dir(str) + 4
	add x3, x3, 1		// str final size       x3 = 6
	mov x4, x1		    // copy of number       x4 = 12345
	mov x5, 0		    // iter number = 0      x5 = 0
	
getdigit:
	udiv x6, x4, x2		// remove last digit	x6 = 12345/10 = 1234
	msub x7, x6, x2, x4	// last digit           x7 = 12345 - (1234*10) = 12345 - (12340) = 5
	add x5, x5, 1		// increment iter       x5 = 0 + 1 = 1
	strb w7, [x0]		// store last digit     Mem(x0 = str + 4) = w7 = 5
	sub x0, x0, 1		// decrement offset     x0 = dir(str) + 3
	mov x4, x6		    // number remain        x4 = 1234
	cmp x4, 0		    // if number != 0       1234 != 0 -> se repite el ciclo 
	bne getdigit		// goto getdigit
	add x0, x0, 1		// reset addr

    // Ciclo #2:
        // x6 = 1234/10 = 123
        // x7 = 1234 - (123*10) = 1234 - (1230) = 4
        // x5 = 1 + 1 = 2
        // Mem(x0 = str + 3) = w7 = 4
        // x0 = dir(str) + 2
        // x4 = 123
        // 123 != 0 -> se repite el ciclo 

    // Ciclo #3:
        // x6 = 123/10 = 12
        // x7 = 123 - (12*10) = 123 - (120) = 3
        // x5 = 1 + 2 = 3
        // Mem(x0 = str + 2) = w7 = 3
        // x0 = dir(str) + 1
        // x4 = 12
        // 12 != 0 -> se repite el ciclo

    // Ciclo #4:
        // x6 = 12/10 = 1
        // x7 = 12 - (1*10) = 12 - (10) = 2
        // x5 = 1 + 3 = 4
        // Mem(x0 = str + 1) = w7 = 2
        // x0 = dir(str)
        // x4 = 1
        // 1 != 0 -> se repite el ciclo 

    // Ciclo #5:
        // x6 = 1/10 = 0
        // x7 = 1 - (0*10) = 1 - (0) = 1
        // x5 = 1 + 4 = 5
        // Mem(x0 = str) = w7 = 1
        // x0 = dir(str) - 1
        // x4 = 0
        // 0 == 0 -> sale del ciclo
        // x0 = dir(str) 

setascii:	
	ldrb w8, [x0]		// load left digit  w8 = Mem(str) = 1
	add w8, w8, 48		// set ascii        w8 = 1 + 48 = 49 (ascii de 1)
	strb w8, [x0]		// store ascii      Mem(x0) = 49 (dígito ascii)
	add x0, x0, 1		// increment offset x0 = str + 1
	sub x5, x5, 1		// decrement iter   x5 = 4
	cmp x5, 0		    // if iter != 0
	bne setascii		// goto setascii    hace lo mismo con todos los valores de 1 a 5
	
print:
	mov x0, 1		    // stdout
	ldr x1, =str		// load str
	mov x2, x3		    // str size
	mov x8, 64		    // write syscall_num
	svc 0			    // syscall

exit: 
	mov x8, 93		    // exit syscall_num
	svc 0			    // syscall

.data
str: .space 20
