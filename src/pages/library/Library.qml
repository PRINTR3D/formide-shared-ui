/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


import QtQuick 2.0
import "../../utils"
import "../../../lib/formide/formideShared.js" as FormideShared

Item {

    id: mainLibrary
    height: parent.height
    width: parent.width

    property var fileItems: main.fileItems

    Component.onCompleted: {
        main.getFiles()
    }

    Timer {
        id: checkEverythingTimer
        running: true
        repeat: true
        interval: 15000
        onTriggered: {
            main.getFiles()
        }
    }

    FileList {

        id: list
        listModel: fileItems
        type: "library"
        visible: fileItems.length > 0

        onItemSelected: {
            FormideShared.fileIndexSelected = indexSelected
            expanded = true
            status = "expanded"
            expandedMenuSize = 216
        }

        function getImage(index) {
            return Qt.resolvedUrl("../../images/icons/files/GcodeIcon.png")
        }

        LibraryItemExpanded {
            visible: list.status === "expanded"

            onFileClicked: {
                list.status = "list"
                list.expanded = !list.expanded
            }
            onPrintFile: {

                console.log("Printing file: " + list.listModel[fileIndexSelected].path)
                pagestack.changeTransition("newPageComesFromInside")

                pagestack.pushPagestack(Qt.resolvedUrl("../../utils/PrintingSpinner.qml"))
                main.startPrintFromFileSystem(
                            list.listModel[fileIndexSelected].path,
                            function (err, response) {
                                if (err) {
                                    console.log("File could not be printed",
                                                JSON.stringify(err))
                                    pagestack.pushPagestack(
                                                Qt.resolvedUrl(
                                                    "../../utils/PrintingError.qml"))
                                }
                                if (response) {
                                    console.log("Print file success",
                                                JSON.stringify(response))
                                    pagestack.popPagestack()
                                    main.viewStackActivePage = "Dashboard"
                                }
                            })
            }

            onDeleteFile: {

                main.removeFile(list.listModel[fileIndexSelected].path)
                list.status = "list"
                list.expanded = !list.expanded
            }
        }
    }

    MessageWindow {
        id: emptyList

        visible: fileItems.length == 0

        firstText: "No library items found" // Text shown as title

        secondText: "Add items from the queue or a USB device"

        confirmButton: false // Showing confirm button
    }
}
