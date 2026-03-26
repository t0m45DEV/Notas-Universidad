#import "../../../shared/common.typ": *

= Programación Funcional

La programación funcional consiste en escribir funciones (_duh_) que siempre tienen algun tipo de input, y devuelven un output. *Haskell* es un lenguaje basado en este paradigma, donde se definen funciones, generalmente usando recursión.

Las funciones se definen siguiendo la estructura de `nombre parametros = comportamiento`, donde `nombre` es el nombre de la función, los `parametros` son los valores de entrada, y el `comportamiento` es el modo en el que la funcion utilizara esos argumentos para generar la salida. Por ejemplo:

#codigo(
  nombre: "Funciones sencillas en Haskell",
  codigo:```haskell
-- Devuelve el doble de un numero
doble n = 2 * n

-- Devuelve verdadero si el numero ingresado es par
esPar n = n `mod` 2 == 0

-- Los parametros tambien pueden ser funciones
evaluarEnCero f = f 0

-- Utilizo recursión para explorar una lista
todosPares []     = True
todosPares (x:xs) = esPar x && todosPares xs
```
)

Como tal, no se aleja mucho de la notación matemática o puramente de especificación, aunque tiene sus cosas a tener en cuenta.

Algo *importantisimo* en el mundo de Haskell es el *tipado* de las funciones. Todas las funciones tienen tipo. *TODAS*. Dentro de la consola del _ghci_ podemos preguntar por el tipo de una función de la siguiente manera:

#codigo(
  nombre: "Consultar el tipo de una función en Haskell",
  codigo: ```
ghci> :type esPar 
esPar :: Int -> Bool
```
)

Es buena práctica tipar uno mismo las funciones que define, ya que entender el tipado de las cosas en Haskell es crucial para verificar que las mismas funcionen correctamente.

#codigo(
  nombre: "Funcion tipada y definida en Haskell",
  codigo: ```haskell
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial(n - 1)
```
)

Una herramienta poderosa de Haskell son las listas. Podemos pensar en las listas como definidas de la siguiente forma: o bien una lista esta vacia (es decir, es exactamente igual a `[]`); o bien es de la forma `x:xs`, donde `x` es el primer elemento de la lista, y `xs` es el resto, que tambien es una lista (en este caso, el simbolo `:` simboliza la concatenación de listas, que es para lo que se utiliza en Haskell). Es decir, es una definción recursiva, con su caso base (la lista vacia), y el caso recursivo (elemento junto a otra lista). Algo importante a notar, es que *todos* los elementos de la lista son del mismo tipo.

Estos dos *constructores* ya estan definidos dentro de Haskell, pero nosotros podemos definir "a mano" nuestra propia version de las listas.

#codigo(
  nombre: "Posible definición \"a mano\" de las listas en Haskell",
  codigo:```haskell
data List a = Nil | Const a (List a)
```
)

Donde `Nil` vendria a representar a la lista vacia, y `Const a (List a)` el paso de agregar un elemento a otra lista existente.

En ese sentido, todas las listas podrian escribirse con esta sintaxis, aunque suele ser mas conveniente para la lectura adecuarse al estilo habitual. Por ejemplo, hablar de la lista `[1, 2, 3]` es equivalente a hablar de `1:2:3:[]`, ya que hacen referencia al mismo objeto, a ojos de Haskell.

Tenemos un monton de operaciones muy interesantes con las listas. Muchas las podemos definir nosotros mismos.

#codigo(
  nombre: "Algunas operaciones de listas en Haskell",
  codigo:```haskell
-- Devuelve True si la lista esta vacia
null :: [a] -> Bool
null []     = True
null (x:xs) = False

-- Devuelve el primer elemento de la lista
head :: [a] -> a
head (x:xs) = x

-- Devuelve toda la lista salvo su primer elemento
tail :: [a] -> a
tail (x:xs) = xs

-- Devuelve el ultimo elemento de la lista
last :: [a] -> a
last [x]      = x
last (x:y:ys) = last (y:ys)

-- Devuelve la cantidad de elementos de la lista
length :: [a] -> Int
length []     = 0
length (x:xs) = 1 + length xs
```
)

También tenemos funciones para combinar listas, como la concatenación entre listas.

#codigo(
  nombre: "Concatenación de listas en Haskell",
  codigo:```haskell
(++) :: [a] -> [a] -> [a]
(++) [] ys     = ys
(++) (x:xs) ys = x:(xs ++ ys)
```
)

Ademas tenemos algunas mas complejas (que van a tomar mas relevancia mas adelante):

#codigo(
  nombre: "Funciones _map_ y _filter_ en Haskell",
  codigo:```haskell
map :: (a -> b) -> [a] -> [b]
map f []     = []
map f (x:xs) = f x : (map f xs)

filter :: (a -> Bool) -> [a] -> [a]
filter p []     = []
filter p (x:xs) = if p x then x : (filter p xs)
                  else filter p xs
```
)

