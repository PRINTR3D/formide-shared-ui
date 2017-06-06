/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../"

Item {
    id:root

    width: parent.width
    height: parent.height

    property var firstText:""                   // Text shown as title
    property var secondText:""                  // Text shown in subtitle

    property var confirmButtonText:""           // Text shown in confirm button

    property bool confirmButton:true            // Showing confirm button
    property bool exitButton:false

    property bool centerText:false              // Center first text

    signal confirmButtonSignal                  // Event emitted when pressing confirm
    signal quitButtonSignal                     // Event emitted when pressing the [X] button

    property var loading:false

    // Background
    Background{}

    MouseArea{
        anchors.fill: parent
    }

    // Home icon
    Item{
        width:80
        height:52
        visible:exitButton


        Image{
            width:30
            height:30
            x:25
            y:11
            source:"../images/icons/noIcon.png"

        }

        MouseArea{
            anchors.fill: parent
            onClicked: quitButtonSignal.call()
        }
    }



    DefaultText{

        height:32
        width: 368
        x: 56
        y:64

        horizontalAlignment: centerText ? TextInput.AlignHCenter: TextInput.AlignLeft

        font.family: "OpenSans"
        font.pixelSize:24
        lineHeightMode:Text.FixedHeight
        lineHeight:1.5
        color: "#ffffff"


        text:firstText
    }

    DefaultText{
        width:368
        height:48
        x:56
        y:112

        font.family: "OpenSans"
        font.pixelSize:16
        color: "#ffffff"
        wrapMode: "WordWrap"

        text: secondText
    }

    PushButton {
        visible:confirmButton

        x:132
        y:176

        buttonText: confirmButtonText
        backgroundColor: "#46b1e6"
        textColor: "#ffffff"

        onClicked: {
            confirmButtonSignal.call()
        }
    }


}


