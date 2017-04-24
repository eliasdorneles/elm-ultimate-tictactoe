module Main exposing (..)

import Html as H exposing (Html)
import Html.Attributes as HA
import Html.Events as HE


type Msg
    = Clicked (Board -> Board)


type PlaceVal
    = Empty
    | X
    | O


type Player
    = PlayerX
    | PlayerO


type alias Board =
    { topLeft : PlaceVal
    , top : PlaceVal
    , topRight : PlaceVal
    , left : PlaceVal
    , center : PlaceVal
    , right : PlaceVal
    , bottomLeft : PlaceVal
    , bottom : PlaceVal
    , bottomRight : PlaceVal
    }


type alias Model =
    { currentPlayer : Player, board : Board }


main : Program Never Model Msg
main =
    H.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


init : ( Model, Cmd Msg )
init =
    ( { currentPlayer = PlayerX
      , board =
            { topLeft = Empty
            , top = Empty
            , topRight = Empty
            , left = Empty
            , center = Empty
            , right = Empty
            , bottomLeft = Empty
            , bottom = Empty
            , bottomRight = Empty
            }
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html Msg
view { currentPlayer, board } =
    H.div []
        [ drawRow board.topLeft board.top board.topRight
        , drawRow board.left board.center board.right
        , drawRow board.bottomLeft board.bottom board.bottomRight
        ]


drawRow : PlaceVal -> PlaceVal -> PlaceVal -> Html Msg
drawRow col1 col2 col3 =
    H.div [ HA.class "game-row" ] [ drawBox col1, drawBox col2, drawBox col3 ]


drawBox : PlaceVal -> Html Msg
drawBox place =
    H.span [ HA.class "box" ] [ H.text (boxText place) ]


boxText : PlaceVal -> String
boxText place =
    case place of
        Empty ->
            ""

        X ->
            "X"

        O ->
            "O"
