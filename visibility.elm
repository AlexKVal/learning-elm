module Visibility exposing (..)


type Visibility
    = All
    | Active
    | Completed


type alias Task =
    { task : String, complete : Bool }



-- some sample tasks


buy =
    { task = "Buy milk", complete = True }


drink =
    { task = "Drink milk", complete = False }


tasks =
    [ buy, drink ]


keep : Visibility -> List Task -> List Task
keep visibility tasks =
    case visibility of
        All ->
            tasks

        Active ->
            List.filter (\task -> not task.complete) tasks

        Completed ->
            List.filter (\task -> task.complete) tasks
