module Nexus.Ui.General.Multislider
  ( Multislider (..)
  , newMultislider
  , newMultisliderBy
  , MultisliderConfig
  , MultisliderMode (..)
  ) where

import Prelude
import Nexus.Ui.Core.Common (EventType, fromEventType, Size)
import Effect (Effect)
import Data.Tuple (fst, snd)


type Multislider =
  { on :: EventType -> (Array Number -> Effect Unit) -> Effect Unit
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

toMode :: Partial => String -> MultisliderMode
toMode = case _ of
  "bar" -> BarMultislider
  "line" -> LineMultislider

newMultislider :: String -> Effect Multislider
newMultislider target =
  map toMultislider (_newMultislider target)

newMultisliderBy :: String -> MultisliderConfig -> Effect Multislider
newMultisliderBy target config =
  map toMultislider (_newMultisliderBy target (fromConfig config))

toMultislider :: MultisliderType -> Multislider
toMultislider mslider =
  { on: _multisliderOn mslider <<< fromEventType
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
