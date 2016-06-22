module Binarytree exposing (..)


type Tree a
    = Empty
    | Node a (Tree a) (Tree a)


empty =
    Empty


singleton v =
    Node v Empty Empty


insert : comparable -> Tree comparable -> Tree comparable
insert x tree =
    case tree of
        Empty ->
            singleton x

        Node y left right ->
            if x > y then
                Node y left (insert x right)
            else if x < y then
                Node y (insert x left) right
            else
                tree


fromList : List comparable -> Tree comparable
fromList xs =
    List.foldl insert empty xs


depth : Tree a -> Int
depth tree =
    case tree of
        Empty ->
            0

        Node v left right ->
            1 + max (depth left) (depth right)


map : (a -> b) -> Tree a -> Tree b
map f tree =
    case tree of
        Empty ->
            Empty

        Node v left right ->
            Node (f v) (map f left) (map f right)



-- 1 Sum all of the elements of a tree


sum : Tree number -> number
sum tree =
    case tree of
        Empty ->
            0

        Node v left right ->
            v + (sum left) + (sum right)



-- 2 Flatten a tree into a list


flatten : Tree a -> List a
flatten tree =
    case tree of
        Empty ->
            []

        Node v left right ->
            [ v ] ++ (flatten left) ++ (flatten right)



-- 3 Check to see if an element is in a given tree


isElement : a -> Tree a -> Bool
isElement x tree =
    case tree of
        Empty ->
            False

        Node v left right ->
            x == v || (isElement x left) || (isElement x right)



-- 4 General fold function for trees.


fold : (a -> b -> b) -> b -> Tree a -> b
fold f x tree =
    case tree of
        Empty ->
            x

        Node v left right ->
            fold f (fold f (f v x) left) right
