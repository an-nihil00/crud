module Main exposing (main)

import Browser
import View
import Update
import Model

main = 
    Browser.sandbox { init = Model.initialModel , update = Update.update, view = View.view}
