module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Url
import Url.Parser exposing (Parser, (</>), int, map, oneOf, s, string, fragment, parse, top)

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

type Route
  = Home
  | Board String
  | Thread String Int
  | Post String Int Int
  | NotFound

type alias Model =
  { key : Nav.Key
  , url : Url.Url
  , route : Route
  }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
  ( Model key url (toRoute (Url.toString url)), Cmd.none )



-- UPDATE

type Msg
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url

routeParser : Parser (Route -> a) a
routeParser =
  oneOf
    [ Url.Parser.map Home (top)
    , Url.Parser.map Board  (string)
    , Url.Parser.map threadOrPost (string </> int </> fragment (Maybe.andThen String.toInt))
    ]

threadOrPost : String -> Int -> Maybe Int -> Route
threadOrPost board thread maybe =
    case maybe of
        Just post ->
            Post board thread post

        Nothing ->
            Thread board thread
      
toRoute : String -> Route
toRoute string =
  case Url.fromString string of
    Nothing ->
      NotFound

    Just url ->
      Maybe.withDefault NotFound (parse routeParser url)
      
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )
                        
                Browser.External href ->
                    ( model, Nav.load href )
                                
        UrlChanged url ->
            ( { model | url = url
              , route = toRoute (Url.toString url) }
            , Cmd.none
            )

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

-- VIEW

view : Model -> Browser.Document Msg
view model =
    case model.route of
        Home ->
            { title = "EmmyChan"
            , body =
                  [
                  ]
            }
        Board board ->
            { title = board
            , body = [text board]
            }
        Thread board thread ->
            { title = board
            , body = [] 
            }
        Post board thread post ->
            { title = board
            , body = [] 
            }
        NotFound ->
            { title = "Not Found"
            , body = [] 
            }


viewLink : String -> Html msg
viewLink path =
    li [] [ a [ href path ] [ text path ] ]
