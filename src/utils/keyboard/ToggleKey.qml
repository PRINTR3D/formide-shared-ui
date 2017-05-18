/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../"

MouseArea {

    id: key

    width: 40
    height: 40

    property var keyText: ""

    property var backgroundColor: "#d8d8d8"
    property var letterColor: "black"
    property var letterSize: 16
    property var toggled: false

    onToggledChanged: {
        if (toggled) {
            activate.start()
        } else {
            deactivate.start()
        }
    }

    Component.onCompleted: {
        if (toggled) {
            button.color = "#46b1e6"
        } else {
            button.color = backgroundColor
        }
    }

    SequentialAnimation {
        id: activate
        ColorAnimation {
            target: button
            property: "color"
            from: backgroundColor
            to: "#46b1e6"
            duration: 300
        }
    }

    SequentialAnimation {
        id: deactivate
        ColorAnimation {
            target: button
            property: "color"
            to: backgroundColor
            from: "#46b1e6"
            duration: 300
        }
    }

    Rectangle {
        id: button
        anchors.fill: parent
        radius: 3
        color: backgroundColor
    }

    DefaultText {

        font.pixelSize: letterSize
        color: "#ffffff"
        text: keyText
        x: parent.width + 8
        anchors.verticalCenter: parent.verticalCenter
    }

    onClicked: toggled = !toggled
}
