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

initialPost : Int -> Post
initialPost i =
    { post_id = i
    , name = "Anonymous"
    , comment = String.repeat i "aaaaaaaaaaa"
    , image = "testPicture.png"
    }

initialThread : Int -> Thread
initialThread i =
    { thread_id = i
    , subject = "test thread "++String.fromInt(i)
    , name = "Anonymous"
    , comment = "The story goes like this: Earth is captured by a technocapital singularity as rennaisance rationalization and coeanic navigation lock into commoditization takeoff"
    , image = "testPicture.png"
    , posts = List.map initialPost (List.range 1 10)
    }
    
initialThreadList : ThreadList
initialThreadList =
    { threads = List.map initialThread (List.range 1 10)
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
