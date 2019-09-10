-- assets/src/ThreadList/View.elm

module ThreadList.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (..)
import Model exposing (..)

threadListView : ThreadList -> Html Msg
threadListView threadList =
    threadList.threads
        |>List.map threadView
        |>div [ id "board" ]

threadView : Thread -> Html Msg
threadView thread =
   div[][hr[][] , div [ class "thread" ]
        [
         
        ]]

postView : Post -> Html Msg
postView post =
    div[ class "post" ][p[class "postMessage"][text post.comment]]
