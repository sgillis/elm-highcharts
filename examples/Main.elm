module Main (..) where

import Effects exposing (Effects)
import Html exposing (..)
import Highcharts exposing (..)
import StartApp
import Task
import Time exposing (Time)


type alias Model =
  { time : Maybe ( Time, Time )
  , data : List ( String, Float )
  }


init : ( Model, Effects Action )
init =
  ( { time = Nothing
    , data = [ ( "Oranges", 10 ), ( "Apples", 15 ), ( "Bananas", 8 ) ]
    }
  , Effects.tick Tick
  )


type Action
  = NoOp
  | Tick Time


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    NoOp ->
      ( model, Effects.none )

    Tick time ->
      let
        newElapsed =
          case model.time of
            Nothing ->
              0

            Just ( prevTime, elapsedTime ) ->
              elapsedTime + (time - prevTime)

        data =
          if newElapsed > 3000 then
            [ ( "Oranges", 12 ), ( "Apples", 8 ), ( "Bananas", 13 ) ]
          else
            model.data
      in
        ( { model
            | time = Just ( time, newElapsed )
            , data = data
          }
        , Effects.tick Tick
        )


app : StartApp.App Model
app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = []
    }


main : Signal Html
main =
  app.html


port tasks : Signal (Task.Task Effects.Never ())
port tasks =
  app.tasks


view : Signal.Address Action -> Model -> Html
view address model =
  div
    []
    [ highchart
        <| pie 40 model.data
    ]
