/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../../utils"

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
            fileIndexSelected = null
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
        if (printerStatus && (printerStatus.status == 'printing' || printerStatus.status == 'heating' || printerStatus.status == 'paused'))
            return true
        else
            return false
    }

    function isPrintingThisFile(){

        if(printerStatus){
            var statusFilename = printerStatus.filePath.substring(printerStatus.filePath.lastIndexOf('/')+1)

            if ( fileIndexSelected !== null && statusFilename == fileItems[fileIndexSelected].filename && printerStatus.device == 'LOCAL' &&
                (printerStatus.status == 'printing' || printerStatus.status == 'heating' || printerStatus.status == 'paused') )

                return true
            else
                return false
        }
        else{
            return false
        }


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
                if(!main.inputDisabled) {
                    main.inputDisabled = true
                    fileClicked.call()
                }
            }
        }
    }

    DefaultText {
        width: 432
        height: 24
        x: 24
        y: 89
        horizontalAlignment: TextInput.AlignHCenter
        font.pixelSize: 16
        lineHeight: 1.5
        text: !printerStatus ? "Printer not connected" : isPrintingThisFile() ? "Currently printing this file" : isPrinting() ? "Finish current print before starting a new print" : ""
    }

    PushButton {

        x: 24
        y: 129

        buttonText: "Delete File"
        backgroundColor: "#ef4661"
        textColor: "#ffffff"

        enabled: !isPrintingThisFile()

        onButtonClicked: deleteFile.call()

        function getInputDisabledValue(){
            return main.inputDisabled
        }

        function setInputDisabledValue(value){
            main.inputDisabled = value
        }
    }

    PushButton {

        x: 248
        y: 129

        buttonText: "Print File"
        backgroundColor: "#46b1e6"
        textColor: "#ffffff"

        enabled: !isPrinting() && printerStatus !== undefined

        function getInputDisabledValue(){
            return main.inputDisabled
        }

        function setInputDisabledValue(value){
            main.inputDisabled = value
        }

        onButtonClicked: printFile.call()
    }

}
