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
            //CLOUD LOGIC
            if (queueItems[index].origin == "cloud") {
                if (queueItems[index].printJob.sliceMethod === "custom") {
                    return Qt.resolvedUrl("../../images/icons/gcodeIcon.png")
                } else {
                    return "https://storage.googleapis.com/images.formide.com/"
                            + queueItems[index].printJob.files[0].images[0]
                }
            } // LOCAL LOGIC
            else {

                var file = {

                }
                for (var i = 0, len = queueItems.length; i < len; i++) {
                    if (queueItems[i].id == queueItems[index].printJob.files[0].id)
                        file = queueItems[i]
                }

                if (file.filetype == "text/stl") {
                    var url = main.getImage(queueItems[index].id,
                                            file.images[0])
                    return url
                } else {
                    return Qt.resolvedUrl("../../images/icons/gcodeIcon.png")
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

        onClicked: {
            main.startPrintFromQueueId(
                        queueItems[fileIndexSelected].id,
                        queueItems[fileIndexSelected].printJob.gcode,
                        function (err, response) {
                            if (err) {
                                pagestack.pushPagestack(
                                            Qt.resolvedUrl(
                                                "../library/PrintingError.qml"))
                            }
                        })
            pagestack.pushPagestack(Qt.resolvedUrl("PrintingSpinner.qml"))
        }
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

        onClicked: {
            // TODO
        }
    }
}
