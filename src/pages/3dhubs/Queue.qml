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
    property var queueItems: main.queueHubsItems
    property var isConnectedToWifi: main.isConnectedToWifi

    Component.onCompleted: {
        main.getHubsQueue()
    }

    FileList {

        id: list
        type: "queue"

        visible: queueItems.length > 0 && isConnectedToWifi

        listModel: queueItems

        function getImage(index) {

            if (queueItems[index] !== undefined) {

                if (queueItems[index].printJob.sliceMethod === "custom") {
                    return Qt.resolvedUrl("../../images/icons/files/GcodeIcon.png")
                }
                else {
                    if (queueItems[index].printJob.images[0] !== undefined) {
                        return "https://storage.googleapis.com/images.formide.com/"
                                + queueItems[index].printJob.images[0]
                    }
                    else {
                        return Qt.resolvedUrl("../../images/icons/files/StlIcon.png")
                    }
                }

            } else
                return Qt.resolvedUrl("../../images/icons/noIcon.png")
        }

        onItemSelected: {
            FormideShared.fileIndexSelected = indexSelected
            expanded = true
            status = "expanded"
            expandedMenuSize = 216
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

        QueueItemExpanded {
            visible: list.status === "expanded"

            onFileClicked: {
                list.status = "list"
                list.expanded = !list.expanded
            }
            onPrintFile: {

                pagestack.changeTransition("newPageComesFromInside")

                main.startPrintFromHubsQueueId(
                            queueItems[fileIndexSelected].id,
                            queueItems[fileIndexSelected].printJob.gcode,
                            function (err, response) {
                                if (err) {
                                    pagestack.pushPagestack(
                                                Qt.resolvedUrl(
                                                    "../../utils/PrintingError.qml"))
                                }
                            })
                pagestack.pushPagestack(Qt.resolvedUrl("../../utils/PrintingSpinner.qml"))
            }

            onDeleteFile: {

                main.removeQueueItem(queueItems[fileIndexSelected].id)
                list.status = "list"
                list.expanded = !list.expanded
            }
        }
    }

    MessagePage {
        id: emptyList

        visible: queueItems.length == 0 && isConnectedToWifi

        firstText: "No queue items found" // Text shown as title

        secondText: "Add items via www.3dhubs.com"

        confirmButton: false // Showing confirm button
    }

    PopupWindow {
        id: wifiMessage

        visible: !isConnectedToWifi

        firstText: "Connect to Wi-Fi and try again" // Text shown as title

        centerText: true

        confirmButton: false // Showing confirm button
    }

}
