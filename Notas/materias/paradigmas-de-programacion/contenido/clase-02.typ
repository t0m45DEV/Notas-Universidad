#import "../../../shared/common.typ": *

= Esquemas de Recursión

Cuando programamos en Haskell, especificamente a la hora de hacer funciones recursivas, nos daremos cuenta que todas son mas o menos similares (no en comportamiento, si no en estructura).

Supongamos que queremos definir una función `g` que aplica una operación `f` sobre todos los elementos de una lista, y que en caso de que la lista este vacia lo que `g` devolvera sera `v`. Es decir, definimos a `g` de la siguiente forma:

#codigo(
  nombre: "Definición de función g en Haskell",
  codigo:```haskell
g []     = v
g (x:xs) = f x (g xs)
```
)

Con `v` y `f` definidos previamente. Si todos los tipos de las operaciones son respetados, esta definición de `g` es valida para cualquier `g`. Es decir, sin importar la operación que hagamos sobre la lista, esta definición efectivamente la recorre en su totalidad y se comporta como queremos.

Esta forma de hacer recursión sobre una estructura, definiendo su caso base y su caso recursivo de esta manera, se le conoce como *recursión estructural*. Y hay una función muy importante que encapsula este comportamiento. Si pensaramos en `f` y en `v` como parametros de `g`, la función resultante seria:

#codigo(
  nombre: "Definición de fold en Haskell",
  codigo:```haskell
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f v []     = v
foldr f v (x:xs) = f x (foldr f v xs)
  ```,
)

Que se conoce normalmente como _foldr_ (de _fold right_, algo asi como "plegado hacia la derecha"). Utilizando _foldr_ es posible redefinir de manera sencilla funciones que sigan este esquema de recursión.

#codigo(
  nombre: "Ejemplos de uso de fold en Haskell",
  codigo:```haskell
sum :: [Int] -> Int
sum = foldr (+) 0

and :: [Bool] -> Bool
and = foldr (&&) True

or :: [Bool] -> Bool
or = foldr (||) False

length :: [Int] -> Int
length = foldr (\x n -> 1 + n) 0

map :: (a -> b) -> [a] -> [b]
map f = foldr (\x xs -> f x : xs) []

filter :: (x -> Bool) -> [a] -> [a]
filter p = foldr (\x xs -> if p x then x:xs else xs) []
```
)

El _foldr_ es muy util para definir funciones de manera mas corta, pero además tiene propiedades mucho mas importantes. Una de ellas, es la propiedad universival del _foldr_, que dice:

#definicion(
  nombre: "La Propiedad Universal del fold",
  expresion:
    grid(
      columns: (auto, auto, auto),
      align: (left + horizon, center + horizon, left + horizon),
      column-gutter: 2em,
      [
        $
        g quad [] quad &= quad v \
        g quad (italic("x") : italic("xs")) quad &= quad f quad italic("x") quad (g quad italic("xs"))
        $
      ],
      [$arrow.l.r$],
      [$g quad = quad italic("fold") quad f quad v$]
    )
)

Es decir, lo que vimos antes. Cualquier función que tenga la forma de la izquierda, podemos reescribirla como un caso de _foldr_ siguiendo el esquema de la derecha. Aparte de eso, tiene un peso a nivel de terminación: uno ya sabe que _foldr_ termina, por lo que si tu función es un caso particular de _foldr_, la función a crear también va a terminar.

También esto sirve para *demostrar* que el código cumple con propiedades especificas. Veamos el siguiente ejemplo:

#align(center)[`(+1)` #pdot() `sum = foldr (+) 1`]

Esta función es identica a la sumatoria conocida, pero agrega un uno extra al resultado. Lo que dice la propiedad es que esa función (la sumatoria mas uno) es igual a componer a la sumatoria normal con la operación `(+1)`.

#ejemplo(
  nombre: "Demostración de propiedad con fold",
  texto: [Primero, utilizando la propiedad universal del _foldr_, podemos reemplazar la ecuación de arriba por las siguientes dos ecuaciones:

$
((+1) #pdot() italic("sum")) quad [] quad &= quad 1 \
((+1) #pdot() italic("sum")) quad (x:italic("xs")) quad &= quad (+) quad x quad (((+1) #pdot() italic("sum")) quad  italic("xs"))
$

Ahora, si reemplazamos con la definición de la composición, nos queda lo siguiente:

$
italic("sum") quad [] quad + quad 1 quad &= quad 1 \
italic("sum") quad (x:italic("xs")) quad + quad 1 quad &= quad x quad + quad (italic("sum") quad italic("xs") quad + quad 1)
$

Ahora podemos utilizar la definición conocida de _sum_ para poder despejar cada lado de cada igualdad. Con la primera ecuación deducimos que ambos lados son iguales ya que:

$
&quad italic("sum") quad [] quad + quad 1 \
&= quad "{ Definición de " italic("sum") " }" \
&quad 0 quad + quad 1 \
&= quad "{ Aritmetica }" \
&quad 1
$

Y con el lado derecho llegamos a la misma conclusión, si hacemos:

$
&quad italic("sum") quad (x:italic("xs")) quad + quad 1 \
&= quad "{ Definición de " italic("sum") " }" \
&quad (x quad + quad italic("sum") quad italic("xs")) quad + quad 1 \
&= quad "{ Aritmetica }" \
&quad x quad + quad (italic("sum") quad italic("xs") quad + quad 1)
$
]
)

A la hora de definir funciones utilizando _foldr_ tenemos que encontrar dos cosas: $v$ y $f$. Guiandonos de la *propiedad universal del fold*, vemos que deducir $v$ es facil, simplemente es copiar el caso base. Pero deducir $f$, puede llegar a ser mas dificil. Aunque esto también puede descubrirse utilizando ecuaciones.

Supongamos que queremos definir la sumatoria utilizando _foldr_, pero no sabemos cuales son las variables $v$ y $f$. Como dijimos antes, $v$ se deduce facilmente de la primera definición de sumatoria (`sum [] = 0`, por lo que $v = 0$). Pero nos queda $f$. Sabemos que deberia tener una pinta asi:

#align(center)[$italic("sum") quad (x:italic("xs")) quad = quad f quad x quad (italic("sum") quad italic("xs"))$]

Podemos utilizar una estrategia similiar a antes: despejar $f$ usando las definiciones que ya tenemos.

#ejemplo(
  nombre: "Deducción de f para la sumatoria",
  texto:[
$
&quad italic("sum") quad (x:italic("xs")) quad = quad f quad x quad (italic("sum") quad italic("xs")) \
&<=> quad "{ Definición de" italic("sum") " }" \
&quad x quad + quad italic("sum") quad italic("xs") quad = quad f quad x quad (italic("sum") quad italic("xs")) \
&<=> quad "{ Reemplazamos" italic("sum") quad italic("xs") " por " italic("y") " }" \
&quad x quad + quad y quad = quad f quad x quad y \
&<=> quad "Funciones" \
&quad f quad = quad (+)
$
]
)

A modo de ejemplo veamos el mismo tipo de ejercicio pero con la definición del _map_:

#ejemplo(
  nombre: "Deducción de g para la función map",
  texto:[
$
&quad italic("map") quad f quad (x:italic("xs")) quad = quad g quad x quad (italic("map") quad f quad italic("xs")) \
&<=> quad "{ Definición de" italic("map") " }" \
&quad f quad x quad : quad italic("map") quad f quad italic("xs") quad = quad g quad x quad (italic("map") quad f quad italic("xs")) \
&<=> quad "{ Reemplazamos" (italic("map") quad f quad italic("xs")) " por " italic("ys") " }" \
&quad f quad x quad : quad italic("ys") quad = quad g quad x quad italic("ys") \
&<=> quad "Funciones" \
&quad g quad = quad lambda x quad italic("ys") quad -> quad f quad x quad : quad italic("ys")
$
]
)

Existe otro esquema de recursión que es el de *recursión primitiva*. En este caso, la función $f$ toma un parametro nuevo, que es la cola de la lista, quedandonos algo asi:

#codigo(
  nombre: "Definición de recr en Haskell",
  codigo:```haskell
recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr f v []     = v
recr f v (x:xs) = f x xs (recr f v xs)
```
)

A simple vista no parece mucha la diferencia, pero la idea es simple: ahora $f$ tiene mas información que en el caso de _foldr_. Esta recursión abarca mas casos que la recursión estructural, pero todas las funciones definidas con _recr_ pueden ser definidas de manera estructural. Es decir, las funciones que cumplan el patron estructural, también pueden ser definidas de manera primitiva, pero no viceversa.

