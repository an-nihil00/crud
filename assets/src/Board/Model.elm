-- assets/src/Board/Model.elm

module Board.Model exposing (..)

type alias BoardModel =
    { threadList : ThreadList
    , error : Maybe String
    , input : Input
    }
    
type alias ThreadList =
    { threads : List Thread
    }

type alias Thread =
    { thread_id : Int
    , subject : String
    , name : String
    , comment : String
    , image : String
    , posts : List Post
    }
    
type alias Post =
    { post_id : Int
    , name : String
    , comment : String
    , image : String
    }

type Input = Hidden 
           | Editing
           | Saving
           | Invalid
           | Success
    
