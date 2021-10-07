# Programacion_C_ASM
Ejercicios de Linkeo de assembler con C.

Formula resolvente

Problema:

Calcular las raíces de una función cuadrática a través de la fórmula resolvente.

Descripcion de la solucion:

La funcionalidad se realizo, por medio de un linkeo codigo c y assembler.
Por un lado, tenemos el codigo en assembler en el archivo:

resolvente.asm

En este archivo se realizan las operaciones correspondientes a la formula usando instrucciones para la FPU.
Recibe los parametros a, b, y c, imprimiendo al final el resultado las raices x1 y x2.

Primero se declara la seccion de datos, donde se ve comentada la primer linea, para que pueda compilar cuando se hace el linkeo desde C.
Despues, estan los valores de tipo qword para trabajar con los floats y un formato para poder imprimir los resultados. 

![image](https://user-images.githubusercontent.com/20952785/136303607-de5877b4-e7de-4df1-95e6-1c5bda1fc115.png)

Se declara la seccion donde se va estar la funcionalidad. Tambien el uso de printf como funcion externa.

![image](https://user-images.githubusercontent.com/20952785/136303936-4f49a843-90e4-4ea8-8853-f610b2ce2e98.png)

Ya en la funcion principal, se ve una primer linea comentada que se usa para debug. Si no esta comentada se produce un desbordamiento al querer leer los paramatros que se ingresen. Se produce un 'stack smashing detected'. La segunda linea es para inicializar la pila, poniendo el stack pointer en el base pointer y asi poder trabajar con los argumentos a, b y c. Sin eso podria producirse un segmentation fault. 

![image](https://user-images.githubusercontent.com/20952785/136304102-f9a4a911-f1b1-46c5-aad9-eb5b16325d5e.png)

Leemos los valores a, b y c. Se usa dword para almacenar el valor correcto que hay en el parametro. Tambien se utiliza la instruccion ffree para poder liberar la pila de FPU.
Esto es porque tiene 8 registros disponibles y para poder hacer muchas operaciones sobre ella hay que ir liberando elementos de la pila que ya no se usan.

![image](https://user-images.githubusercontent.com/20952785/136304470-cc6003a8-90d9-4e4f-bc51-2fc40bfec996.png)

Se calcula -b, utilizando fchs que cambia el signo de un valor en punto flotante.

![image](https://user-images.githubusercontent.com/20952785/136304709-ca1a4fd8-f7db-45f6-9bb2-c5bda680c50a.png)

Se calcula la raiz del determinante:

![image](https://user-images.githubusercontent.com/20952785/136304861-044a3641-2876-4aa9-91f8-fb6f18d7a94a.png)

Se calcula el divisor de la formula:

![image](https://user-images.githubusercontent.com/20952785/136304883-e59534e9-9564-47a6-8ca1-229d59baae48.png)

Luego, se calculan x1 y x2 con los valores que se fueron obteniendo en las operaciones anteriores. 
x1 = -b + sqrt(b^2-4*a*c) / 2.a
x2 = -b - sqrt(b^2-4*a*c) / 2.a

![image](https://user-images.githubusercontent.com/20952785/136305006-a86f0f3a-3348-4ff3-9227-e2a021338606.png)

Por ultimo, se imprime los valores de x1 y x2, y se resetea la pila en memoria.

![image](https://user-images.githubusercontent.com/20952785/136305226-d4ecb227-9d40-4373-ab49-ecfb727a56aa.png)


Por otro lado, esta el codigo en C, que va hacer uso de la funcion del archivo assembler:

formulaResolvente.c

Donde se pide al usuario los valores de tipo float que van a ser utlizados para calcular las raices.
Una vez que tiene esos valores llama a la funcion CMAIN de resolvente.asm y le pasa por parametros a, b y c. 

Primero se importan librerias y se declara el uso de la funcion externa CMAIN(a,b,c) para poder usar. Con extern adelante se indica que se tiene que buscar en el codigo assembler.

![image](https://user-images.githubusercontent.com/20952785/136302627-43b824d0-a6a4-4793-bada-e0dab53e73d7.png)

Dentro del main de c, esta el pedido de los valores para la formula, usando la scanf(formato, valorIngresado).
El formato para float es %f, %e y %g tambien son validos. Y el & es para obtener la direccion del valor y almacenarlo en una variable. Sin podria ocurrir un error de violacion de segmento.

![image](https://user-images.githubusercontent.com/20952785/136303213-0aead2fa-1417-474d-9ac3-8fa6f4686168.png)

Por ultimo, se invoca la funcion que calcula la resolvente:

![image](https://user-images.githubusercontent.com/20952785/136303489-78680c6f-9822-4aa7-9c55-d3439aabf83a.png)

Para hacer compilacion y el linkeo de los archivos objetos de ambos, se usa el archivo: 

formulaResolvente.sh

Primero genera el archivo objeto del codigo en assembler, luego el del codigo C y finalmente genera un ejecutable.
Este ultimo tiene tambien la instruccion en el codigo a para ejecutarse, de todas formas despues de haber hecho un ejecutable tambien se puede correr aparte.

![image](https://user-images.githubusercontent.com/20952785/136299885-fdd17936-a487-4368-807c-29185d78dfe5.png)

En esta ocasion, el programa es para la arquitectura IA-32 es por eso que para nasm se usa -elf32 y para el de gcc -m32.

Ejemplos:

Se quiere calcular las raices de  ![image](https://user-images.githubusercontent.com/20952785/136300684-401629ee-2d9b-4c8f-935f-557c38d48799.png).
Para eso primero se ejecuta en la terminal 

./formulaResolvente.sh 

Ingresamos los valores de a, b y c.

![image](https://user-images.githubusercontent.com/20952785/136301876-47220bab-3c0c-4e09-b6c2-74bfd8bbbfd6.png)

Los valores que admite son de tipo float, por lo que se debe ingresar como integer o float , ej: 2.0 o 2, si se usaba 2,0 el programa no trae la respuesta esperada.

Luego imprime lo siguiente:

![image](https://user-images.githubusercontent.com/20952785/136302099-191311cb-8a0b-4992-88a1-b5a5396da6a8.png)

En caso de que el determinante de la formula resolvente sea negativo los valores de x1 y x2 serian '-nan'.

Por ejemplo, con a = 1, b = 1 y c = 2 obtenemos lo siguiente:

![image](https://user-images.githubusercontent.com/20952785/136302314-05c5782b-dea4-470a-88ac-eb5c03acc3d4.png)


Producto escalar

Problema:

Calcular el producto escalar entre un puntero a un vector de números de punto flotante y un número r. Debe multiplicar
cada elemento del vector por r. Debe ser para la arquitectura IA-32.

Descripcion de la solucion:

escalar.asm























