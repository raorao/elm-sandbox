module Sandbox where

import StartApp
import Effects
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Debug
import String exposing (..)

type alias Model =
  { checked: String }

type Action
  = NoOp
  | Rerender String

initialModel : Model
initialModel =
  { checked = "foobar" }

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
      "foobar"

    _ =
      Debug.log "rerendering with the following model:" (model)

    m =
      Debug.log "checked values should be" (forcedCheckedValue)
  in
    input
      [ type' "text"
      , value forcedCheckedValue
      , onWithOptions
          "change"
          defaultOptions
          targetValue
          (\bool -> Signal.message actionDispatcher (Rerender bool))
      ]
      []
