module Main exposing (..)

import Html exposing (div, nav, ul, li, text)

main =
  div []
    [ nav []
        [ ul []
            [ li [] [ text "Finance" ]
              , li [] [ text "Sports" ]
            ]
        ]

    ]
