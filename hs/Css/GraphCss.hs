{-# LANGUAGE OverloadedStrings #-}

module Css.GraphCss where

import Clay
import Prelude hiding ((**))
import Data.Monoid
import Css.Constants

{- graphStyles
 - Generates all CSS for the graph page. -}

graphStyles = do
    graphContainer
    sidebarCSS
    nodeCSS
    pathCSS
    resetCSS
    titleCSS
    modalCSS
    regionCSS

{- nodeCSS
 - Generates CSS for nodes in the graph. -}

nodeCSS = "g" ? do
    "text" ? do
        userSelect none
        "-webkit-touch-callout" -: "none"
        "-webkit-user-select" -: "none"
        "-khtml-user-select" -: "none"
        "-moz-user-select" -: "none"
        "-ms-user-select" -: "none"
    ".node" & do
        cursor pointer
        "text" ? do
            fontSize (pt 12)
            faded
        "data-active" @= "active" & do
            "rect" <? do
                wideStroke
            "text" <? do
                fullyVisible
        "data-active" @= "overridden" & do
            "rect" <? do
                wideStroke
                strokeRed
            "text" <? do
                fullyVisible
        "data-active" @= "inactive" & do
            "rect" <? do
                faded
                strokeDashed
        "data-active" @= "takeable" & do
            "rect" <? do
                semiVisible
            "text" <? do
                semiVisible
        "data-active" @= "missing" & do
            "rect" <> "ellipse" <? do
                wideStroke
                strokeRed
            "text" <? do
                fullyVisible
        "data-active" @= "unlit" & do
            wideStroke
            strokeRed
        "data-active" @= "unselected" & do
            "rect" <? do
                wideStroke
                faded
        -- For nodes in draw tab
        "data-group" @= "red" & do
            "rect" <? do
                fill dRed
        "data-group" @= "blue" & do
            "rect" <? do
                fill dBlue
        "data-group" @= "green" & do
            "rect" <? do
                fill dGreen
        "data-group" @= "purple" & do
            "rect" <? do
                fill dPurple
        "rect" <? do
            stroke "black"
    ".hybrid" & do
        cursor cursorDefault
    ".bool" & do
        cursor cursorDefault
        "data-active" @= "active" & do
            "ellipse" <? do
                fill "white"
                stroke "black"
        "data-active" @= "overridden" & do
            "ellipse" <? do
                fill "white"
                strokeRed
        "data-active" @= "inactive" & do
            "ellipse" <? do
                fill lightGrey
                faded
                strokeDashed
        "data-active" @= "takeable" & do
            "ellipse" <? do
                fill lightGrey
        "data-active" @= "missing" & do
            "ellipse" <? do
                fill "white"
                strokeRed
        "data-active" @= "unlit" & do
            wideStroke
            strokeRed
        "text" <? do
            fontFamily ["Comic Sans MS"] [sansSerif]
            fontWeight bold
    ".spotlight" & do
        semiVisible
        fill "white"
        stroke "none"

{- pathCSS
 - Generates CSS for paths between nodes
 - in the graph. -}

pathCSS = "path" ? do
    fill "none"
    "data-active" @= "takeable" & do
        strokeDashed
    "data-active" @= "inactive" & do
        faded
        strokeDashed
    "data-active" @= "active" & do
        opacity 1
        "stroke-width" -: "2px"
    "data-active" @= "missing" & do
        faded
        strokeRed
        strokeDashed
    "data-active" @= "drawn" & do
        faded
        wideStroke

{- resetCSS
 - Generates CSS for the reset feature
 - in the graph. -}

resetCSS = "#resetButton" ? do
    fill "#990000"
    cursor pointer
    wideStroke
    "stroke" -: "#404040"
    "text" <? do
        fill "white"

{- graphContainer
 - Generates CSS for the main division of
 - the page containing the graph. -}

graphContainer = do
    "#graph" ? do
        width (px 1100)
        minHeight (px 700)
        height (px 700)
        overflow hidden
        margin nil auto nil auto
        clear both
        float floatLeft
        display inlineBlock
        position absolute
    "#graphRootSVG" ? do
        width100
        height100
        stroke "black"
        "stroke-linecap" -: "square"
        "stroke-miterlimit" -: "10"
        "shape-rendering" -: "geometricPrecision"

sidebarCSS = do
    "#container" ? do
        width (pct 100)
        height (px 700)
        position relative
    "#sidebar" ? do 
        "border-radius" -: "4px"
        display inlineBlock
        width (px 20)
        height (pct 100)
        float floatLeft
        "background" -: "rgba(128,0,128,0.8)"
        position absolute
    "#sidebar-button" ? do
        cursor pointer
        "border-radius" -: "4px"
        display inlineBlock
        width (px 20)
        height (pct 100)
        float floatLeft
        backgroundColor purple1
        position absolute
    "#focuses, #graph" ? do
        cursor pointer
    "#sidebar-nav" ? do
        width (pct 100)
        fontSize (px 13)
        backgroundColor purple3
        border solid (px 1) grey2
        "border-radius" -: "4px"
        "box-shadow" -: "0 2px 2px -1px rgba(0, 0, 0, 0.055)"
        display block
        overflow hidden
        ul ? do
            width $ (pct 100)
            margin0
            li ? do
                "list-style-type" -: "none"
                display inlineBlock
                width (pct 48)
                --textAlign $ alignSide sideCenter
                "-webkit-transition" -: "all 0.2s"
                "-moz-transition" -: "all 0.2s"
                "-ms-transition" -: "all 0.2s"
                "-o-transition" -: "all 0.2s"
                "transition" -: "all 0.2s"
                ":hover" & do
                    "background-color" -: "#46364A !important"
                    a ? do
                        "color" -: "white !important" 
                a ? do
                    color black
                    display inlineBlock
                    lineHeight (px 30)
                    --paddingLeft (px 26)
                    textAlign $ alignSide sideCenter
                    width (pct 95)
                    textDecoration none


{- titleCSS
 - Generates CSS for the title. -}

titleCSS = "#svgTitle" ? do
    fontSize $ em 2.5
    fontWeight bold
    fontFamily ["Bitter"] [serif]
    fontStyle italic
    fill titleColour

{- regionCSS
 - Generates CSS for focus regions in the graph. -}

regionCSS = ".region-label" ? do
    "text-anchor" -: "start"

{- modalCSS
 - Generates CSS for the modal that appears
 - when nodes in the graph are clicked. -}

modalCSS = do
    ".ui-dialog" ? do
        outline solid (px 0) black
    ".ui-widget-overlay" ? do
        height100
        width100
        position fixed
        left nil
        top nil
    ".modal" ? do
        backgroundColor modalColor
        padding (px 20) (px 20) (px 20) (px 20)
        width (pct 70)
        height (pct 70)
        overflow auto
        position static
        p ? do
            color white
    ".ui-dialog-titlebar" ? do
        backgroundColor $ parse "#222266"
        color white
        fontSize (em 2)
        cursor move
        alignCenter
    ".ui-dialog-titlebar-close" ? do
        display none
    "#bottom-content-container" ? do
        paddingTop (em 1)
    ".ui-width-overlay" ? do
        height100
        width100
        left nil
        position fixed
        top nil
    ".ui-dialog" ? do
        tr ? do
            margin nil auto nil auto
