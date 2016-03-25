module Main (..) where

import Html exposing (..)
import Highcharts exposing (..)


main : Signal Html
main =
  Signal.constant view


view : Html
view =
  div
    []
    [ highchart
        <| pie 40 [ ( "Oranges", 10 ), ( "Apples", 15 ), ( "Bananas", 8 ) ]
    ]
