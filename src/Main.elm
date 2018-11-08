module Main exposing (BigBoard, Model, Msg(..), PlaceVal, Player(..), SmallBoard, boxText, drawBigBoard, drawBoard, drawSmallBoard, init, main, nextPlayer, update, view)

import Board exposing (..)
import Browser
import Html as H exposing (Html)
import Html.Attributes as HA
import Html.Events as HE


type Msg
    = Clicked Position Position


type alias PlaceVal =
    Maybe Player


type alias SmallBoard =
    Board (Maybe Player)


type alias BigBoard =
    Board SmallBoard


type Player
    = X
    | O


type alias Model =
    { currentPlayer : Player, board : BigBoard }


main : Program () ( Model, Cmd Msg ) Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


init : ( Model, Cmd Msg )
init =
    ( { currentPlayer = X
      , board = Board.empty (Board.empty Nothing)
      }
    , Cmd.none
    )


update : Msg -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
update msg ( { currentPlayer, board }, cmd ) =
    case msg of
        Clicked bigPosition position ->
            let
                smallBoard =
                    getPosition bigPosition board

                updatedSmallBoard =
                    setPosition position (Just currentPlayer) smallBoard

                updatedModel =
                    { currentPlayer = nextPlayer currentPlayer
                    , board = setPosition bigPosition updatedSmallBoard board
                    }
            in
            ( updatedModel, Cmd.none )


nextPlayer : Player -> Player
nextPlayer player =
    case player of
        X ->
            O

        O ->
            X


view : ( Model, Cmd Msg ) -> Html Msg
view ( { currentPlayer, board }, cmd ) =
    drawBigBoard board


drawBoard : (Position -> a -> Html Msg) -> Board a -> Html Msg
drawBoard drawFunc board =
    H.table [ HA.class "board-container" ]
        [ H.tr [ HA.class "row board-row" ]
            [ H.td [ HA.class "board-column" ] [ drawFunc TopLeft board.topLeft ]
            , H.td [ HA.class "board-column" ] [ drawFunc Top board.top ]
            , H.td [ HA.class "board-column" ] [ drawFunc TopRight board.topRight ]
            ]
        , H.tr [ HA.class "row board-row" ]
            [ H.td [ HA.class "board-column" ] [ drawFunc Left board.left ]
            , H.td [ HA.class "board-column" ] [ drawFunc Center board.center ]
            , H.td [ HA.class "board-column" ] [ drawFunc Right board.right ]
            ]
        , H.tr [ HA.class "board-row" ]
            [ H.td [ HA.class "board-column" ] [ drawFunc BottomLeft board.bottomLeft ]
            , H.td [ HA.class "board-column" ] [ drawFunc Bottom board.bottom ]
            , H.td [ HA.class "board-column" ] [ drawFunc BottomRight board.bottomRight ]
            ]
        ]


drawSmallBoard : Position -> SmallBoard -> Html Msg
drawSmallBoard bigPosition =
    let
        drawFunc position content =
            H.span [ HA.class "box", HE.onClick (Clicked bigPosition position) ]
                [ H.text (boxText content) ]
    in
    drawBoard drawFunc


drawBigBoard : BigBoard -> Html Msg
drawBigBoard =
    let
        drawFunc position content =
            drawSmallBoard position content
    in
    drawBoard drawFunc


boxText : Maybe Player -> String
boxText place =
    case place of
        Nothing ->
            "\u{2003}"

        Just X ->
            "X"

        Just O ->
            "O"
