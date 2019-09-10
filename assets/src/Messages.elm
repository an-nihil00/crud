--assets/src/Messages.elm

module Messages exposing (..)

import Model exposing (..)

type Msg
    = ShowInput
    | SubmitInput
    | Name String
    | Options String
    | Subject String
    | Comment String
    | File String
