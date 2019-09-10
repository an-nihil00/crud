--assets/src/Update.elm

module Update exposing (..)

import Messages exposing (..)
import Model exposing (..)

update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowInput ->
            { model | inputState = Editing}
        SubmitInput ->
            initialModel
        Name name ->
            let
                oldInputModel = model.inputModel
                newInputModel = { oldInputModel | name = name }
            in
                { model | inputModel = newInputModel }
        Options options ->
            let
                oldInputModel = model.inputModel
                newInputModel = { oldInputModel | options = options }
            in
                { model | inputModel = newInputModel }
        Subject subject ->
            let
                oldInputModel = model.inputModel
                newInputModel = { oldInputModel | subject = subject }
            in
                { model | inputModel = newInputModel }
        Comment comment ->
            let
                oldInputModel = model.inputModel
                newInputModel = { oldInputModel | comment = comment }
            in
                { model | inputModel = newInputModel }
        File file ->
            let
                oldInputModel = model.inputModel
                newInputModel = { oldInputModel | file = file }
            in
                { model | inputModel = newInputModel }
