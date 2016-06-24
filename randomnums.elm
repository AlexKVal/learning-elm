module Main exposing (..)

import Html exposing (Html, div, h1, text, button)
import Html.App as Html
import Html.Events exposing (onClick)
import Random


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }


type alias Model =
    { dieFace : Int
    }


type Msg
    = Roll
    | NewFace Int


init : ( Model, Cmd Msg )
init =
    ( Model 1, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewFace (Random.int 1 6) )

        NewFace newRnd ->
            ( Model newRnd, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (toString model.dieFace) ]
        , button [ onClick Roll ] [ text "Roll" ]
        ]
