module Highcharts.ChartOptions (ChartOptions, defaultChartOptions, height) where

import Focus exposing (Focus)


type alias ChartOptions =
  { width : Int
  , height : Int
  , dynamicResize : Bool
  }


defaultChartOptions : ChartOptions
defaultChartOptions =
  { width = 200
  , height = 200
  , dynamicResize = True
  }


height : Focus ChartOptions Int
height =
  Focus.create .height (\f r -> { r | height = f r.height })
