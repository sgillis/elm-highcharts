module Highcharts (Chart, highchart, pie, height) where

import Focus exposing (Focus, (=>))
import Html exposing (Html)
import Highcharts.ChartOptions exposing (ChartOptions, defaultChartOptions)
import Highcharts.Pie exposing (PieOptions)
import Native.Highcharts


type alias Chart =
  { chartOptions : ChartOptions
  , tooltip : String
  , plotOptions : List PlotOptions
  , series : Series
  }


type alias Series =
  List ChartType


type ChartType
  = Pie PieOptions


type PlotOptions
  = PieOptions Highcharts.Pie.PlotOptions


highchart : Chart -> Html
highchart =
  Native.Highcharts.highchart


makeChart : PlotOptions -> Series -> Chart
makeChart plotOptions series =
  { chartOptions = defaultChartOptions
  , tooltip = "{point.y}"
  , plotOptions = [ plotOptions ]
  , series = series
  }


pie : Int -> List ( String, Float ) -> Chart
pie innerSize data =
  makeChart
    (PieOptions Highcharts.Pie.defaultOptions)
    [ Pie <| Highcharts.Pie.pie innerSize data ]



-- FOCI


chartOptions : Focus Chart ChartOptions
chartOptions =
  Focus.create
    .chartOptions
    (\f r -> { r | chartOptions = f r.chartOptions })


height : Focus Chart Int
height =
  chartOptions => Highcharts.ChartOptions.height
