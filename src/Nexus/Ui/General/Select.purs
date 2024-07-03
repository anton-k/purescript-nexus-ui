module Nexus.Ui.General.Select
  ( Select
  , SelectConfig
  , newSelect
  , newSelectBy
  , SelectItem
  ) where

import Prelude
import Effect (Effect)
import Nexus.Ui.Core.Common (EventType, fromEventType, Size, ColorProperty, fromColorProperty, HexColor)
import Data.Tuple (Tuple (..))

type Select =
  { defineOptions :: Array String -> Effect Unit
  , destroy :: Effect Unit
  , resize :: Size -> Effect Unit
  , getSelectedIndex :: Effect Int
  , setSelectedIndex :: Int -> Effect Unit
  , getValue :: Effect String
  , setValue :: String -> Effect Unit
  , on :: EventType -> (SelectItem -> Effect Unit) -> Effect Unit
  , colorize :: ColorProperty -> HexColor -> Effect Unit
  }

type SelectConfig =
  { size :: Size
  , options :: Array String
  }

newSelect :: String -> Effect Select
newSelect target =
  map toSelect (_newSelect target)

newSelectBy :: String -> SelectConfig -> Effect Select
newSelectBy target config =
  map toSelect (_newSelectBy target config)

toSelect :: SelectType -> Select
toSelect select =
  { defineOptions: _selectDefineOptions select
  , destroy: _selectDestroy select
  , resize: \(Tuple a b) -> _selectResize select a b
  , getSelectedIndex: _selectGetSelectedIndex select
  , setSelectedIndex: _selectSetSelectedIndex select
  , getValue: _selectGetValue select
  , setValue: _selectSetValue select
  , on: _selectOn select <<< fromEventType
  , colorize: _selectColorize select <<< fromColorProperty
  }

type SelectItem =
  { selectedIndex :: Int
  , value :: String
  }

foreign import data SelectType :: Type

foreign import _newSelect :: String -> Effect SelectType
foreign import _newSelectBy :: String -> SelectConfig -> Effect SelectType
foreign import _selectDefineOptions :: SelectType -> Array String -> Effect Unit
foreign import _selectDestroy :: SelectType -> Effect Unit
foreign import _selectGetSelectedIndex :: SelectType -> Effect Int
foreign import _selectSetSelectedIndex :: SelectType -> Int -> Effect Unit
foreign import _selectOn :: SelectType -> String -> (SelectItem -> Effect Unit) -> Effect Unit
foreign import _selectResize :: SelectType -> Number -> Number -> Effect Unit
foreign import _selectSetValue :: SelectType -> String -> Effect Unit
foreign import _selectGetValue :: SelectType -> Effect String
foreign import _selectColorize :: SelectType -> String -> String -> Effect Unit
