-- assets/src/Model.elm

module Model exposing (..)

type alias Model =
    { threadList : ThreadList
    , error : Maybe String
    , inputState : InputState
    , inputModel : InputModel
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

type InputState = Hidden|Editing|Saving|Invalid|Success
    
type alias InputModel =
    { name : String
    , options : String
    , subject : String
    , comment : String
    , file : String
    }
    
initialThreadList : ThreadList
initialThreadList =
    { threads = []
    }

initialInputModel : InputModel
initialInputModel =
    { name = ""
    , options = ""
    , subject = ""
    , comment = ""
    , file = ""
    }
    
initialModel : Model
initialModel =
    { threadList = initialThreadList
    , error = Nothing
    , inputState = Hidden
    , inputModel = initialInputModel
    }
