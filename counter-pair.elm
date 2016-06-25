module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Counter


main =
    App.beginnerProgram
        { model = init 0 0
        , update = update
        , view = view
        }


type alias Model =
    { topCounter : Counter.Model
    , bottomCounter : Counter.Model
    }


init : Int -> Int -> Model
init top bottom =
    { topCounter = Counter.init top
    , bottomCounter = Counter.init bottom
    }


type Msg
    = Reset
    | Top Counter.Msg
    | Bottom Counter.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Reset ->
            init 0 0

        Top counterMsg ->
            { model | topCounter = Counter.update counterMsg model.topCounter }

        Bottom counterMsg ->
            { model | bottomCounter = Counter.update counterMsg model.bottomCounter }


view : Model -> Html Msg
view model =
    div []
        [ App.map Top (Counter.view model.topCounter)
        , App.map Bottom (Counter.view model.bottomCounter)
        , button [ onClick Reset ] [ text "Reset" ]
        ]
