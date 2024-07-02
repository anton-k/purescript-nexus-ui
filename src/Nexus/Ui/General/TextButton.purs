module Nexus.Ui.General.TextButton
  ( TextButton
  , TextButtonConfig
  , newTextButton
  , newTextButtonBy
  ) where

import Prelude
import Nexus.Ui.Core.Button (ButtonMode, fromButtonMode, toButtonMode)
import Effect (Effect)
import Nexus.Ui.Core.Common (EventType, fromEventType, Size, ColorProperty, fromColorProperty, HexColor)
import Data.Tuple (fst, snd)

type TextButtonConfig =
  { size :: Size
  , mode :: ButtonMode
  , state :: Boolean
  , text :: String
  , alternateText :: String
  }

type TextButton =
  { on :: EventType -> Effect Unit -> Effect Unit
  , setMode :: ButtonMode -> Effect Unit
  , getMode :: Partial => Effect ButtonMode
  , setState :: Boolean -> Effect Unit
  , getState :: Effect Boolean
  , setText :: String -> Effect Unit
  , getText :: Effect String
  , setAlternateText :: String -> Effect Unit
  , getAlternateText :: Effect String
  , destroy :: Effect Unit
  , flip :: Effect Unit
  , resize :: Size -> Effect Unit
  , turnOff :: Effect Unit
  , turnOn :: Effect Unit
  , colorize :: ColorProperty -> HexColor -> Effect Unit
  }

newTextButton :: String -> Effect TextButton
newTextButton target =
  map toTextButton $ _newTextButton target

newTextButtonBy :: String -> TextButtonConfig -> Effect TextButton
newTextButtonBy target config =
  map toTextButton $ _newTextButtonBy target (toInternalConfig config)

toTextButton :: TextButtonType -> TextButton
toTextButton button =
  { on: _textButtonOn button <<< fromEventType
  , setMode: _textButtonSetMode button <<< fromButtonMode
  , getMode: map toButtonMode (_textButtonGetMode button)
  , setState: _textButtonSetState button
  , getState: _textButtonGetState button
  , setText: _textButtonSetText button
  , getAlternateText: _textButtonGetAlternateText button
  , setAlternateText: _textButtonSetAlternateText button
  , getText: _textButtonGetText button
  , destroy: _textButtonDestroy button
  , flip: _textButtonFlip button
  , resize: \size -> _textButtonResize button (fst size) (snd size)
  , turnOff: _textButtonTurnOff button
  , turnOn: _textButtonTurnOn button
  , colorize: _textButtonColorize button <<< fromColorProperty
  }

toInternalConfig :: TextButtonConfig -> TextButtonInternalConfig
toInternalConfig config =
  { size: [fst config.size, snd config.size]
  , mode: fromButtonMode config.mode
  , state: config.state
  , text: config.text
  , alternateText: config.alternateText
  }

type TextButtonInternalConfig =
  { size :: Array Number
  , mode :: String
  , state :: Boolean
  , text :: String
  , alternateText :: String
  }

foreign import data TextButtonType :: Type

foreign import _newTextButton :: String -> Effect TextButtonType
foreign import _newTextButtonBy :: String -> TextButtonInternalConfig -> Effect TextButtonType
foreign import _textButtonOn :: TextButtonType -> String -> Effect Unit -> Effect Unit
foreign import _textButtonSetMode :: TextButtonType -> String -> Effect Unit
foreign import _textButtonGetMode :: TextButtonType -> Effect String
foreign import _textButtonSetText :: TextButtonType -> String -> Effect Unit
foreign import _textButtonGetText :: TextButtonType -> Effect String
foreign import _textButtonSetAlternateText :: TextButtonType -> String -> Effect Unit
foreign import _textButtonGetAlternateText :: TextButtonType -> Effect String
foreign import _textButtonSetState :: TextButtonType -> Boolean -> Effect Unit
foreign import _textButtonGetState :: TextButtonType -> Effect Boolean
foreign import _textButtonDestroy :: TextButtonType -> Effect Unit
foreign import _textButtonFlip :: TextButtonType -> Effect Unit
foreign import _textButtonResize :: TextButtonType -> Number -> Number -> Effect Unit
foreign import _textButtonTurnOff :: TextButtonType -> Effect Unit
foreign import _textButtonTurnOn :: TextButtonType -> Effect Unit
foreign import _textButtonColorize :: TextButtonType -> String -> String -> Effect Unit
