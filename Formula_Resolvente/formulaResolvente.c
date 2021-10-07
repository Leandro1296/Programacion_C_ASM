#include <stdio.h>
#include <stdlib.h>

extern void CMAIN(float a, float b, float c);

int main(){

    float a;
    float b;
    float c;

    printf("Introduzca a:");
    scanf("%f", &a);

    printf("Introduzca b:");
    scanf("%f", &b); 

    printf("Introduzca c:");
    scanf("%f", &c);

    printf("a = %f, b = %f, c = %f\n", a, b, c); // %f se usa para float, se puede usar %e y %g tambien
    printf("Buscamos las raices para: \n");
    printf("%fx² + %fx + %f = 0\n", a, b, c);
    
    CMAIN(a, b, c);
    
    printf("Listo\n");

    return 0;
}