module Board exposing (Board, Position(..), empty, getPosition, setPosition)


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


type alias Board a =
    { topLeft : a
    , top : a
    , topRight : a
    , left : a
    , center : a
    , right : a
    , bottomLeft : a
    , bottom : a
    , bottomRight : a
    }


empty : a -> Board a
empty content =
    { topLeft = content
    , top = content
    , topRight = content
    , left = content
    , center = content
    , right = content
    , bottomLeft = content
    , bottom = content
    , bottomRight = content
    }


getPosition : Position -> Board a -> a
getPosition position board =
    case position of
        TopLeft ->
            board.topLeft

        Top ->
            board.top

        TopRight ->
            board.topRight

        Left ->
            board.left

        Center ->
            board.center

        Right ->
            board.right

        BottomLeft ->
            board.bottomLeft

        Bottom ->
            board.bottom

        BottomRight ->
            board.bottomRight


setPosition : Position -> a -> Board a -> Board a
setPosition position content board =
    case position of
        TopLeft ->
            { board | topLeft = content }

        Top ->
            { board | top = content }

        TopRight ->
            { board | topRight = content }

        Left ->
            { board | left = content }

        Center ->
            { board | center = content }

        Right ->
            { board | right = content }

        BottomLeft ->
            { board | bottomLeft = content }

        Bottom ->
            { board | bottom = content }

        BottomRight ->
            { board | bottomRight = content }
