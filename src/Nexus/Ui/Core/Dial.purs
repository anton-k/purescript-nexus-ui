module Nexus.Ui.Core.Dial
  ( Dial (..)
  , newDial
  , DialConfig (..)
  , newDialBy
  , DialMode (..)
  , DialInteraction (..)
  ) where

import Prelude
import Effect (Effect)
import Data.Tuple (fst, snd)
import Nexus.Ui.Core.Common (EventType, fromEventType, Size, ColorProperty, fromColorProperty, HexColor)

type DialConfig =
  { size :: Size
  , interaction :: DialInteraction
  , mode :: DialMode
  , min :: Number
  , max :: Number
  , step :: Number
  , value :: Number
  }

type Dial =
  { on :: EventType -> (Number -> Effect Unit) -> Effect Unit
  , setMax :: Number -> Effect Unit
  , getMax :: Effect Number
  , setMin :: Number -> Effect Unit
  , getMin :: Effect Number
  , setMode :: DialMode -> Effect Unit
  , getMode :: Partial => Effect DialMode
  , setStep :: Number -> Effect Unit
  , getStep :: Effect Number
  , setValue :: Number -> Effect Unit
  , getValue :: Effect Number
  , destroy :: Effect Unit
  , resize :: Size -> Effect Unit
  , colorize :: ColorProperty -> HexColor -> Effect Unit
  }

newDial :: String -> Effect Dial
newDial target = do
  dial <- _newDial target
  pure (toDial dial)

newDialBy :: String -> DialConfig -> Effect Dial
newDialBy target config = do
  dial <- _newDialBy target (toInternalConfig config)
  pure (toDial dial)

toDial :: DialType -> Dial
toDial dial =
  { on: _dialOn dial <<< fromEventType
  , setMax: _dialSetMax dial
  , getMax: _dialGetMax dial
  , setMin: _dialSetMin dial
  , getMin: _dialGetMin dial
  , setMode: _dialSetMode dial <<< fromMode
  , getMode: map toMode (_dialGetMode dial)
  , setStep: _dialSetStep dial
  , getStep: _dialGetStep dial
  , setValue: _dialSetValue dial
  , getValue: _dialGetValue dial
  , destroy: _dialDestroy dial
  , resize: \size -> _dialResize dial (fst size) (snd size)
  , colorize: _dialColorize dial <<< fromColorProperty
  }

data DialMode = RelativeDial | AbsoluteDial

fromMode :: DialMode -> String
fromMode mode =
  case mode of
    RelativeDial -> "relative"
    AbsoluteDial -> "absolute"

toMode :: Partial => String -> DialMode
toMode str =
  case str of
    "relative" -> RelativeDial
    "absolute" -> AbsoluteDial

data DialInteraction = Radial | Vertical | Horizontal

fromInteraction :: DialInteraction -> String
fromInteraction mode =
  case mode of
    Radial -> "radial"
    Vertical -> "vertical"
    Horizontal -> "horizontal"

toInternalConfig :: DialConfig -> DialInternalConfig
toInternalConfig config =
  { size: [fst config.size, snd config.size]
  , interaction: fromInteraction config.interaction
  , mode: fromMode config.mode
  , min: config.min
  , max: config.max
  , step: config.step
  , value: config.value
  }

type DialInternalConfig =
  { size :: Array Number
  , interaction :: String
  , mode :: String
  , min :: Number
  , max :: Number
  , step :: Number
  , value :: Number
  }

foreign import data DialType :: Type

foreign import _newDial :: String -> Effect DialType
foreign import _newDialBy :: String -> DialInternalConfig -> Effect DialType
foreign import _dialOn :: DialType -> String -> (Number -> Effect Unit) -> Effect Unit
foreign import _dialSetMax :: DialType -> Number -> Effect Unit
foreign import _dialGetMax :: DialType -> Effect Number
foreign import _dialSetMin :: DialType -> Number -> Effect Unit
foreign import _dialGetMin :: DialType -> Effect Number
foreign import _dialSetMode :: DialType -> String -> Effect Unit
foreign import _dialGetMode :: DialType -> Effect String
foreign import _dialSetStep :: DialType -> Number -> Effect Unit
foreign import _dialGetStep :: DialType -> Effect Number
foreign import _dialSetValue :: DialType -> Number -> Effect Unit
foreign import _dialGetValue :: DialType -> Effect Number
foreign import _dialDestroy :: DialType -> Effect Unit
foreign import _dialResize :: DialType -> Number -> Number -> Effect Unit
foreign import _dialColorize :: DialType -> String -> String -> Effect Unit
