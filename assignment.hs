{-
    David
-}
------------------------ PARTE I ------------------------------------------------------------------------------------------------
-- Pregunta 1 -------------------------------------------------------------------------------------------------------------------
esNoTanBit :: Int -> Bool
esNoTanBit x 
    | x == 0 || x == 1 = True
    | otherwise = False

-- Pregunta 2 -------------------------------------------------------------------------------------------------------------------
negarBit :: Int -> Int
negarBit x
    | x == 0 = 1
    | x == 1 = 0
    | otherwise = error "X es no tan bit"

-- Pregunta 3 -------------------------------------------------------------------------------------------------------------------
    -- Apartado a)
esSecuenciaNoTanBits1 :: [Int] -> Bool
esSecuenciaNoTanBits1 [] = True
esSecuenciaNoTanBits1 (x:xs)
    | esNoTanBit x = esSecuenciaNoTanBits1 xs
    | otherwise = False

    -- Apartado b)
esSecuenciaNoTanBits2 :: [Int] -> Bool
esSecuenciaNoTanBits2 [] = True
esSecuenciaNoTanBits2 (x:xs) = if esNoTanBit x 
    then esSecuenciaNoTanBits2 xs 
    else False

    -- Apartado c)
esSecuenciaNoTanBits3 :: [Int] -> Bool
esSecuenciaNoTanBits3 [] = True
esSecuenciaNoTanBits3 xs = not (any (==False) (map esNoTanBit xs)) -- Usé la función "not" del prelude para negar el resultado de any

-- Pregunta 4 -------------------------------------------------------------------------------------------------------------------
    -- Apartado a)
invertirNoTanBits :: [Int] -> [Int]
invertirNoTanBits [] = []
invertirNoTanBits (x:xs) = negarBit x : invertirNoTanBits xs

    -- Apartado b)
invertirNoTanBits2 :: [Int] -> [Int]
invertirNoTanBits2 [] = []
invertirNoTanBits2 x = map negarBit x

    -- Apartado c)
invertirNoTanBits3 :: [Int] -> [Int]
invertirNoTanBits3 xs = [negarBit x | x <- xs, esNoTanBit x]

-- Pregunta 5 -------------------------------------------------------------------------------------------------------------------
contarNoTanBits :: [Int] -> (Int, Int)
contarNoTanBits x = (length (filter (==0) x), length (filter (==1) x))

-- Pregunta 6 -------------------------------------------------------------------------------------------------------------------
secuenciasNoTanBits :: Int -> [[Int]]
secuenciasNoTanBits n 
    | n < 1 = []    -- Según el enunciado, si n < 1, retornamos lista vacia
    | otherwise = combinaciones n    -- De lo contrario, llamamos a la función auxiliar combinaciones

-- Esta función se va a encargar de generar todas las combinaciones posibles de 0 y 1, de tamaño N
combinaciones :: Int -> [[Int]]  
combinaciones 0 = [[]] -- condición de parada para la recursión
combinaciones n = [x:xs | x <- [0, 1], xs <- combinaciones (n-1)]

{-
    Para la función de combinaciones usé como referencia la sección de Learn You a Haskell de listas 
    por comprensión, (https://learnyouahaskell.github.io/starting-out.html#im-a-list-comprehension) donde comentan que las listas por comprensión 
    generan combinaciones cuando se sacan elementos de dos listas.

    Se llama a combinaciones recursivamente para ir construyendo poco a poco la lista, por ejemplo para n = 2
    combinaciones 2
    = [x:xs | x <- [0, 1], xs <- combinaciones (2-1)]
    = [x:xs | x <- [0, 1], xs <- combinaciones 1]
    = [x:xs | x <- [0, 1], xs <- [[0], [1]]]
    = [0:[0]] ++ [0:[1]] ++ [1:[0]] ++ [1:[1]]
    = [[0, 0], [0, 1], [1, 0], [1, 1]]
-}

------------------------ PARTE I ------------------------------------------------------------------------------------------------
data Lista a = Vacia | Const a (Lista a)
 deriving Show

-- Pregunta 7 -------------------------------------------------------------------------------------------------------------------
aLista :: [a] -> Lista a
aLista [] = Vacia
aLista (x:xs) = Const x (aLista xs)

-- Pregunta 8 -------------------------------------------------------------------------------------------------------------------
aListaHaskell :: Lista a -> [a]
aListaHaskell Vacia = []
aListaHaskell (Const primero resto)= primero : aListaHaskell resto

-- Pregunta 9 -------------------------------------------------------------------------------------------------------------------
concatena :: Lista a -> Lista a -> Lista a
concatena Vacia bs = bs
concatena (Const x xs) bs = Const x (concatena xs bs)

-- Pregunta 10 -------------------------------------------------------------------------------------------------------------------
-- (++) :: Lista a -> Lista a -> Lista a
-- (++) = concatena 

-- Pregunta 11 -------------------------------------------------------------------------------------------------------------------
eliminaTodos :: (a -> Bool) -> Lista a -> Lista a
eliminaTodos _ Vacia = Vacia
eliminaTodos f (Const x xs)
  | f x       = eliminaTodos f xs   -- Como f es un predicado, si retorna True entonces se llama recursivamente y se omite el elemento x
  | otherwise = Const x (eliminaTodos f xs) -- de lo contrario, se mantiene el elemento y se evalua el resto de la lista

-- Pregunta 12 -------------------------------------------------------------------------------------------------------------------
{-
    Tomando como referencia el algoritmo de ordenamiento quicksort de la Nota de Docencia del Prof. Jorge Salas:
        quicksort [ ] = [ ]
        quicksort (x:xs) = yx ++ [x] ++ xy
            where 
                yx = quicksort [ y | y <- xs, y < x ]
                xy = quicksort [ y | y <- xs, y >= x ]

    Lo primero que hice fue implementar las ecuaciones del where pero con Lista a
-}

-- Esta función se usa para tener los elementos menores que x en una Lista a, 
--  corresponde con esta parte de la función de quicksort [ y | y <- xs, y < x ]
menores :: Ord a => a -> Lista a -> Lista a
menores _ Vacia = Vacia
menores x (Const y ys)
  | y < x = Const y (menores x ys)
  | otherwise = menores x ys

-- Esta función se usa para tener los elementos mayores o iguales que x en una Lista a, 
-- corresponde con esta parte de la función de quicksort [ y | y <- xs, y >= x ]
mayoresOigual :: Ord a => a -> Lista a -> Lista a
mayoresOigual _ Vacia = Vacia
mayoresOigual x (Const y ys)
  | y >= x = Const y (mayoresOigual x ys)
  | otherwise = mayoresOigual x ys

-- Luego, se puede implementar quicksort de esta forma:
quicksort :: (Ord a) => Lista a -> Lista a
quicksort Vacia = Vacia
quicksort (Const x xs) = yx `concatena` Const x xy  -- Usé la notación infija para aprovechar la función concatena definida en la pregunta 9
    where 
        yx = quicksort (menores x xs)
        xy = quicksort (mayoresOigual x xs)

-- Finalmente ordenar:
ordenar :: Ord a => Lista a -> Lista a
ordenar Vacia = Vacia
ordenar (Const x xs) = quicksort (Const x xs)