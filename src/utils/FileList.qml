/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0

Flickable {
    id: root

    width: parent.width
    height: parent.height
    property bool expanded: false
    property int expandedMenuSize: 0 // By default, library item expanded size
    property string status: "list"
    property int expandedItem: 0
    property string type: ""
    property string name: ""

    property var listModel

    //:main.fileItems//:hardcodedFiles
    contentHeight: getContentHeight()
    contentWidth: width
    interactive: true
    clip: true

    signal itemSelected(var indexSelected, var name)
    property int indexSelected: 0

    Component.onCompleted: {

    }

    function getName(index) {
        if (type == "wifi") {
            return listModel[index]
        }
        if (type == "library") {
            return listModel[index].filename
        }
        if (type == "queue") {
            return listModel[index].printJob.name
        }
    }

    function getContentHeight() {

        var returnValue
        if (expanded) {
            returnValue = expandedMenuSize //expandedMenuSize + (65 * listModel.length)
        } else {
            returnValue = 65 * listModel.length
        }

        returnValue += 7

        return returnValue
    }

    function getVerticalPosition(index) {
        var returnValue
        if (expanded) {
            if (index > expandedItem) {
                returnValue = (65 * index) + expandedMenuSize
            } else {
                returnValue = 65 * index
            }
        } else {
            returnValue = 65 * index
        }

        returnValue += 8

        return returnValue
    }

    function expand(index) {
        if (index >= listModel.length) {
            console.log("Fatal error: index in list > list model length")
            return
        } else {
            expanded = true
            expandedItem = index
        }
    }

    function unexpand() {
        expanded = false
    }

    property int currentContentY: 0
    property int targetContentY: 0

    onStatusChanged: {
        if (status !== "list") {

            //animateContentY(0)
        }
        if (status === "list") {
            var newC = 65 * indexSelected
            if(contentHeight - newC > height)
                contentY=newC
            else
                contentY=contentHeight-height
        }
    }

    function animateContentY(target) {
        currentContentY = contentY
        targetContentY = target

        contentYAnimation.start()
    }

    PropertyAnimation {
        id: contentYAnimation
        target: root
        property: "contentY"
        from: currentContentY
        to: targetContentY
        duration: 300

        onStopped: {
            itemSelected(indexSelected, name)
        }
    }

    EmptySingleListItem {
        visible: isVisible()

        name: getEmptyName()

        function getEmptyName() {

            if (type === "wifi") {
                return "No Wi-Fi networks found"
            }
            if (type === "library") {
                return "No files in library"
            }
            if (type === "printJob") {
                return "No print jobs found"
            }
            if (type === "queue") {
                return "No queue items found"
            }
        }

        function isVisible() {
            if (listModel.length === 0)
                return true
            else
                return false
        }
    }

    Repeater {
        id: repeater
        model: listModel.length

        // This item will be repeated for each file in the list
        SingleListItem {
            id: files
            name: getName(index)
            arrowImagePath: Qt.resolvedUrl("../images/icons/dashboard/Overlays/RaiseIcon.png")
            timesImagePath: Qt.resolvedUrl("../images/icons/dashboard/Overlays/TimesIcon.png")
            fileImagePath: getImage(index)
            textSize: 24
            y: getVerticalPosition(index)
            wifi: getWifi()
            wifiActive: getWifiActive()

            visible: status === "list"

            property string status: root.status
            property bool statusResolved: false
            property int indexSelected: root.indexSelected

            function getWifi() {
                if (type === "wifi")
                    return true
                else
                    return false
            }

            function getWifiActive() {

                if (getWifi()) {

                    if (name === main.singleNetwork) {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            }

            onStatusChanged: {
                if (status === "list" && statusResolved === true) {
                    if (indexSelected === index) {
                        unrotateArrow()
                    }
                }
                statusResolved = true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {

                    if (type === "wifi") {
                        root.indexSelected = index
                        root.name = getName(index)
                        itemSelected(indexSelected, name)
                    } else {
                        root.indexSelected = index
                        root.name = getName(index)
                        animateContentY(index * 65)
                    }
                }
                propagateComposedEvents: true
            }
        }
    }
}
