module Highcharts where

import Graphics.Element exposing (..)

type alias Series =
    { name : String
    , data : List Int
    }

barChart : String -> List String -> String -> List Series -> Element
barChart = Native.Highcharts.barChart
