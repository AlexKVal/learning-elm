module Linkedlist exposing (..)


type IntList
    = Empty
    | Node Int IntList


sum : IntList -> Int
sum numbers =
    case numbers of
        Empty ->
            0

        Node n remainingNumbers ->
            n + sum remainingNumbers
