module Dashboard exposing (..)

import Time exposing (Time)


type alias LogsInfo =
    { logs : List String
    }


type alias TimeInfo =
    { events : List ( Time, Float )
    , yAxis : String
    }


type alias ScatterInfo =
    { points : List ( Float, Float )
    , xAxis : String
    , yAxis : String
    }



-- viewLogs : LogsInfo -> Html msg
-- viewTime : TimeInfo -> Html msg
-- viewScatter : ScatterInfo -> Html msg


type Widget
    = Logs LogsInfo
    | TimePlot TimeInfo
    | ScatterPlot ScatterInfo


view : Widget -> Html msg
view widget =
    case widget of
        Logs info ->
            viewLogs info

        TimePlot info ->
            viewTime info

        ScatterPlot info ->
            viewScatter info
