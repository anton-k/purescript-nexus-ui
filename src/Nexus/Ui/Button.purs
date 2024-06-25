module Nexus.Ui.Button
  ( Button (..)
  , newButton
  , newButtonBy
  , ButtonMode (..)
  ) where

import Prelude
import Effect (Effect)
import Nexus.Ui.Common (EventType, fromEventType, Size)
import Data.Tuple (fst, snd)

type Button =
  { on :: EventType -> Effect Unit -> Effect Unit
  , setMode :: ButtonMode -> Effect Unit
  , getMode :: Partial => Effect ButtonMode
  , setState :: Boolean -> Effect Unit
  , getState :: Effect Boolean
  , destroy :: Effect Unit
  , flip :: Effect Unit
  , resize :: Size -> Effect Unit
  , turnOff :: Effect Unit
  , turnOn :: Effect Unit
  }

type ButtonConfig =
  { size :: Size
  , mode :: ButtonMode
  , state :: Boolean
  }

data ButtonMode
    = PlainButton
    | AftertouchButton
    | ImpulseButton
    | ToggleButton

fromMode :: ButtonMode -> String
fromMode button =
  case button of
    PlainButton -> "button"
    AftertouchButton -> "aftertouch"
    ImpulseButton -> "impulse"
    ToggleButton -> "toggle"

toMode :: Partial => String -> ButtonMode
toMode str =
    case str of
      "button" -> PlainButton
      "aftertouch" -> AftertouchButton
      "impulse" -> ImpulseButton
      "toggle" -> ToggleButton

newButton :: String -> Effect Button
newButton target =
  map toButton $ _newButton target

newButtonBy :: String -> ButtonConfig -> Effect Button
newButtonBy target config =
  map toButton $ _newButtonBy target (toInternalConfig config)

toButton :: ButtonType -> Button
toButton button =
  { on: _buttonOn button <<< fromEventType
  , setMode: _buttonSetMode button <<< fromMode
  , getMode: map toMode (_buttonGetMode button)
  , setState: _buttonSetState button
  , getState: _buttonGetState button
  , destroy: _buttonDestroy button
  , flip: _buttonFlip button
  , resize: \size -> _buttonResize button (fst size) (snd size)
  , turnOff: _buttonTurnOff button
  , turnOn: _buttonTurnOn button
  }

toInternalConfig :: ButtonConfig -> ButtonInternalConfig
toInternalConfig config =
  { size: [fst config.size, snd config.size]
  , mode: fromMode config.mode
  , state: config.state
  }

type ButtonInternalConfig =
  { size :: Array Number
  , mode :: String
  , state :: Boolean
  }

foreign import data ButtonType :: Type

foreign import _newButton :: String -> Effect ButtonType
foreign import _newButtonBy :: String -> ButtonInternalConfig -> Effect ButtonType
foreign import _buttonOn :: ButtonType -> String -> Effect Unit -> Effect Unit
foreign import _buttonSetMode :: ButtonType -> String -> Effect Unit
foreign import _buttonGetMode :: ButtonType -> Effect String
foreign import _buttonSetState :: ButtonType -> Boolean -> Effect Unit
foreign import _buttonGetState :: ButtonType -> Effect Boolean
foreign import _buttonDestroy :: ButtonType -> Effect Unit
foreign import _buttonFlip :: ButtonType -> Effect Unit
foreign import _buttonResize :: ButtonType -> Number -> Number -> Effect Unit
foreign import _buttonTurnOff :: ButtonType -> Effect Unit
foreign import _buttonTurnOn :: ButtonType -> Effect Unit
