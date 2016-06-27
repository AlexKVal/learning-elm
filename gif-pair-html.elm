module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Gif


main =
    App.program
        { init = init "funny cats" "funny dogs"
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { left : Gif.Model
    , right : Gif.Model
    }


type Msg
    = Left Gif.Msg
    | Right Gif.Msg


init : String -> String -> ( Model, Cmd Msg )
init leftTopic rightTopic =
    let
        ( leftModel, leftCmd ) =
            Gif.init leftTopic

        ( rightModel, rightCmd ) =
            Gif.init rightTopic
    in
        ( Model leftModel rightModel
        , Cmd.batch [ Cmd.map Left leftCmd, Cmd.map Right rightCmd ]
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Left msg ->
            let
                ( leftModel, leftCmd ) =
                    Gif.update msg model.left
            in
                ( Model leftModel model.right, Cmd.map Left leftCmd )

        Right msg ->
            let
                ( rightModel, rightCmd ) =
                    Gif.update msg model.right
            in
                ( Model model.left rightModel, Cmd.map Right rightCmd )


view : Model -> Html Msg
view model =
    div [ style [ ( "display", "flex" ) ] ]
        [ App.map Left (Gif.view model.left)
        , App.map Right (Gif.view model.right)
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map Left (Gif.subscriptions model.left)
        , Sub.map Right (Gif.subscriptions model.right)
        ]
