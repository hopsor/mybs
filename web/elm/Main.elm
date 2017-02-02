module Main exposing (..)

import Html exposing (div, nav, ul, li, text)
import Html.Attributes exposing (..)

main =
  div [ class "wrapper" ]
    [ nav []
        [ ul []
            [ li [] [ text "Finance" ]
              , li [] [ text "Sports" ]
            ]
        ],
      div [ id "main" ] []
    ]
