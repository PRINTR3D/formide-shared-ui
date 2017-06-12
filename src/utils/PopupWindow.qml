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

    property var cancelButtonText:""            // Text shown on cancel button
    property var confirmButtonText:""           // Text shown in confirm button

    property bool cancelButton:false             // Showing cancel button
    property bool confirmButton:true            // Showing confirm button

    property bool centerText:false              // Center first text

    signal cancelButtonSignal                   // Event emitted when pressing cancel
    signal confirmButtonSignal                  // Event emitted when pressing confirm

    // Background
    Background{}

    DefaultText{

        height:32
        width: 368
        x: 56
        y:58

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
        y:106

        font.family: "OpenSans"
        font.pixelSize:16
        color: "#ffffff"
        wrapMode: "WordWrap"
        lineHeight:1.2

        text: secondText
    }

    PushButton {
        visible:cancelButton

        x: confirmButton ? 56 : 132
        y: 176
        width: confirmButton ? 176 : 216

        buttonText: cancelButtonText
        backgroundColor: "#ef4661"
        textColor: "#ffffff"

        function getInputDisabledValue(){
            return main.inputDisabled
        }

        function setInputDisabledValue(value){
            main.inputDisabled = value
        }

        onButtonClicked: {
            cancelButtonSignal.call()
        }
    }

    PushButton {
        visible:confirmButton

        x: cancelButton ? 248 : 132
        y: 176
        width: cancelButton ? 176 : 216

        buttonText: confirmButtonText
        backgroundColor: "#46b1e6"
        textColor: "#ffffff"

        function getInputDisabledValue(){
            return main.inputDisabled
        }

        function setInputDisabledValue(value){
            main.inputDisabled = value
        }

        onButtonClicked: {
            confirmButtonSignal.call()
        }
    }
}


