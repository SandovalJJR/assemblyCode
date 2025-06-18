.equ tamanoArreglo, 10          // Se declara el tamaño constante del arreglo

.section .data
arreglo: .word 20, 21, 22, 23, 24, 25, 26, 27, 28, 37    // Se declara el arreglo de 10 enteros
mensajePar: .asciz "La suma de los numeros es par\n"   // Long = 30
mensajeImpar: .asciz "La suma de los numeros es impar\n"   // Long = 32
mensajePresentacion: .asciz "La suma de los numeros es: " // Long = 

// Se declara el código ejecutable
.section .text
.globl _start

// Asigna variables iniciales
_start:
    MOV X7,#0     // Valor de suma inicial =0 
    MOV X1,#0     // Valor del índice (inicia en o)
    LDR X2 ,=arreglo

bucleSuma:
    CMP X1,tamanoArreglo    // Compara si x1 >=10 
    BGE interpretarParImpar 

    LDR X3,[X2]      // x3= Mem(x2)
    ADD X7,X7,X3     // x7=x7 +x3 | x3= valor del arreglo 
    ADD X2,X2,#4     // Mover x2 a bytes de memoria (siguiente valor)
    ADD X1,X1 ,#1    // Se añade un valor al índice 
    b bucleSuma

// obtiene los resultados (par e impar) e imprime resultado
interpretarParImpar:
    MOV X1, #2
    SDIV X2, X7, X1
    MUL X2, X2, X1
    SUB X2, X7, X2

    CMP X2, 0
    BGT imprimirImpar

    b imprimirPar

// Imprime y finaliza el programa
imprimirImpar:
    MOV X0, #1                   // configurar en stdout 
    LDR X1, =mensajeImpar         // configurar apuntador a mensaje 
    MOV X2, #32                  // Configurar Longitud 
    MOV X8,#64                  // Imprimir 
    SVC 0

    // Retornar el valor de la suma
    MOV X0, X7
    MOV X8, #93
    SVC 0

imprimirPar:
    MOV X0, #1
    LDR X1, =mensajePar
    MOV X2, #30
    MOV X8, #64
    SVC 0

    MOV X0, X7
    MOV X8, #93
    SVC 0