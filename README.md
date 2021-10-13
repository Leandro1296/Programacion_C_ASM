# Programacion_C_ASM   🤖
Ejercicios de programacion en C y Assembler. Utilizando Visual Studio Code y Nasm.

**_Formula resolvente_**  💻

- Problema:

Calcular las raíces de una función cuadrática a través de la fórmula resolvente.

- Descripcion de la solucion:

La funcionalidad se realizo, por medio de un linkeo codigo c y assembler.

Por un lado, tenemos el codigo en assembler en el archivo:

**resolvente.asm**  📄

En este archivo se realizan las operaciones correspondientes a la formula usando instrucciones para trabajar con FPU.
Recibe los parametros a, b, y c, imprimiendo al final el resultado las raices x1 y x2.

Primero se declara la seccion de datos, donde se ve comentada la primer linea, para que pueda compilar cuando se hace el linkeo desde C.
Despues, estan los valores de tipo qword para trabajar con los floats y un formato para poder imprimir los resultados. 

![image](https://user-images.githubusercontent.com/20952785/136303607-de5877b4-e7de-4df1-95e6-1c5bda1fc115.png)

Se declara la seccion 'text' donde se va estar la funcionalidad. Tambien el uso de printf como funcion externa.

![image](https://user-images.githubusercontent.com/20952785/136303936-4f49a843-90e4-4ea8-8853-f610b2ce2e98.png)

Ya en la funcion principal, se ve una primer linea comentada que se usa para debug. Si no esta comentada se produce un error de desbordamiento al querer leer los paramatros que se ingresen. Se produce un 'stack smashing detected'. La segunda linea es para inicializar la pila, poniendo el stack pointer en el base pointer y asi poder trabajar con los argumentos a, b y c. Sin eso podria producirse un segmentation fault. 

![image](https://user-images.githubusercontent.com/20952785/136304102-f9a4a911-f1b1-46c5-aad9-eb5b16325d5e.png)

Leemos los valores a, b y c. Se usa dword para almacenar el valor correcto que hay en el parametro. Tambien se utiliza la instruccion ffree para poder liberar un elemento de la pila de FPU.
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

**formulaResolvente.c**  📄

Donde se pide al usuario los valores de tipo float que van a ser utlizados para calcular las raices.
Una vez que tiene esos valores llama a la funcion CMAIN de resolvente.asm y le pasa por parametros a, b y c. 

Primero se importan librerias y se declara el uso de la funcion externa CMAIN(a,b,c) para poder usar. Con extern adelante se indica que se tiene que buscar en el codigo assembler.

![image](https://user-images.githubusercontent.com/20952785/136302627-43b824d0-a6a4-4793-bada-e0dab53e73d7.png)

Dentro del main de c, esta el pedido de los valores para la formula, usando la scanf(formato, valorIngresado).
El formato para float es %f, %e y %g tambien son validos. Y el & es para obtener la direccion del valor y almacenarlo en una variable. Sin eso, podria ocurrir un error de violacion de segmento.

![image](https://user-images.githubusercontent.com/20952785/136303213-0aead2fa-1417-474d-9ac3-8fa6f4686168.png)

Por ultimo, se invoca la funcion que calcula la resolvente:

![image](https://user-images.githubusercontent.com/20952785/136303489-78680c6f-9822-4aa7-9c55-d3439aabf83a.png)

Para hacer compilacion y el linkeo de los archivos objetos de ambos, se usa el archivo: 

**formulaResolvente.sh**  📄

Primero genera el archivo objeto del codigo en assembler, luego el del codigo C y finalmente genera un ejecutable.
Este ultimo tiene tambien la instruccion en el codigo a para ejecutarse, de todas formas despues de haber hecho un ejecutable tambien se puede correr aparte.

![image](https://user-images.githubusercontent.com/20952785/136299885-fdd17936-a487-4368-807c-29185d78dfe5.png)

En esta ocasion, el programa es para la arquitectura IA-32 es por eso que para nasm se usa -elf32 y para el de gcc -m32.

- Ejemplos: 🏃

Se quiere calcular las raices de  ![image](https://user-images.githubusercontent.com/20952785/136300684-401629ee-2d9b-4c8f-935f-557c38d48799.png).
Para eso primero se ejecuta en la terminal 

> ./formulaResolvente.sh 

Ingresamos los valores de a, b y c.

![image](https://user-images.githubusercontent.com/20952785/136301876-47220bab-3c0c-4e09-b6c2-74bfd8bbbfd6.png)

Los valores que admite son de tipo float, por lo que se debe ingresar como integer o float , ej: 2.0 o 2, si se usaba 2,0 el programa no trae la respuesta esperada.

Luego imprime lo siguiente:

![image](https://user-images.githubusercontent.com/20952785/136302099-191311cb-8a0b-4992-88a1-b5a5396da6a8.png)

En caso de que el determinante de la formula resolvente sea negativo los valores de x1 y x2 serian '-nan'.

Por ejemplo, con a = 1, b = 1 y c = 2 obtenemos lo siguiente:

![image](https://user-images.githubusercontent.com/20952785/136302314-05c5782b-dea4-470a-88ac-eb5c03acc3d4.png)


**_Producto escalar_**  💻

- Problema:

Calcular el producto escalar entre un puntero a un vector de números de punto flotante y un número r. Debe multiplicar
cada elemento del vector por r. Debe ser para la arquitectura IA-32.

- Descripcion de la solucion:

Por medio de codigo assembler, se recorre un vector con valores de punto flotante y se multiplica por un número r cada valor. Finalmente lo muestra por pantalla.

**escalar.asm**  📄

La primera linea tiene que estar comentada para ejecutarlo por consola. Si no, podria aparacer el siguiente error: ![image](https://user-images.githubusercontent.com/20952785/136314941-f282f0fc-94ee-41fd-968b-732a8ec8ccd9.png)

Esta la variable **puntero** que es de tipo qword, donde se almacena la direccion del vector en memoria. Cuando se quiera acceder a los valores se necesita desplaza como [base + indice vector * 8]. Se usa 8 por los 8 bytes que ocupa un qword.
Esta la varible **limite**, que indica la cantidad de valores del vector. Es importante tenerlo, porque si no esta, al recorrer el vector se sigue moviendo a traves de la memoria. Esto sirve como condicion para que deje de iterar.
Esta la variable **r**, que es el número por el cual se va a multiplicar cada valor del vector.
Estas son las principales. Luego hay variable para ir almacenando el resulta y mostrar el valor del producto en pantalla.

![image](https://user-images.githubusercontent.com/20952785/136314043-0e9b4fd9-d22c-46f5-8910-0df18d7a8747.png)

En la seccion 'text' se declara la funcion que se va usar para el producto escalar y la funcion externa printf.

Ponemos el r y el puntero del vector en la pila, junto con el limite. Luego se llama a la funcion **producto_rvf**.

![image](https://user-images.githubusercontent.com/20952785/136315874-8f4e2aeb-a7f7-4cf8-867f-ea2f7060d10b.png)

Dentro de **prodeucto_rvf**, por cada valor del vector se usan instrucciones para cargar el valor actual y el r en la pila FPU para hacer el producto. Para no exceder el uso de registros de la FPU se usa la instruccion **ffree** para liberar un elemento de la pila.
Una vez, que se realiza esta operacion se imprime el resultado en pantalla. Luego, se pregunta si el valor era el ultimo. Si no lo es, repito la operacion, caso contrario, se sale de la funcion y se termina la ejecucion.

![image](https://user-images.githubusercontent.com/20952785/136316437-d33e25d8-dbd5-4478-800f-bd443afd73f5.png)

Para hacer compilacion y ejecucion se usa el archivo: 

**productoEscalar.sh**  📄

Primero genera el archivo objeto del codigo en assembler, compila con gcc pasando el archivo objeto y finalmente genera un ejecutable.
Este ultimo tiene tambien la instruccion en el codigo a para ejecutarse, de todas formas despues de haber hecho un ejecutable tambien se puede correr aparte.

![image](https://user-images.githubusercontent.com/20952785/136317927-6c01343d-d77f-4b96-a49d-d4d36399ce4a.png)

En esta ocasion, el programa es para la arquitectura IA-32 es por eso que para nasm se usa -elf32 y para el de gcc -m32.

- Ejemplos: 🏃

Se quiere calcular el producto escalar de lo siguiente:
```
puntero dq 25.0,0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0
limite db 10
r dq 23.0
```
Ejecutando lo siguiente en la consola:

> ./formulaResolvente.sh 

Obtenemos la salida:

![image](https://user-images.githubusercontent.com/20952785/136318305-4b038fb8-1f05-4a7c-8291-94dd156403d0.png)








- **Referencias**:  👀

https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html

https://www.csee.umbc.edu/courses/undergraduate/313/fall04/burt_katz/lectures/Lect12/floatingpoint.html

https://www.nasm.us/xdoc/2.09.04/html/nasmdoc9.html

Intel 64 and IA-32 Architectures Software Developer's Manual - Volume 1 - Chapter 8 Programming with the x87 FPU
