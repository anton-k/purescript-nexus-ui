module Nexus.Ui.General.RadioButton
  ( RadioButton
  , RadioButtonConfig
  , newRadioButton
  , newRadioButtonBy
  ) where

import Prelude
import Effect (Effect)
import Data.Tuple (fst, snd)
import Nexus.Ui.Core.Common (EventType, fromEventType, Size, ColorProperty, fromColorProperty, HexColor)

type RadioButton =
  { on :: EventType -> (Int -> Effect Unit) -> Effect Unit
  , setNumberOfButtons :: Int -> Effect Unit
  , getNumberOfButtons :: Effect Int
  , deselect :: Effect Unit
  , destroy :: Effect Unit
  , resize :: Size -> Effect Unit
  , select :: Int -> Effect Unit
  , colorize :: ColorProperty -> HexColor -> Effect Unit
  }

type RadioButtonConfig =
  { size :: Size
  , numberOfButtons :: Int
  , active :: Int
  }

newRadioButton :: String -> Effect RadioButton
newRadioButton target = do
  radio <- _newRadioButton target
  pure $ toRadioButton radio

newRadioButtonBy :: String -> RadioButtonConfig -> Effect RadioButton
newRadioButtonBy target config = do
  radio <- _newRadioButtonBy target (fromConfig config)
  pure $ toRadioButton radio

toRadioButton :: RadioButtonType -> RadioButton
toRadioButton radio =
  { on: _radioButtonOn radio <<< fromEventType
  , setNumberOfButtons: _radioButtonSetNumberOfButtons radio
  , getNumberOfButtons: _radioButtonGetNumberOfButtons radio
  , deselect: _radioButtonDeselect radio
  , destroy: _radioButtonDestroy radio
  , resize: \size -> _radioButtonResize radio (fst size) (snd size)
  , select: _radioButtonSelect radio
  , colorize: _radioButtonColorize radio <<< fromColorProperty
  }

fromConfig :: RadioButtonConfig -> RadioButtonInternalConfig
fromConfig config =
  { size: [fst config.size, snd config.size]
  , numberOfButtons: config.numberOfButtons
  , active: config.active
  }

foreign import data RadioButtonType :: Type

type RadioButtonInternalConfig =
  { size :: Array Number
  , numberOfButtons :: Int
  , active :: Int
  }

foreign import _newRadioButton :: String -> Effect RadioButtonType
foreign import _newRadioButtonBy :: String -> RadioButtonInternalConfig -> Effect RadioButtonType
foreign import _radioButtonSetNumberOfButtons :: RadioButtonType -> Int -> Effect Unit
foreign import _radioButtonGetNumberOfButtons :: RadioButtonType -> Effect Int
foreign import _radioButtonDeselect :: RadioButtonType -> Effect Unit
foreign import _radioButtonDestroy :: RadioButtonType -> Effect Unit
foreign import _radioButtonResize :: RadioButtonType -> Number -> Number -> Effect Unit
foreign import _radioButtonSelect :: RadioButtonType -> Int -> Effect Unit
foreign import _radioButtonOn :: RadioButtonType -> String -> (Int -> Effect Unit) -> Effect Unit
foreign import _radioButtonColorize :: RadioButtonType -> String -> String -> Effect Unit
