module Nexus.Ui.Common
  ( EventType (..)
  , fromEventType
  , Size
  ) where

import Prelude
import Data.Tuple (Tuple)

type Size = Tuple Number Number

data EventType = Change | Click | Release

fromEventType :: EventType -> String
fromEventType evt =
  case evt of
    Change -> "change"
    Click -> "click"
    Release -> "release"
