/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../../utils"

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
                if(!main.inputDisabled) {
                    main.inputDisabled = true
                    fileClicked.call()
                }
            }
        }
    }

    PushButton {
        x: 132
        y: 129
        buttonText: "Copy to Library"

        backgroundColor: "#46b1e6"
        textColor: "#ffffff"

        function getInputDisabledValue(){
            return main.inputDisabled
        }

        function setInputDisabledValue(value){
            main.inputDisabled = value
        }

        onButtonClicked: copyFile.call()
    }
}
