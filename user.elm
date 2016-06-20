module User exposing (..)


type User
    = Anonymous
    | Named String


userPhoto : User -> String
userPhoto user =
    case user of
        Anonymous ->
            "anon.png"

        Named name ->
            "users/" ++ name ++ ".png"


activeUsers : List User
activeUsers =
    [ Anonymous, Named "John", Named "Jane", Anonymous ]


photos : List String
photos =
    List.map userPhoto activeUsers



-- elm-repl
-- > import User exposing (..)
-- > photos
--
-- ["anon.png","users/John.png","users/Jane.png","anon.png"] : List String
