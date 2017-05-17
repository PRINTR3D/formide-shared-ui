import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.2

import "../lib/formide/formide.js" as Formide
import "../lib"


FormideNativeUi {

    width:800
    height:480

    visible: true
    title: qsTr("formide-standard-ui")

    id: main

    // Stack pages
    property string viewStackActivePage: ""
    property int settingsIndexSelected: 0

    // Locked status
    property bool isLocked: false

    // Replacing material
    property bool replaced: false

    onPrinterStarted: {
        pagestack.clearScreenFast()
    }

    function setPassCode(code) {
        passcode = code
        console.log("Locked: " + passcode)
        isLocked = true
        viewStackActivePage = "Dashboard"
        pagestack.popPagestack()
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

    // This is the main page stack (StackView) of the application.
    // You can push pages and pop them by simply calling the functions push and pop
    Rectangle {

        width: parent.width
        height: parent.height
        rotation: 0

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

    onPrinterStatusChanged:
    {
        splash.visible=false
    }

    Timer{
        id:splashTimer

        interval: 5000
        repeat: false
        running: true

        onTriggered:
        {
            console.log("Disabling splash")
            splash.visible=false
        }
    }

    Rectangle{
        id:splash

        visible:false
        anchors.fill: parent
        Image{
            anchors.fill: parent
            source:"images/splash.jpg"
        }

    }
}
