module Nexus.Ui.General.Multislider
  ( Multislider (..)
  , newMultislider
  , newMultisliderBy
  , MultisliderConfig
  , MultisliderMode (..)
  ) where

import Prelude
import Effect (Effect)
import Data.Tuple (fst, snd)
import Nexus.Ui.Core.Common (EventType, fromEventType, Size, ColorProperty, fromColorProperty, HexColor)

type Multislider =
  { on :: EventType -> (Array Number -> Effect Unit) -> Effect Unit
  , setSlider :: Int -> Number -> Effect Unit
  , setAllSliders :: Array Number -> Effect Unit
  , colorize :: ColorProperty -> HexColor -> Effect Unit
  }

type MultisliderConfig =
  { size :: Size
  , numberOfSliders :: Int
  , min :: Number
  , max :: Number
  , step :: Number
  , candycane :: Number
  , values :: Array Number
  , smoothing :: Number
  , mode :: MultisliderMode
  }

data MultisliderMode = BarMultislider | LineMultislider

fromMode :: MultisliderMode -> String
fromMode = case _ of
  BarMultislider -> "bar"
  LineMultislider -> "line"

newMultislider :: String -> Effect Multislider
newMultislider target =
  map toMultislider (_newMultislider target)

newMultisliderBy :: String -> MultisliderConfig -> Effect Multislider
newMultisliderBy target config =
  map toMultislider (_newMultisliderBy target (fromConfig config))

toMultislider :: MultisliderType -> Multislider
toMultislider mslider =
  { on: _multisliderOn mslider <<< fromEventType
  , setSlider: _multisliderSetSlider mslider
  , setAllSliders: _multisliderSetAllSliders mslider
  , colorize: _multisliderColorize mslider <<< fromColorProperty
  }

type MultisliderInternalConfig =
  { size :: Array Number
  , numberOfSliders :: Int
  , min :: Number
  , max :: Number
  , step :: Number
  , candycane :: Number
  , values :: Array Number
  , smoothing :: Number
  , mode :: String
  }

fromConfig :: MultisliderConfig -> MultisliderInternalConfig
fromConfig config =
  { size: [fst config.size, snd config.size]
  , mode: fromMode config.mode
  , min: config.min
  , max: config.max
  , step: config.step
  , values: config.values
  , smoothing: config.smoothing
  , numberOfSliders: config.numberOfSliders
  , candycane: config.candycane
  }

foreign import data MultisliderType :: Type

foreign import _newMultislider :: String -> Effect MultisliderType
foreign import _newMultisliderBy :: String -> MultisliderInternalConfig -> Effect MultisliderType
foreign import _multisliderOn :: MultisliderType -> String -> (Array Number -> Effect Unit) -> Effect Unit
foreign import _multisliderSetSlider :: MultisliderType -> Int -> Number -> Effect Unit
foreign import _multisliderSetAllSliders :: MultisliderType -> Array Number -> Effect Unit
foreign import _multisliderColorize :: MultisliderType -> String -> String -> Effect Unit
