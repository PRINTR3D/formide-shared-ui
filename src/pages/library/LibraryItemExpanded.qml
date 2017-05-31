/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../../utils"
import "../../utils/keyboard"

import "../../../lib/formide/formideShared.js" as FormideShared

Item {
    id: mainLibraryExtended
    height: parent.height
    width: parent.width

    signal fileClicked
    signal printFile
    signal deleteFile

    property var fileIndexSelected
    property var fileItems: main.fileItems
    property var printerStatus: main.printerStatus

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

    function getImage() {
        return Qt.resolvedUrl("../../images/icons/files/GcodeIcon.png")
    }

    function getName() {
        if (fileItems[fileIndexSelected])
            return fileItems[fileIndexSelected].filename
        else
            return ""
    }

    function isPrinting(){
        if (printerStatus.status == 'printing' || printerStatus.status == 'heating' || printerStatus.status == 'paused')
            return true
        else
            return false
    }

    function isPrintingThisFile(){
        var statusFilename = printerStatus.filePath.substring(printerStatus.filePath.lastIndexOf('/')+1)

        if ( statusFilename == fileItems[fileIndexSelected].filename && printerStatus.device == 'LOCAL' &&
            (printerStatus.status == 'printing' || printerStatus.status == 'heating' || printerStatus.status == 'paused') )

            return true
        else
            return false
    }


    SingleListItem {
        id: singleItem
        y: 8
        name: getName()
        fileImagePath: getImage()
        arrowImagePath: Qt.resolvedUrl("../../images/icons/overlays/LowerIcon.png")

        MouseArea {
            anchors.fill: parent
            onClicked: {
                fileClicked.call()
            }
        }
    }

    DefaultText {
        width: 432
        height: 24
        x: 24
        y: 89
        font.pixelSize: 16
        lineHeight: 1.5
        text: isPrintingThisFile() ? "Currently printing this file" : isPrinting() ? "Finish current print before starting a new print" : ""
    }

    KeyboardLetter {
        width: 216
        height: 48
        x: 24
        y: 129
        backgroundColor: "#ef4661"
        letterColor: "#ffffff"
        letter: "Delete File"
        letterSize: 16
        enabled: !isPrintingThisFile()

        onClicked: deleteFile.call()
    }

    KeyboardLetter {
        width: 216
        height: 48
        x: 248
        y: 129
        backgroundColor: "#46b1e6"
        letterColor: "#ffffff"
        letter: "Print File"
        letterSize: 16
        enabled: !isPrinting()

        onClicked: printFile.call()
    }

}
