module Board exposing (..)


type Position
    = TopLeft
    | Top
    | TopRight
    | Left
    | Center
    | Right
    | BottomLeft
    | Bottom
    | BottomRight


type Player
    = X
    | O


type alias Board =
    List ( Position, Player )


getPosition : Position -> Board -> Maybe Player
getPosition position board =
    board
        |> List.filter (\( pos, player ) -> pos == position)
        |> List.head
        |> Maybe.map (\( pos, player ) -> player)


setPosition : Position -> Player -> Board -> Board
setPosition position player board =
    ( position, player ) :: board
