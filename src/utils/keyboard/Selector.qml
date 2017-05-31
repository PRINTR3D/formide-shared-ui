/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../"

Rectangle {

    width: 240
    height: 48
    radius: 3
    color: "#dcdcde"

    property var listModel

    property var indexSelected: 0

    function getName(index) {
        if (listModel[index]) {
            return listModel[index].name
        } else
            return ""
    }

    Flickable {
        id: flick
        anchors.fill: parent
        contentHeight: height
        contentWidth: width * listModel.length
        clip: true

        property var position: 0

        SequentialAnimation {
            id: animation
            NumberAnimation {
                target: flick
                property: "contentX"
                to: flick.position
                duration: 100
                easing.type: Easing.InOutQuad
            }
        }

        onMovementEnded: {
            var units = (contentX / 240).toFixed(0)
            var movement = contentX % 240
            if (movement > 120) {
                position = (units * 240).toFixed(0)
            } else {
                position = (units * 240).toFixed(0)
            }
            animation.start()

            if (units > 0)
                indexSelected = units
            else
                indexSelected = 0
            console.log("Selected: " + units)
        }

        Repeater {
            model: listModel.length
            DefaultText {
                width: 205
                height: 24
                x: 17.3 + (240 * index)
                font.pixelSize: 16
                anchors.verticalCenter: parent.verticalCenter
                color: "#4a4a4a"
                horizontalAlignment: TextInput.AlignHCenter
                text: getName(index)

                //        DefaultText{
                ////            width: parent
                ////            height: parent
                //            font.pixelSize: 16
                //            anchors.centerIn: parent
                //            text: "Generic PLA"
                //            color: "#4a4a4a"
                //        }
            }
        }
    }

    // Arrow back
    Image {
        width: 22
        height: 32
        x: 13.5
        y: 8
        source: "../images/icons/overlays/LowerIcon.png"
    }

    // Arrow forward
    Image {
        width: 22
        height: 32
        x: 204.5
        y: 8
        source: "../images/icons/overlays/RaiseIcon.png"
    }
}
