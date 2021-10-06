# Programacion_C_ASM
Ejercicios de Linkeo de assembler con C.

Formula resolvente

Problema:

Calculas las raíces de una función cuadrática a través de la fórmula resolvente.

Descripcion de la solucion:

La funcionalidad se realizo, por medio de un linkeo codigo c y assembler.
Por un lado, tenemos el codigo en assembler en el archivo:

resolvente.asm

En este archivo se realizan las operaciones correspondientes a la formula usando instrucciones para la FPU.

Recibe los parametros a, b, y c, imprimiendo al final el resultado las raices x1 y x2.

Por otro lado, esta el codigo en C, que va hacer uso del archivo assembler:

formulaResolvente.c

Donde se pide al usuario los valores de tipo float que van a ser utlizados para calcular las raices.
Una vez que tiene esos valores llama a la funcion CMMAIN de resolvente.asm y le pasa por parametros a, b y c.







