#import "../../../template/content-conf.typ": conf
#import "../../../shared/common.typ": *

#show: conf.with(
  titulo: "Tipos Abstractos de Datos",
  resumen: [
    Este es un resumen de TADs
  ],
)

#codigo(
  nombre: "Hello World in C",
  codigo:```c
#include <stdio.h>

int main(int argc, char* argv[])
{
  printf("Hello world!\n");
  return 0;
}
  ```,
)

#codigo(
  nombre: "Recursion estructural para listas en Haskell",
  codigo:```haskell
foldr :: (b -> a -> b) -> b -> [a] -> b
foldr f z []     = z
foldr f z (x:xs) = f x (foldr f z xs)
  ```,
)

