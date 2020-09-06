module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode exposing (Decoder)
import Route exposing (Route)
import Url
import Http

-- MAIN


main : Program () Model Msg
main =
  Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }



-- MODEL

--- DECODERS

type Model
  = Home 
  | NotFound

init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
  ( Home, Cmd.none )



-- UPDATE

type Msg
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url
      
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            ( model, Cmd.none
            )
                                
        UrlChanged url ->
            ( model, Cmd.none
            )
            
-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
        
-- VIEW

view : Model -> Browser.Document Msg
view model =
    case model of
        NotFound ->
            { title = "EmmyChan"
            , body =
                  [ 
                  ]
            }
        Home ->
            { title = "EmmyChan"
            , body =
                  [
                  ]
            }
    
