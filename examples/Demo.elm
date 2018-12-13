module Main exposing
    ( Focused(..)
    , Model
    , Msg(..)
    , footerLink
    , init
    , main
    , subscriptions
    , update
    , view
    , viewApp
    , viewExamples
    , viewFooter
    , viewForkMe
    , viewHeader
    , viewLogo
    , viewSectionsExample
    , viewSimpleExample
    )

import AccessibleExample
import Browser
import ElmLogo
import Html exposing (Html)
import Html.Attributes as Attrs
import SectionsExample
import Svg
import Svg.Attributes as SvgAttrs
import Tuple


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> ( init, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.currentFocus of
        Simple ->
            Sub.map AccessibleExample (AccessibleExample.subscriptions model.accessibleAutocomplete)

        Sections ->
            Sub.map SectionsExample (SectionsExample.subscriptions model.sectionsAutocomplete)

        None ->
            Sub.none


type alias Model =
    { accessibleAutocomplete : AccessibleExample.Model
    , sectionsAutocomplete : SectionsExample.Model
    , currentFocus : Focused
    }


type Focused
    = Simple
    | Sections
    | None


init : Model
init =
    { accessibleAutocomplete = AccessibleExample.init
    , sectionsAutocomplete = SectionsExample.init
    , currentFocus = None
    }


type Msg
    = AccessibleExample AccessibleExample.Msg
    | SectionsExample SectionsExample.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        newModel =
            case msg of
                AccessibleExample autoMsg ->
                    let
                        updatedModel =
                            { model
                                | accessibleAutocomplete =
                                    Tuple.first (AccessibleExample.update autoMsg model.accessibleAutocomplete)
                            }
                    in
                    case autoMsg of
                        AccessibleExample.OnFocus ->
                            { updatedModel | currentFocus = Simple }

                        _ ->
                            updatedModel

                SectionsExample autoMsg ->
                    let
                        updatedModel =
                            { model
                                | sectionsAutocomplete =
                                    Tuple.first (SectionsExample.update autoMsg model.sectionsAutocomplete)
                            }
                    in
                    case autoMsg of
                        SectionsExample.OnFocus ->
                            { updatedModel | currentFocus = Sections }

                        _ ->
                            updatedModel
    in
    ( newModel, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div [ Attrs.class "app-container" ]
        [ viewForkMe
        , viewApp model
        ]


viewForkMe : Html Msg
viewForkMe =
    Html.a
        [ Attrs.attribute "aria-label" "View source on Github"
        , Attrs.class "github-corner"
        , Attrs.href "https://github.com/ContaSystemer/elm-menu"
        ]
        [ Svg.svg
            [ Attrs.attribute "aria-hidden" "true"
            , SvgAttrs.height "80"
            , SvgAttrs.style "fill:#70B7FD; color:#fff; position: absolute; top: 0; border: 0; right: 0;"
            , SvgAttrs.viewBox "0 0 250 250"
            , SvgAttrs.width "80"
            ]
            [ Svg.path [ SvgAttrs.d "M0,0 L115,115 L130,115 L142,142 L250,250 L250,0 Z" ]
                []
            , Svg.path
                [ SvgAttrs.class "octo-arm"
                , SvgAttrs.d "M128.3,109.0 C113.8,99.7 119.0,89.6 119.0,89.6 C122.0,82.7 120.5,78.6 120.5,78.6 C119.2,72.0 123.4,76.3 123.4,76.3 C127.3,80.9 125.5,87.3 125.5,87.3 C122.9,97.6 130.6,101.9 134.4,103.2"
                , SvgAttrs.fill "currentColor"
                , SvgAttrs.style "transform-origin: 130px 106px;"
                ]
                []
            , Svg.path
                [ SvgAttrs.class "octo-body"
                , SvgAttrs.d "M115.0,115.0 C114.9,115.1 118.7,116.5 119.8,115.4 L133.7,101.6 C136.9,99.2 139.9,98.4 142.2,98.6 C133.8,88.0 127.5,74.4 143.8,58.0 C148.5,53.4 154.0,51.2 159.7,51.0 C160.3,49.4 163.2,43.6 171.4,40.1 C171.4,40.1 176.1,42.5 178.8,56.2 C183.1,58.6 187.2,61.8 190.9,65.4 C194.5,69.0 197.7,73.2 200.1,77.6 C213.8,80.2 216.3,84.9 216.3,84.9 C212.7,93.1 206.9,96.0 205.4,96.6 C205.1,102.4 203.0,107.8 198.3,112.5 C181.9,128.9 168.3,122.5 157.7,114.1 C157.9,116.9 156.7,120.9 152.7,124.9 L141.0,136.5 C139.8,137.7 141.6,141.9 141.8,141.8 Z"
                , SvgAttrs.fill "currentColor"
                ]
                []
            ]
        ]


viewApp : Model -> Html Msg
viewApp model =
    Html.div [ Attrs.class "app" ]
        [ viewHeader model
        , viewExamples model
        , viewFooter
        ]


viewHeader : Model -> Html Msg
viewHeader model =
    Html.div [ Attrs.class "section header" ]
        [ Html.h1 [ Attrs.class "section-title" ] [ Html.text "Elm Menu" ]
        , viewLogo
        , Html.p [ Attrs.class "header-description" ] [ Html.text "A reusable, navigable menu for all your text input needs." ]
        , Html.a
            [ Attrs.class "try-it-link"
            , Attrs.href "https://github.com/ContaSystemer/elm-menu#installation"
            , Attrs.target "_blank"
            , Attrs.rel "noopenner noreferrer"
            ]
            [ Html.text "Try it out!" ]
        ]


viewLogo : Html msg
viewLogo =
    Html.a [ Attrs.href "http://elm-lang.org/", Attrs.target "_blank" ] [ ElmLogo.html 150 ]


viewExamples : Model -> Html Msg
viewExamples model =
    Html.div [ Attrs.class "section examples" ]
        [ Html.h1 [ Attrs.class "section-title" ] [ Html.text "Examples" ]
        , viewSimpleExample model.accessibleAutocomplete
        , viewSectionsExample model.sectionsAutocomplete
        ]


viewSimpleExample : AccessibleExample.Model -> Html Msg
viewSimpleExample autocomplete =
    Html.div [ Attrs.class "example" ]
        [ Html.div [ Attrs.class "example-info" ]
            [ Html.h1 [ Attrs.class "example-title" ] [ Html.text "Simple" ]
            , Html.p [] [ Html.text "A list of presidents" ]
            ]
        , Html.div [ Attrs.class "example-autocomplete" ]
            [ Html.map AccessibleExample (AccessibleExample.view autocomplete)
            ]
        ]


viewSectionsExample : SectionsExample.Model -> Html Msg
viewSectionsExample autocomplete =
    Html.div [ Attrs.class "example" ]
        [ Html.div [ Attrs.class "example-info" ]
            [ Html.h1 [ Attrs.class "example-title" ] [ Html.text "Sections" ]
            , Html.p [] [ Html.text "Presidents grouped by birth century" ]
            ]
        , Html.div [ Attrs.class "example-autocomplete" ] [ Html.map SectionsExample (SectionsExample.view autocomplete) ]
        ]


viewFooter : Html Msg
viewFooter =
    Html.div [ Attrs.class "section footer" ]
        [ Html.p []
            [ Html.text "Page design inspired by "
            , footerLink "http://react-autosuggest.js.org/" "React Autosuggest"
            ]
        , Html.p []
            [ Html.text "Created by "
            , footerLink "https://twitter.com/gregziegan" "Greg Ziegan"
            , Html.text " and "
            , footerLink "https://contasystemer.no/" "Conta Systemer AS"
            ]
        ]


footerLink : String -> String -> Html Msg
footerLink url text_ =
    Html.a
        [ Attrs.href url
        , Attrs.class "footer-link"
        , Attrs.target "_blank"
        , Attrs.rel "noopenner noreferrer"
        ]
        [ Html.text text_ ]
