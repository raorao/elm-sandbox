module Sandbox where

import StartApp
import Effects
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Debug

type alias Model =
  { checked: Bool }

type Action
  = NoOp
  | Rerender Bool

initialModel : Model
initialModel =
  { checked = True }

update action model =
  case action of
    Rerender newChecked ->
      let
        newModel =
          { model | checked <- newChecked }
      in
      (newModel, Effects.none)

    NoOp ->
      (model, Effects.none)

app =
  StartApp.start
    { init = init
    , view = view
    , update = update
    , inputs = [ ]
    }

main =
  app.html


init : (Model, Effects.Effects action)
init =
  (initialModel, Effects.none)

view actionDispatcher model =
  let
    forcedCheckedValue =
      True

    _ =
      Debug.log "rerendering with the following model:" (model)

    m =
      Debug.log "checked values should be" (forcedCheckedValue)
  in
    input
      [ type' "checkbox"
      , checked forcedCheckedValue
      , onWithOptions
          "change"
          defaultOptions
          targetChecked
          (\bool -> Signal.message actionDispatcher (Rerender bool))
      ]
      []
