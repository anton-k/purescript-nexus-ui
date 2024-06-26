module Nexus.Ui.Core.Common
  ( EventType (..)
  , fromEventType
  , Size
  ) where

import Data.Tuple (Tuple)

type Size = Tuple Number Number

data EventType = Change | Click | Release

fromEventType :: EventType -> String
fromEventType evt =
  case evt of
    Change -> "change"
    Click -> "click"
    Release -> "release"
