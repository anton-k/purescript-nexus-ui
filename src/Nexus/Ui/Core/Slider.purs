module Nexus.Ui.Core.Slider
  ( Slider (..)
  , newSlider
  , SliderConfig (..)
  , newSliderBy
  , SliderMode (..)
  , SliderInteraction (..)
  ) where

import Prelude
import Effect (Effect)
import Data.Tuple (fst, snd)
import Nexus.Ui.Core.Common (EventType, fromEventType, Size, ColorProperty, fromColorProperty, HexColor)

type SliderConfig =
  { size :: Size
  , interaction :: SliderInteraction
  , mode :: SliderMode
  , min :: Number
  , max :: Number
  , step :: Number
  , value :: Number
  }

type Slider =
  { on :: EventType -> (Number -> Effect Unit) -> Effect Unit
  , setMax :: Number -> Effect Unit
  , getMax :: Effect Number
  , setMin :: Number -> Effect Unit
  , getMin :: Effect Number
  , setMode :: SliderMode -> Effect Unit
  , getMode :: Partial => Effect SliderMode
  , setStep :: Number -> Effect Unit
  , getStep :: Effect Number
  , setValue :: Number -> Effect Unit
  , getValue :: Effect Number
  , destroy :: Effect Unit
  , resize :: Size -> Effect Unit
  , colorize :: ColorProperty -> HexColor -> Effect Unit
  }

newSlider :: String -> Effect Slider
newSlider target = do
  slider <- _newSlider target
  pure (toSlider slider)

newSliderBy :: String -> SliderConfig -> Effect Slider
newSliderBy target config = do
  slider <- _newSliderBy target (toInternalConfig config)
  pure (toSlider slider)

toSlider :: SliderType -> Slider
toSlider slider =
  { on: _sliderOn slider <<< fromEventType
  , setMax: _sliderSetMax slider
  , getMax: _sliderGetMax slider
  , setMin: _sliderSetMin slider
  , getMin: _sliderGetMin slider
  , setMode: _sliderSetMode slider <<< fromMode
  , getMode: map toMode (_sliderGetMode slider)
  , setStep: _sliderSetStep slider
  , getStep: _sliderGetStep slider
  , setValue: _sliderSetValue slider
  , getValue: _sliderGetValue slider
  , destroy: _sliderDestroy slider
  , resize: \size -> _sliderResize slider (fst size) (snd size)
  , colorize: _sliderColorize slider <<< fromColorProperty
  }

data SliderMode = RelativeSlider | AbsoluteSlider

fromMode :: SliderMode -> String
fromMode mode =
  case mode of
    RelativeSlider -> "relative"
    AbsoluteSlider -> "absolute"

toMode :: Partial => String -> SliderMode
toMode str =
  case str of
    "relative" -> RelativeSlider
    "absolute" -> AbsoluteSlider

data SliderInteraction = Raslider | Vertical | Horizontal

fromInteraction :: SliderInteraction -> String
fromInteraction mode =
  case mode of
    Raslider -> "raslider"
    Vertical -> "vertical"
    Horizontal -> "horizontal"

toInternalConfig :: SliderConfig -> SliderInternalConfig
toInternalConfig config =
  { size: [fst config.size, snd config.size]
  , interaction: fromInteraction config.interaction
  , mode: fromMode config.mode
  , min: config.min
  , max: config.max
  , step: config.step
  , value: config.value
  }

type SliderInternalConfig =
  { size :: Array Number
  , interaction :: String
  , mode :: String
  , min :: Number
  , max :: Number
  , step :: Number
  , value :: Number
  }

foreign import data SliderType :: Type

foreign import _newSlider :: String -> Effect SliderType
foreign import _newSliderBy :: String -> SliderInternalConfig -> Effect SliderType
foreign import _sliderOn :: SliderType -> String -> (Number -> Effect Unit) -> Effect Unit
foreign import _sliderSetMax :: SliderType -> Number -> Effect Unit
foreign import _sliderGetMax :: SliderType -> Effect Number
foreign import _sliderSetMin :: SliderType -> Number -> Effect Unit
foreign import _sliderGetMin :: SliderType -> Effect Number
foreign import _sliderSetMode :: SliderType -> String -> Effect Unit
foreign import _sliderGetMode :: SliderType -> Effect String
foreign import _sliderSetStep :: SliderType -> Number -> Effect Unit
foreign import _sliderGetStep :: SliderType -> Effect Number
foreign import _sliderSetValue :: SliderType -> Number -> Effect Unit
foreign import _sliderGetValue :: SliderType -> Effect Number
foreign import _sliderDestroy :: SliderType -> Effect Unit
foreign import _sliderResize :: SliderType -> Number -> Number -> Effect Unit
foreign import _sliderColorize :: SliderType -> String -> String -> Effect Unit
