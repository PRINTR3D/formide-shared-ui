/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../../utils"
import "../../utils/keyboard"

import "../../../lib/formide/formideShared.js" as FormideShared

Item {
    id: mainDriveExtended
    height: parent.height
    width: parent.width

    signal fileClicked
    signal copyFile

    property var fileIndexSelected
    property var driveFiles: main.driveFiles

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
        return Qt.resolvedUrl("../../images/icons/files/GcodeIcon.png")
    }

    function getName(index) {
        if (driveFiles[index].name)
            return driveFiles[index].name
        else
            return ""
    }


    SingleListItem {
        id: singleItem
        y: 8
        name: getName(fileIndexSelected)
        fileImagePath: getImage(fileIndexSelected)
        arrowImagePath: Qt.resolvedUrl("../../images/icons/overlays/LowerIcon.png")

        MouseArea {
            anchors.fill: parent
            onClicked: {
                fileClicked.call()
            }
        }
    }

    KeyboardLetter {
        width: 216
        height: 48
        x: 132
        y: 129
        backgroundColor: "#46b1e6"
        letterColor: "#ffffff"
        letter: "Copy to Library"
        letterSize: 16

        onClicked: copyFile.call()
    }
}
