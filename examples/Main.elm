module Main where

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Signal exposing (..)
import Graphics.Element exposing (..)
import Highcharts exposing (..)
import String exposing (..)

type alias Model =
    { oranges : String }

emptyModel : Model
emptyModel = { oranges = "1" }

type Action = NoOp
            | UpdateOranges String

main : Signal Html
main = Signal.map view model

model : Signal Model
model = Signal.foldp update emptyModel actions.signal

update : Action -> Model -> Model
update a m = case a of
    NoOp -> m
    UpdateOranges s -> {m | oranges <- s}
        -- Ok x -> {m | oranges <- x}
        -- Err _ -> m

view : Model -> Html
view m = div []
    [ fromElement <| barChart "Test" ["Orange", "Apple", "Banana"] "Fruit eaten"
        [ { name="Michel", data=[validateInput m.oranges,5,2] }
        , { name="Jacques", data=[2,3,4] }
        ]
    , input [ value m.oranges
            , on "input" targetValue (Signal.message actions.address << UpdateOranges)
            ] []
    ]

validateInput : String -> Int
validateInput s = case toInt s of
    Ok x  -> x
    Err _ -> 0

actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp
