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


    FileList {

        id: list
        type: "usb"

        visible: driveFiles.length > 0

        listModel: driveFiles


        function getImage(index) {
            console.log('file', JSON.stringify(driveFiles[index]))
            if(driveFiles[index].type === 'file'){
                return Qt.resolvedUrl("../../images/icons/files/GcodeIcon.png")
            }
            else if(driveFiles[index].type === 'dir'){
                return Qt.resolvedUrl("../../images/icons/files/FolderIcon.png")
            }
            else{
                return Qt.resolvedUrl("../../images/icons/noIcon.png")
            }

        }

        onItemSelected: {
            FormideShared.fileIndexSelected = indexSelected

            if(driveFiles[indexSelected].name && driveFiles[indexSelected].name.toLowerCase().indexOf(".gcode") !== -1){
                expanded = true
                status = "expanded"
                expandedMenuSize = 216
            }
            else if(driveFiles[indexSelected].type && driveFiles[indexSelected].type == "dir"){
                main.drivePath.push(driveFiles[indexSelected].name + '/')
                main.updateDriveFilesFromPath()
            }

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

        USBDriveItemExpanded {
            visible: list.status === "expanded"

            onFileClicked: {
                list.status = "list"
                list.expanded = !list.expanded
            }
            onCopyFile: {
                var path

                if(main.drivePath.length === 1){
                    path = driveFiles[FormideShared.fileIndexSelected].name
                }
                else {
                    path = main.drivePath.join('') + driveFiles[FormideShared.fileIndexSelected].name
                }

                main.copyFile(path, function(err, response){

                    if (response){
                        pagestack.pushPagestack(Qt.resolvedUrl("USBCopyConfirm.qml"))
                    }
                    else if (err){
                        pagestack.pushPagestack(Qt.resolvedUrl("USBCopyError.qml"))
                    }

                    list.status = "list"
                    list.expanded = !list.expanded
                })
                pagestack.pushPagestack(Qt.resolvedUrl("USBCopying.qml"))
            }
        }
    }

    PopupWindow {
        id: emptyList

        visible: driveFiles.length == 0

        firstText: "No G-code files or folders found" // Text shown as title

        centerText: true

        confirmButton: false // Showing confirm button
    }

}
