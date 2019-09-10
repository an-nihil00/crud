--assets/src/Input/View.elm

module Input.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (..)
import Model exposing (..)

inputView : Model -> Html Msg
inputView model =
    case model.inputState of
        Hidden ->
            div [ id "togglePostForm" ]
                [ text "[", a[onClick ShowInput][ text "Start a New Thread"],text "]"
                ]
        _ ->
            let
                saving =
                    case model.inputState of
                        Saving ->
                            True
                        _ ->
                            False
                invalid =
                    case model.inputState of
                        Invalid ->
                            True
                        _ ->
                            False
                buttonDisabled =
                    model.inputModel.subject == "" || saving || invalid
            in
                div [ id "input" ][Html.form[onSubmit SubmitInput]
                    [ inputField "Name" "text" "Anonymous" model.inputModel.name Name
                    , inputField "Options" "text" "" model.inputModel.options Options
                    , inputField "Subject" "text" "" model.inputModel.subject Subject
                    , inputField "Comment" "textarea" "" model.inputModel.comment Comment
                    , inputField "File" "file" "" model.inputModel.file File
                    ]]

inputField : String -> String -> String -> String -> (String -> Msg) -> Html Msg
inputField n t pl v toMsg =
    if t == "textarea" then
        div[ class "inputRow" ]
           [ div[ class "inputLabel" ][ p[][text n]]  
           , textarea [onInput toMsg][]
           ]
    else if n == "Subject" then
        div[ class "inputRow" ]
           [ div[ class "inputLabel" ][ p[][text n]]  
           , input [type_ t, placeholder pl, value v, onInput toMsg][]
           , input [type_ "submit", id "postButton", value "Post"][]
           ]
    else
        div[ class "inputRow" ]
           [ div[ class "inputLabel" ][ p[][text n]]  
           , input [type_ t, placeholder pl, value v, onInput toMsg][]
           ]
