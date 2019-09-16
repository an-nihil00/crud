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
        ([ div [class "file"][text ("File: "++thread.image)]
        , div [class "postInfo"]
              [ input [type_ "checkbox"][]
              , span [class "subject"][text (" "++thread.subject++" ")]
              , span [class "name"][text thread.name]
              , text (" No."++(String.fromInt thread.thread_id))]
        , p[class "comment"][text thread.comment]]
        ++ List.map postView thread.posts)
        ]

postView : Post -> Html Msg
postView post =
    div[class "postWrapper"][ div[ class "sideArrows"][text ">>"]
         , div[ class "post" ]
              [ div [class "postInfo"]
                    [ input [type_ "checkbox"][]
                    , span [class "name"][text (" "++post.name)]
                    , text (" No."++(String.fromInt post.post_id))]
              , p[class "comment"][text post.comment]
              ]]
