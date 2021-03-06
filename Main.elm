module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Random.Pcg exposing (Seed, int, initialSeed, step)


type alias Model =
    { currentSeed : Seed
    , name : String
    }


type Msg
    = Generate


definitely : Maybe a -> a
definitely ms =
    case ms of
        Just s ->
            s

        Nothing ->
            Debug.crash "what???"


getAt : Int -> List a -> Maybe a
getAt n xs =
    List.head (List.drop n xs)


adjectives : List String
adjectives =
    [ "affectionate"
    , "amiable"
    , "arrogant"
    ]


nouns : List String
nouns =
    [ "anvil"
    , "arrow"
    , "axe"
    ]


randNth : Seed -> List a -> ( Seed, Maybe a )
randNth seed coll =
    let
        seed =
            Debug.log "randNth.incomingSeed" seed

        generator =
            int 0 len

        len =
            Debug.log "randNth.listLength"
                (List.length coll)

        ( n, newSeed ) =
            Debug.log "randNth.stepper"
                (step generator seed)

        val =
            getAt n coll
    in
        ( newSeed, val )


make : Model -> ( Model, String )
make model =
    let
        seed : Seed
        seed =
            -- model.currentSeed
            Debug.log "RN.make.beginSeed" model.currentSeed

        seedX : Seed
        seedX =
            -- seed
            Debug.log "RN.make.seedX" seed

        ( seed0, mAdjective ) =
            randNth seedX adjectives

        ( seed1, mNoun ) =
            randNth seed0 nouns

        adjective =
            definitely mAdjective

        noun =
            definitely mNoun

        name =
            adjective ++ " " ++ noun

        model =
            { model | currentSeed = seed1 }
    in
        ( model, name )


model : Model
model =
    { currentSeed = initialSeed 0
    , name = "Click the button."
    }


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Generate ] [ text "Generate random name" ]
        , text ("The string is: " ++ model.name)
        ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        Generate ->
            let
                _ =
                    Debug.log "wtf" 5

                ( model, s ) =
                    make model
            in
                { model | name = s }


main : Program Never
main =
    Html.beginnerProgram { model = model, view = view, update = update }
