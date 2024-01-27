# UCV_Haskell-Assignment
Haskell assignment for CS Degree @ Central University of Venezuela

Assignment instructions (Spanish)
---
Esta tarea/proyecto consiste en implementar dos grupos de funciones Haskell descritas a continuación. Siga las instrucciones indicadas en cada caso y tome en cuenta las consideraciones generales especificadas al final del enunciado.
## Parte I – Enteros (no tan) binarios
1) Escriba una función llamada esNoTanBit x, que dado un valor x de tipo Int retorne True cuando x es 0 ó 1, y False en caso contrario.
2) Escriba una función llamada negarBit x, que retorna 1 si x es y 0 si x es 1. Si x no es un “(no tan) bit”, se debe disparar un error.
Nota: En caso de error, el resultado de una función puede ser la expresión error <mensaje>, donde <mensaje> es un string
describiendo el error.
3) En cada una de las siguientes funciones x es una lista de valores del tipo Int y el valor retornado es de tipo Bool.
a) Defina la función esSecuenciaNoTanBits1 x que retorne True si x es la lista vacía o si contiene solo “(no tan) bits”; en caso contrario debe retornar False. Implemente la función de manera recursiva con guardas (guards) y utilice la función esNoTanBit definida anteriormente.
b) Defina una segunda versión de la función, renombrada como esSecuenciaNoTanBits2 x utilizando recursión y a lo sumo una expresión if-then-else en la solución. No utilice guardas en este caso.
c) Defina una tercera versión de la función, renombrada como esSecuenciaNoTanBits3 x utilizando únicamente funciones de orden superior (no use recursión, guardas ni if-then-else).
4) En cada una de las siguientes funciones, x es una lista de valores del tipo Int y el valor retornado es también una lista de Int.
a) Defina una función llamada invertirNoTanBits que retorna una lista de “(no tan) bits” resultante de invertir los unos y los ceros. Por ejemplo, invertirNoTanBits [0,1,1,0] retorna [1,0,0,1]. Utilice recursión en su solución.
b) Defina una segunda versión de la función, renombrada como invertirNoTanBits2 e impleméntela usando la función map. 
c) Defina una tercera versión de la función, renombrada como invertirNoTanBits3 e impleméntela usando listas por comprensión.
5) Defina la función contarNoTanBits x que retorna un par de valores que representan, respectivamente, el número de ceros y unos en x. Por ejemplo, contarNoTanBits [1,1,0,1] retorna el par (1,3). Puede asumir que la lista sólo contiene “(no tan) bits”.
6) Defina la función secuenciasNoTanBits n, que retorna una lista con todas las secuencias de “(no tan) bits” de tamaño n. El orden de las secuencias no importa y si n es menor que 1, debe retornar una lista vacía.
Documente la estrategia utilizada.
Nota: en todos las definiciones de funciones incluya la definición de tipo más general posible. 
## Parte II – Otra forma de hacer listas
Como vimos en clases, Haskell implementa listas polimórficas (tipo [a]). En esta parte se definirán las
operaciones de listas basadas en una representación alterna, definida como un nuevo tipo de datos:
data Lista a = Vacia | Const a (Lista a)
 deriving Show
Esta expresión Haskell define un nuevo tipo llamado Lista a, que representa una lista de cero o más valores
del tipo a. Una Lista puede ser Vacia o ser de la forma (Const primero resto), donde primero es de
tipo a y resto es de tipo Lista a. La expresión “deriving Show” se agrega para que Haskell permita
convertir a string valores del tipo Lista a y mostrar resultados.
El obtivo de esta parte de la tarea es implementar un conjunto de funciones para el tipo Lista a.
Nota: no cambie la definición dada para el tipo Lista a.
7) Implemente la función aLista :: [a] -> Lista a, que convierte una lista Haskell a una Lista a.
Por ejemplo:
> aLista []
Vacia
> aLista [1,3,9]
Const 1 (Const 3 (Const 9 Vacia))
> aLista "Lista"
Const 'L' (Const 'i' (Const 's' (Const 't' (Const 'a' Vacia))))
8) Implemente la función aListaHaskell :: Lista a -> [a], que convierte una Lista a en una lista
Haskell convencional. Por ejemplo:
> aListaHaskell Vacia
[]
> aListaHaskell (Const 1 (Const 3 (Const 9 Vacia)))
[1,3,9]
> aListaHaskell (Const "uno" (Const "tres" (Const "nueve" Vacia)))
["uno","tres","nueve"]
Para el resto de preguntas NO utilice las funciones aLista y aListaHaskell en las implementaciones de las
funciones descritas. Utilice recursión simple y funciones del Prelude.
9) Implemente la función concatena A B que retorna una Lista a nueva, que consiste de los elementos de
A seguidos de los elementos de B. Por ejemplo:
> concatena (Const 1 (Const 2 (Const 3 Vacia))) (Const 7 (Const 8 Vacia))
Const 1 (Const 2 (Const 3 (Const 7 (Const 8 Vacia))))
10) Defina el operador ++ de manera que opere sobre valores del tipo Lista a y utilice la implementación de
la función concatena. Para evitar conflictos con la implementación del operador que está en el Prelude,
indique su respuesta como comentario en el código.
11) Implemente la función eliminaTodos f L que retorna una Lista a que contiene todos los elementos
de L que no satisfacen la función f (un filtro “negativo” para Lista a). f es un predicado con tipo a ->
Bool y L es de tipo Lista a.
12) Implemente la función ordenar L, que dada una Lista a, retorna una nueva Lista a que es la versión
ordenada ascendentemente de L. Puede utilizar cualquiera de las implementaciones de algoritmos de
ordenamiento en Haskell que están en la Nota de Docencia del Prof. Jorge Salas, pero adaptada para el tipo
Lista a.
ordenar :: Ord a => Lista a -> Lista a (expresión de tipo)
