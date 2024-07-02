module Nexus.Ui.Core.Common
  ( EventType (..)
  , fromEventType
  , Size
  , ColorProperty (..)
  , fromColorProperty
  , HexColor
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

type HexColor = String

data ColorProperty
  = AccentColor
  | FillColor
  | DarkColor
  | LightColor
  | MediumDarkColor
  | MediumLightColor

fromColorProperty :: ColorProperty -> String
fromColorProperty = case _ of
  AccentColor -> "accent"
  FillColor -> "fill"
  DarkColor -> "dark"
  LightColor -> "light"
  MediumDarkColor -> "mediumdark"
  MediumLightColor -> "mediumLight"
