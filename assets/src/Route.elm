module Route exposing (Route, toRoute)

import Url
import Url.Parser exposing (Parser, (</>), int, map, oneOf, s, string, fragment, parse, top)

type Route
  = Home
  | Board String
  | Thread String Int
  | Post String Int Int
  | NotFound

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
