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
    property var queueItems: main.queueItems

    FileList {

        id: list
        type: "queue"

        listModel: queueItems

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
                    for (var i = 0, len = fileItems.length; i < len; i++) {
                        if (fileItems[i].id == queueItems[index].printJob.files[0].id)
                            file = fileItems[i]
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

        onItemSelected: {
            FormideShared.fileIndexSelected = indexSelected

            pagestack.changeTransition("newPageComesFromInside")
            pagestack.pushPagestack(Qt.resolvedUrl("PrintConfirmation.qml"))

            contentytimer.restart()
        }

        Timer {
            id: contentytimer
            running: false
            repeat: false
            interval: 300
            onTriggered: {
                if ((FormideShared.fileIndexSelected + 2) < queueItems.length) {
                    parent.contentY = 65 * fileIndexSelected
                } else {
                    parent.contentY = 0
                }
            }
        }
    }
}
