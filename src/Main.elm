module Main exposing (..)

import Html as H exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import Board exposing (..)


type Msg
    = Clicked Position


type alias PlaceVal =
    Maybe Player


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
    ( { currentPlayer = X
      , board = []
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg { currentPlayer, board } =
    case msg of
        Clicked position ->
            ( { currentPlayer = nextPlayer currentPlayer
              , board = setPosition position currentPlayer board
              }
            , Cmd.none
            )


nextPlayer : Player -> Player
nextPlayer player =
    case player of
        X ->
            O

        O ->
            X


view : Model -> Html Msg
view { currentPlayer, board } =
    H.div [ HA.class "container board-container" ]
        [ drawRow board TopLeft Top TopRight
        , drawRow board Left Center Right
        , drawRow board BottomLeft Bottom BottomRight
        ]


drawRow : Board -> Position -> Position -> Position -> Html Msg
drawRow board left center right =
    H.div [ HA.class "row board-row" ] [ drawBox board left, drawBox board center, drawBox board right ]


drawBox : Board -> Position -> Html Msg
drawBox board position =
    H.span [ HA.class "box col-sm-4", HE.onClick (Clicked position) ] [ H.text (boxText (getPosition position board)) ]


boxText : Maybe Player -> String
boxText place =
    case place of
        Nothing ->
            " "

        Just X ->
            "X"

        Just O ->
            "O"
