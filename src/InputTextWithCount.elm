module InputTextWithCount exposing (newConfig, view)

{-
This is a module useful when you want to make a inputText has the limited number of characters (not words).

# Config

@docs newConfig

# InputTextView

@docs view

-}

import Html exposing (Attribute, Html, div, span, text)
import Html.Attributes exposing (class, classList, type_, value)
import Html.Events exposing (onInput)


{- This is the definition of Config to use inputTextWithCount.
-}
type Config
    = Config
        { classPrefix : String
        , maxLength : Int
        }


{- With this function, you can make a Config.
And then you can put it in the following view function.

    newConfig {classPrefix = "message", maxLength = 400  }

-}
newConfig :
    { classPrefix : String
    , maxLength : Int
    }
    -> Config
newConfig { classPrefix, maxLength } =
    Config
        { classPrefix = classPrefix
        , maxLength = maxLength
        }


{- Add a msg to receive a text which is input. And you can add attrs and elements if needed.

    "onInputMsg" is like
    "type Msg
            = OnInputMsg String"
-}

view : Config -> String -> (String -> msg) -> List (Attribute msg) -> List (Html msg) -> Html msg
view (Config { classPrefix, maxLength }) text onInputMsg attrs elements =
    let
        isOverMaxLength =
            String.length text > maxLength

        classes =
            classList
                [ ( classPrefix ++ "_inputWrap", True )
                , ( "is-caution", isOverMaxLength )
                ]

        defaultAttrs =
            [ type_ "text"
            , class (classPrefix ++ "_input")
            , value text
            ]
    in
    div [ classes ]
        [ div [ class (classPrefix ++ "TextCount") ]
            [ span
                [ class (classPrefix ++ "TextCount_num") ]
                [ Html.text <| String.fromInt <| String.length text ]
            , Html.text ("/" ++ String.fromInt maxLength)
            ]
        , Html.input
            (List.concat
                [ attrs
                , defaultAttrs
                , List.singleton <| onInput <| onInputMsg
                ]
            )
            elements
        ]

