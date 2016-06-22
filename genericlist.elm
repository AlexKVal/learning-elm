module Genericlist exposing (..)


type List a
    = Empty
    | Node a (List a)
