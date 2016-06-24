module Main exposing (..)

import Html exposing (..)
import Html.App
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Http
import Task
import Json.Decode as Json


main =
    Html.App.program
        { init = init "cats"
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { topic : String
    , gifUrl : String
    }


init : String -> ( Model, Cmd Msg )
init topic =
    ( Model topic "waiting.gif"
    , getRandomGif topic
    )


type Msg
    = MorePlease
    | FetchSucceed String
    | FetchFail Http.Error


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MorePlease ->
            ( model, getRandomGif model.topic )

        FetchSucceed newUrl ->
            ( Model model.topic newUrl, Cmd.none )

        -- just ignore any error
        FetchFail _ ->
            ( model, Cmd.none )


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
    in
        Task.perform FetchFail FetchSucceed (Http.get decodeGifUrl url)


decodeGifUrl : Json.Decoder String
decodeGifUrl =
    Json.at [ "data", "image_url" ] Json.string


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick MorePlease ] [ text ("More " ++ model.topic ++ " Please!") ]
        , hr [] []
        , img [ src model.gifUrl ] []
        ]
