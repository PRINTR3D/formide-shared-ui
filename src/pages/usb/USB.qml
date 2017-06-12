/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../../utils"

import "../../../lib/formide/formideShared.js" as FormideShared

Item {

    id: mainQueue
    height: parent.height
    width: parent.width

    property var fileIndexSelected
    property var driveFiles: main.driveFiles

    Component.onCompleted: {
        main.scanDrives()
        main.resetCheckConnections()
        main.isUsbConnected()
    }

    Timer {
        id: checkEverythingTimer
        running: true
        repeat: true
        interval: 15000
        onTriggered: {
            main.scanDrives()
        }
    }


    FileList {

        id: list
        type: "usb"

        visible: driveFiles.length > 0

        listModel: driveFiles


        function getImage(index) {
            return Qt.resolvedUrl("../../images/icons/files/DriveIcon.png")
        }

        onItemSelected: {
            FormideShared.fileIndexSelected = indexSelected

            main.updateDriveUnit(driveFiles[indexSelected], function(){
                pagestack.popPagestack()
                main.viewStackActivePage="USB Drive"
            })
            pagestack.pushPagestack(Qt.resolvedUrl("USBMounting.qml"))

        }

        Timer {
            id: contentytimer
            running: false
            repeat: false
            interval: 300
            onTriggered: {
                if ((FormideShared.fileIndexSelected + 2) < driveFiles.length) {
                    parent.contentY = 65 * fileIndexSelected
                } else {
                    parent.contentY = 0
                }
            }
        }
    }

    MessagePage {
        id: emptyList

        visible: driveFiles.length == 0

        firstText: "No USB drives found" // Text shown as title

        secondText: "Insert a USB drive to copy G-codes\nto the library"

        confirmButton: false // Showing confirm button
    }

}
