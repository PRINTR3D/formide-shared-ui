/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../../utils"
import "../../utils/keyboard"

import "../../../lib/formide/formideShared.js" as FormideShared

Item {
    id: mainQueueExtended
    height: parent.height
    width: parent.width

    signal fileClicked
    signal printFile
    signal deleteFile

    property var fileIndexSelected
    property var queueItems: main.queueItems

    property var item

    onVisibleChanged: {
        if (!visible) {
            fileIndexSelected = 0
        }
        if (visible) {
            singleItem.rotateArrow()
            fileIndexSelected = FormideShared.fileIndexSelected
        }
    }

    function getImage(index) {

        if (queueItems[index] !== undefined) {

            if (queueItems[index].printJob.sliceMethod === "custom") {
                return Qt.resolvedUrl("../../images/icons/gcodeIcon.png")
            }
            else {
                if (queueItems[index].printJob.images[0] !== undefined) {
                    return "https://storage.googleapis.com/images.formide.com/"
                            + queueItems[index].printJob.images[0]
                }
                else {
                    return Qt.resolvedUrl("../../images/icons/stlIcon.png")
                }
            }

        } else
            return Qt.resolvedUrl("../../images/icons/noIcon.png")
    }

    function getName(index) {
        if (queueItems[index])
            return queueItems[index].printJob.name
        else
            return ""
    }

    SingleListItem {
        id: singleItem
        y: 8
        name: getName(fileIndexSelected)
        fileImagePath: getImage(fileIndexSelected)
        arrowImagePath: Qt.resolvedUrl("../../images/icons/dashboard/Overlays/LowerIcon.png")

        MouseArea {
            anchors.fill: parent
            onClicked: {
                fileClicked.call()
            }
        }
    }

    DefaultText {
        width: 112
        height: 24
        x: 24
        y: 89
        font.pixelSize: 16
        lineHeight: 1.5
        text: "Description"
    }

    DefaultText {
        width: 230
        height: 24
        x: 144
        y: 90
        font.pixelSize: 16
        lineHeightMode: Text.FixedHeight
        lineHeight: 2.25
        text: "GCODE File in local storage"
    }

    KeyboardLetter {
        width: 216
        height: 48
        x: 24
        y: 129
        backgroundColor: "#46b1e6"
        letterColor: "#ffffff"
        letter: "Print File"
        letterSize: 16
        enabled: printerStatus.status === "printing" ? false : true

        onClicked: printFile.call()
    }

    KeyboardLetter {
        width: 216
        height: 48
        x: 248
        y: 129
        backgroundColor: "#ef4661"
        letterColor: "#ffffff"
        letter: "Remove File"
        letterSize: 16
        enabled: printerStatus.queueItemId === queueItems[fileIndexSelected].id ? false : true

        onClicked: deleteFile.call()
    }
}
