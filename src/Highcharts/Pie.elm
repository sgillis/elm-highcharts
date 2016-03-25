module Highcharts.Pie (PieOptions, PlotOptions, defaultOptions, pie) where


type alias PieOptions =
  { innerSize : Int
  , data : List PieData
  }


type alias PieData =
  { name : String
  , y : Float
  }


type alias PlotOptions =
  { dataLabels : DataLabel }


type alias DataLabel =
  { enabled : Bool
  , distance : Int
  }


pie : Int -> List ( String, Float ) -> PieOptions
pie innerSize data =
  let
    makeData ( name, value ) =
      { name = name
      , y = value
      }
  in
    { innerSize = innerSize
    , data =
        List.map makeData data
    }


defaultOptions : PlotOptions
defaultOptions =
  { dataLabels =
      { enabled = False
      , distance = -10
      }
  }
