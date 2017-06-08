/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.2

import "../lib/formide/formide.js" as Formide
import "../lib"
import "utils"


FormideNativeUi {

    width:960
    height:544

    property var unitMultiplierX:width/480
    property var unitMultiplierY:height/272

    Component.onCompleted: {
        console.log("multiplier X",unitMultiplierX)
        console.log("multiplier Y",unitMultiplierY)
    }

    visible: true
    title: qsTr("formide-standard-ui")

    id: main

    // Stack pages
    property string viewStackActivePage: ""
    property int settingsIndexSelected: 0

    // initialized printer
    property bool initialized: false

    // Locked status
    property bool isLocked: false

    // Replacing material
    property bool replaced: false

    // Stopping print
    property bool stopping: false

//    onPrinterStarted: {
//        pagestack.clearScreenFast()
//    }

    onPrinterStopped: {
        stopping = true
    }

    onPrinterStatusEvent: {

        // clear stopping print screen once printer has finished stopping
        if (data.data.status==="online" && stopping){
            pagestack.clearScreenFast()
            stopping = false
        }

        if( (data.data.status === "online"|| data.data.status === "printing"
                                          || data.data.status === "heating"
                                          || data.data.status === "paused") && !initialized){
            initialized = true
            splash.visible = false
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (isLocked){
                pagestack.changeTransition("newPageComesFromUp")
                pagestack.pushPagestack(
                            Qt.resolvedUrl(
                                "utils/keyboard/VirtualKeypad.qml"))
            }
        }
    }

    function setPassCode(code) {
        passcode = code
        console.log("Locked: " + passcode)
        isLocked = true
        viewStackActivePage = "Dashboard"
        pagestack.clearScreenFast()
    }

    function checkPassCode(code) {
        if (passcode === code) {
            console.log("Unlocked from main")
            isLocked = false
            pagestack.popPagestack()
            return true
        } else {
            return false
        }
    }

    Background{}

    // This is the main page stack (StackView) of the application.
    // You can push pages and pop them by simply calling the functions push and pop
    Rectangle {

        width: 480
        height: 272
        rotation: 0

        transform:
                Scale{
                        origin.x:1;
                        origin.y:1;
                        xScale: unitMultiplierX>unitMultiplierY?unitMultiplierY:unitMultiplierX;
                        yScale: unitMultiplierX>unitMultiplierY?unitMultiplierY:unitMultiplierX;
        }

        StackView {
            id: pagestack
            anchors.fill: parent
            focus: true
            initialItem: Qt.resolvedUrl("Home.qml")

            property string transitionName: "newPageComesFromRight"
            property string action: "push"
            property bool isLocked: main.isLocked

            function clearScreenFast() {
                clear()
                pushPagestack(Qt.resolvedUrl("Home.qml"))
            }

            function popPagestack() {
                action = "pop"
                pop()
            }

            function pushPagestack(page) {
                action = "push"
                push(page)
            }

            function changeTransition(data) {
                transitionName = data
            }

            function setPassCode(code) {
                main.setPassCode(code)
            }

            function checkPassCode(code) {
                return main.checkPassCode(code)
            }

            delegate: StackViewDelegate {

                function getTransition(properties) {

                    //                    console.log("Transition name:",pagestack.transitionName)
                    if (pagestack.transitionName === "newPageComesFromRight") {
                        if (pagestack.action === "push")
                            return newPageComesFromRight
                        if (pagestack.action === "pop")
                            return newPageComesFromRightPop
                    }

                    if (pagestack.transitionName === "newPageComesFromLeft") {
                        if (pagestack.action === "push")
                            return newPageComesFromLeft
                        if (pagestack.action === "pop")
                            return newPageComesFromLeftPop
                    }

                    if (pagestack.transitionName === "newPageComesFromDown") {
                        if (pagestack.action === "push")
                            return newPageComesFromDown
                        if (pagestack.action === "pop")
                            return newPageComesFromDownPop
                    }

                    if (pagestack.transitionName === "newPageComesFromUp") {
                        if (pagestack.action === "push")
                            return newPageComesFromUp
                        if (pagestack.action === "pop")
                            return newPageComesFromUpPop
                    }

                    if (pagestack.transitionName === "newPageComesFromInside") {
                        return newPageComesFromInside
                    }

                    console.log("Warning: No transition selected")
                }

                property Component newPageComesFromInside: StackViewTransition {

                    PropertyAnimation {
                        target: enterItem
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 250
                    }
                    PropertyAnimation {
                        target: exitItem
                        property: "opacity"
                        from: 1
                        to: 0
                        duration: 300
                    }
                }

                property Component newPageComesFromRight: StackViewTransition {

                    PropertyAnimation {
                        target: enterItem
                        property: "x"
                        from: target.width
                        to: 0
                        duration: 250
                    }
                }

                property Component newPageComesFromRightPop: StackViewTransition {

                    PropertyAnimation {
                        target: exitItem
                        property: "x"
                        from: 0
                        to: target.width
                        duration: 250
                    }
                }

                property Component newPageComesFromLeft: StackViewTransition {

                    PropertyAnimation {
                        target: enterItem
                        property: "x"
                        from: -target.width
                        to: 0
                        duration: 250
                    }
                }

                property Component newPageComesFromLeftPop: StackViewTransition {

                    PropertyAnimation {
                        target: exitItem
                        property: "x"
                        from: 0
                        to: -target.width
                        duration: 250
                    }
                }

                property Component newPageComesFromDown: StackViewTransition {

                    PropertyAnimation {
                        target: enterItem
                        property: "y"
                        from: target.height
                        to: 0
                        duration: 250
                    }
                }

                property Component newPageComesFromDownPop: StackViewTransition {

                    PropertyAnimation {
                        target: exitItem
                        property: "y"
                        from: 0
                        to: target.height
                        duration: 250
                    }
                }

                property Component newPageComesFromUp: StackViewTransition {

                    PropertyAnimation {
                        easing.type: Easing.OutBounce
                        target: enterItem
                        property: "y"
                        from: -target.height
                        to: 0
                        duration: 600
                    }
                }

                property Component newPageComesFromUpPop: StackViewTransition {

                    PropertyAnimation {
                        target: exitItem
                        property: "y"
                        from: 0
                        to: -target.height
                        duration: 250
                    }
                }
            }
        } //Stackview
    } // Rectangle


    // always hide splash screen after 30 seconds timeout
    Timer {
        id: splashTimer

        interval: 30000
        repeat: false
        running: true

        onTriggered: {
            if (!printerStatus){
                splash.visible = false
                pagestack.changeTransition("newPageComesFromInside")
                pagestack.pushPagestack(Qt.resolvedUrl("utils/NoPrinterPopup.qml"))
            }
        }
    }

    // splash screen
    Image {
        id: splash
        width: parent.width
        height: parent.height
        visible: true
        source: "images/splash/splash.jpg"
    }

    Timer {
        id: hubsprint

        interval: 10000
        repeat: true
        running: true

        onTriggered: {
            getHubsQueue(function(){
                if (printerStatus.status === 'online' && queueHubsItems.length > 0){

                    main.startPrintFromHubsQueueId(
                                queueHubsItems[0].id,
                                queueHubsItems[0].printJob.gcode,
                                function (err, response) {
                                    if (err) {
                                        pagestack.pushPagestack(
                                                    Qt.resolvedUrl(
                                                        "../../utils/PrintingError.qml"))
                                    }
                                })

                    pagestack.changeTransition("newPageComesFromLeft")
                    pagestack.pushPagestack(Qt.resolvedUrl("pages/3dhubs/HubsPrintPage.qml"))
                }
            })
        }
    }

}
