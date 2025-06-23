.global _start

.section .data
str: .space 20

.section .text
_start:
	ldr x0, =str		// x0 = dir(str)
	mov x1, 1234		// x1 = 12345
	mov x2, 10		    // x2 = 10
	mov x3, 0		    // x3 = 0
	mov x4, x1		    // x4 = 12345

get_length:
	udiv x4, x4, x2		// x4 = 1234/10 = 123
	add x3, x3, 1		// x3 = 1
	cmp x4, 0		    // 123 != 0 ---> de nuevo
	bne get_length		// x4 = 0, x3 = 4
	add x0, x0, x3		// x0 = dir(str) + 4
	mov w5, 10		    // w5 = 10
	strb w5, [x0]		// mem(x0 = str + 4) = 10
	sub x0, x0, 1		// x0 = dir(str) + 3
	add x3, x3, 1		// x3 = 5
	mov x4, x1		    // x4 = 1234
	mov x5, 0		    // x5 = 0
	
get_numbers_individually:
	udiv x6, x4, x2		// x6 = 1234/10 = 123
	msub x7, x6, x2, x4	// x7 = 1234 - (123*10) = 1234 - (1230) = 4
	add x5, x5, 1		// x5 = 0 + 1 = 1
	strb w7, [x0]		// Mem(x0 = str + 3) = w7 = 4
	sub x0, x0, 1		// x0 = dir(str) + 2
	mov x4, x6		    // x4 = 123
	cmp x4, 0		    // 123 != 0 -> se repite el ciclo 
	bne get_numbers_individually		// ir al siguiente numero
	add x0, x0, 1		// terminar bucle


numberToASCII:	
	ldrb w8, [x0]		// load left digit  w8 = Mem(str) = 1
	add w8, w8, 48		// set ascii        w8 = 1 + 48 = 49 (ascii de 1)
	strb w8, [x0]		// store ascii      Mem(x0) = 49 (dígito ascii)
	add x0, x0, 1		// increment offset x0 = str + 1
	sub x5, x5, 1		// decrement iter   x5 = 4
	cmp x5, 0		    // if iter != 0
	bne numberToASCII 	// hace lo mismo con todos los valores de 1 a 4
	
print_answer:
	mov x0, 1		    // stdout
	ldr x1, =str		// load str
	mov x2, x3		    // str size
	mov x8, 64		    // write syscall_num
	svc 0			    // syscall

exit: 
	mov x8, 93		    // exit syscall_num
	svc 0			    // syscall