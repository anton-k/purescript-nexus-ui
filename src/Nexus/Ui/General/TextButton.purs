module Nexus.Ui.General.TextButton
  ( TextButton
  , TextButtonConfig
  , newTextButton
  , newTextButtonBy
  ) where

import Prelude
import Effect (Effect)
import Nexus.Ui.Core.Common (EventType, fromEventType, Size, ColorProperty, fromColorProperty, HexColor)
import Data.Tuple (Tuple (..), fst, snd)
import Data.Maybe (Maybe (..))
import JSON (JSON)
import JSON as J
import JSON.Object as JO

type TextButtonConfig =
  { size :: Size
  , state :: Boolean
  , text :: String
  , alternateText :: Maybe String
  }

type TextButton =
  { on :: EventType -> Effect Unit -> Effect Unit
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
  J.fromJObject $ JO.fromEntries $
    [ Tuple "size" (J.fromArray [J.fromNumber $ fst config.size, J.fromNumber $ snd config.size])
    , Tuple "state" (J.fromBoolean config.state)
    , Tuple "text" (J.fromString config.text)
    ]
    <> (case config.alternateText of
          Nothing -> []
          Just text -> [Tuple "alternateText" (J.fromString text)]
       )

type TextButtonInternalConfig = JSON

foreign import data TextButtonType :: Type

foreign import _newTextButton :: String -> Effect TextButtonType
foreign import _newTextButtonBy :: String -> TextButtonInternalConfig -> Effect TextButtonType
foreign import _textButtonOn :: TextButtonType -> String -> Effect Unit -> Effect Unit
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
