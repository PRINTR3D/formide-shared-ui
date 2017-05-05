import QtQuick 2.0
import "../../../utils"
import "../../../utils/keyboard/"

import "../../../../lib/formide/formide.js" as Formide

Item {

    id: root
    height: parent.height
    width: parent.width

    property var newValueX: 100
    property var newValueY: 100
    property var buttonText: "Change buttonText"
    property var unit: ""

    property var maxValue
    property var minValue

    signal confirmButton
    signal exitButton

    onNewValueXChanged: {
        if (newValueX < minValue)
            newValueX = minValue
    }

    onNewValueYChanged: {
        if (newValueY < minValue)
            newValueY = minValue
    }

    Component.onCompleted: {
        mousiX.contentX = newValueX * 20
        mousiY.contentX = newValueY * 20
    }


    /////////////
    /**X axis**/
    ////////////
    DefaultText {
        x: 16
        y: 24
        font.pixelSize: 16

        text: "Choose the best value for X"
    }

    Item {
        width: 216
        height: 112
        x: 24
        y: 64

        Flickable {
            id: mousiX
            width: parent.width
            height: parent.height
            anchors.centerIn: parent

            contentWidth: 480 + (maxValue * 20)
            contentHeight: parent.height
            boundsBehavior: Flickable.StopAtBounds
            onContentXChanged: newValueX = (contentX / 20).toFixed(0)
            clip: true
        }
    }

    DefaultText {
        width: 136
        height: 48
        x: 56
        y: 64
        text: newValueX
        horizontalAlignment: TextInput.AlignHCenter

        font.pixelSize: 48
    }

    // Arrow back
    Image {
        width: 32
        height: 48
        x: 24
        y: 64
        source: "../../Images/icons/noIcon.png"
        Rectangle {
            anchors.fill: parent
            color: "lightgrey"
            opacity: 0.1
        }
    }

    // Arrow forward
    Image {
        width: 32
        height: 48
        x: 192
        y: 64
        source: "../../Images/icons/noIcon.png"
        Rectangle {
            anchors.fill: parent
            color: "lightgrey"
            opacity: 0.1
        }
    }

    KeyboardLetter {
        width: 216
        height: 48
        x: 16
        y: 128
        letter: "Set X-axis Value"

        backgroundColor: "#46b1e6"
        letterColor: "#ffffff"
        letterSize: 16

        onClicked: {
            confirmButton.call()
        }
    }


    ////////////
    /**Y axis**/
    ////////////
    DefaultText {
        x: 244
        y: 24
        font.pixelSize: 16

        text: "Choose the best value for Y"
    }

    Item {
        width: 216
        height: 112
        x: 256
        y: 64

        Flickable {
            id: mousiY
            width: parent.width
            height: parent.height
            anchors.centerIn: parent

            contentWidth: 480 + (maxValue * 20)
            contentHeight: parent.height
            boundsBehavior: Flickable.StopAtBounds
            onContentXChanged: newValueY = (contentX / 20).toFixed(0)
            clip: true
        }
    }

    DefaultText {
        width: 136
        height: 48
        x: 288
        y: 64
        text: newValueY
        horizontalAlignment: TextInput.AlignHCenter

        font.pixelSize: 48
    }

    // Arrow back
    Image {
        width: 32
        height: 48
        x: 256
        y: 64
        source: "../../Images/icons/noIcon.png"
        Rectangle {
            anchors.fill: parent
            color: "lightgrey"
            opacity: 0.1
        }
    }

    // Arrow forward
    Image {
        width: 32
        height: 48
        x: 424
        y: 64
        source: "../../Images/icons/noIcon.png"
        Rectangle {
            anchors.fill: parent
            color: "lightgrey"
            opacity: 0.1
        }
    }

    KeyboardLetter {
        width: 216
        height: 48
        x: 248
        y: 128
        letter: "Set Y-axis Value"

        backgroundColor: "#46b1e6"
        letterColor: "#ffffff"
        letterSize: 16

        onClicked: {
            confirmButton.call()
        }
    }
}
