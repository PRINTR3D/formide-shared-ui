import QtQuick 2.0
import "../"
import "../../../lib/formide/formide.js" as Formide

Rectangle {

    id: keypadPage
    width: 480
    height: 272

    property string currentPassword: ""

    signal pressLetter(var letter)
    signal remove
    signal submit
    signal exit


    //Keypad properties
    property var isLocked: parent.isLocked
    property bool confirming: false
    property string firstEntry: ""
    property string enterPasscode: ""

    onIsLockedChanged: {

    }


    /************
          FUNCTIONS
              ************/
    function enterText() {
        if (isLocked) {
            return "Enter Password"
        } else {
            if (!confirming)
                return "Create Password"
            else
                return "Confirm Password"
        }
    }

    function emptyPasscode() {
        enterPasscode = ""
    }

    function setPassCode(passcode) {
        if (!confirming) {
            firstEntry = passcode
            confirming = true
            emptyPasscode()
        } else {
            if (firstEntry === passcode) {
                parent.setPassCode(passcode)
            } else {
                emptyPasscode()
                confirming = false
                firstEntry = ""
            }
        }
    }

    function checkPassCode(passcode) {
        if (parent.checkPassCode(passcode)) {

        } else {
            emptyPasscode()
        }
    }

    onPressLetter: {

        if (letter === "clear") {
            emptyPasscode()
        } else {
            if (enterPasscode.length < 4)
                enterPasscode = enterPasscode + letter

            console.log("enterPasscode: " + enterPasscode)

            if (enterPasscode.length == 4) {
                if (!isLocked) {
                    // if we are locking
                    setPassCode(enterPasscode)
                } else {
                    //if we are unlocking
                    checkPassCode(enterPasscode)
                }
            }
        }
    }

    Component.onCompleted: {
        console.log("Is locked? " + isLocked)
    }

    // Blurry Background
    Image {
        anchors.fill: parent
        source: "../../images/blurBackground.png"
    }

    //Home Icon
    HomeIcon {
        type: "quit"
        onHomeClicked: {

            pagestack.popPagestack()
        }
    }

    DefaultText {
        x: 16
        y: 88
        font.pixelSize: 24
        text: enterText()
    }

    //Dot 1
    Rectangle {
        id: dot1
        width: 16
        height: 16
        x: 50
        y: 154
        radius: 5
        color: enterPasscode.length > 0 ? "#46b1e6" : "#ffffff"
    }

    //Dot 2
    Rectangle {
        id: dot2
        width: 16
        height: 16
        x: 80
        y: 154
        radius: 5
        color: enterPasscode.length > 1 ? "#46b1e6" : "#ffffff"
    }

    //Dot 3
    Rectangle {
        id: dot3
        width: 16
        height: 16
        x: 112
        y: 154
        radius: 5
        color: enterPasscode.length > 2 ? "#46b1e6" : "#ffffff"
    }

    //Dot 4
    Rectangle {
        id: dot4
        width: 16
        height: 16
        x: 144
        y: 154
        radius: 5
        color: enterPasscode.length > 3 ? "#46b1e6" : "#ffffff"
    }

    Item {
        y: 16
        KeypadLetter {
            x: 224
            letter: "1"
            onClicked: pressLetter("1")
            smallLetter: ""
        }

        KeypadLetter {
            x: 304
            letter: "2"
            onClicked: pressLetter("2")
            smallLetter: "ABC"
        }

        KeypadLetter {
            x: 384
            letter: "3"
            onClicked: pressLetter("3")
            smallLetter: "DEF"
        }
    }

    Item {
        y: 76

        KeypadLetter {
            x: 224
            letter: "4"
            onClicked: pressLetter("4")
            smallLetter: "GHI"
        }

        KeypadLetter {
            x: 304
            letter: "5"
            onClicked: pressLetter("5")
            smallLetter: "JKL"
        }

        KeypadLetter {
            x: 384
            letter: "6"
            onClicked: pressLetter("6")
            smallLetter: "MNO"
        }
    }

    Item {
        y: 136

        KeypadLetter {
            x: 224
            letter: "7"
            onClicked: pressLetter("7")
            smallLetter: "PQRS"
        }

        KeypadLetter {
            x: 304
            letter: "8"
            onClicked: pressLetter("8")
            smallLetter: "TUV"
        }

        KeypadLetter {
            x: 384
            letter: "9"
            onClicked: pressLetter("9")
            smallLetter: "WXYZ"
        }
    }

    Item {
        y: 196

        // Clear Key
        KeypadLetter {
            x: 224
            letter: "clear"
            backgroundColor: "#646464"
            opacity: 0.6
            onClicked: pressLetter("clear")
        }

        KeypadLetter {
            x: 304
            letter: "0"
            onClicked: pressLetter("0")
        }

        KeypadLetter {
            x: 384
            letter: "back"
            Image {
                width: 44
                height: 32
                anchors.centerIn: parent
                source: "../../images/icons/keyboard/BackIcon.png"
            }
            backgroundColor: "#646464"
            opacity: 0.6
            onClicked: remove.call()
        }
    }
}