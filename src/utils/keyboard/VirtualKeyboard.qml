import QtQuick 2.0
import "../"

Rectangle {

    id: root
    width: parent.width
    height: parent.height
    color: "#0a0a0a"

    property var currentPassword: ""
    property var activeKeyboard: "lowerCase"

    signal pressLetter(var letter)
    signal remove
    signal submit
    signal submitPassword(var password)
    signal exit

    onSubmit: {
        console.log("Password", currentPassword)
    }

    onPressLetter: {
        currentPassword += letter
    }
    onRemove: {
        currentPassword = currentPassword.substring(0,
                                                    currentPassword.length - 1)
    }

    function getPasswordText() {
        var returnPassword = ""
        if (currentPassword.length > 1) {
            var i
            for (i = 0; i < currentPassword.length - 1; i++) {
                returnPassword += "*"
            }
            returnPassword += currentPassword.substring(
                        currentPassword.length - 1, currentPassword.length)
        } else
            returnPassword = currentPassword

        return returnPassword
    }

    //Home Icon
    HomeIcon {
        type: "quit"
        onHomeClicked: {
            exit.call()
        }
    }

    // Input field
    Rectangle {
        color: "#505050"
        width: 348
        height: 30
        x: 110
        y: 13
        radius: 3

        DefaultText {

            anchors.centerIn: parent
            color: "#ffffff"
            text: getPasswordText()
        }
    }

    // Low Case Letters Keyboard - qwertyuiop
    Item {
        visible: activeKeyboard == "lowerCase"
        y: 55
        KeyboardLetter {
            x: 22
            letter: "q"
            onClicked: pressLetter("q")
        }

        KeyboardLetter {
            x: 66
            letter: "w"
            onClicked: pressLetter("w")
        }

        KeyboardLetter {
            x: 110
            letter: "e"
            onClicked: pressLetter("e")
        }

        KeyboardLetter {
            x: 154
            letter: "r"
            onClicked: pressLetter("r")
        }

        KeyboardLetter {
            x: 198
            letter: "t"
            onClicked: pressLetter("t")
        }

        KeyboardLetter {
            x: 242
            letter: "y"
            onClicked: pressLetter("y")
        }

        KeyboardLetter {
            x: 286
            letter: "u"
            onClicked: pressLetter("u")
        }

        KeyboardLetter {
            x: 330
            letter: "i"
            onClicked: pressLetter("i")
        }

        KeyboardLetter {
            x: 374
            letter: "o"
            onClicked: pressLetter("o")
        }

        KeyboardLetter {
            x: 418
            letter: "p"
            onClicked: pressLetter("p")
        }
    }

    // Low Case Letters Keyboard - asdfghjkl
    Item {
        visible: activeKeyboard == "lowerCase"
        y: 108

        KeyboardLetter {
            x: 46
            letter: "a"
            onClicked: pressLetter("a")
        }

        KeyboardLetter {
            x: 90
            letter: "s"
            onClicked: pressLetter("s")
        }

        KeyboardLetter {
            x: 134
            letter: "d"
            onClicked: pressLetter("d")
        }

        KeyboardLetter {
            x: 178
            letter: "f"
            onClicked: pressLetter("f")
        }

        KeyboardLetter {
            x: 222
            letter: "g"
            onClicked: pressLetter("g")
        }

        KeyboardLetter {
            x: 266
            letter: "h"
            onClicked: pressLetter("h")
        }

        KeyboardLetter {
            x: 310
            letter: "j"
            onClicked: pressLetter("j")
        }
        KeyboardLetter {
            x: 354
            letter: "k"
            onClicked: pressLetter("k")
        }
        KeyboardLetter {
            x: 398
            letter: "l"
            onClicked: pressLetter("l")
        }
    }

    // Low Case Letters Keyboard - zxcvbnm
    Item {
        visible: activeKeyboard == "lowerCase"
        y: 161

        // Shift Key
        KeyboardLetter {
            x: 22
            letter: ""
            Image {
                width: 18
                height: 16
                anchors.centerIn: parent
                source: "../../images/icons/keyboard/Shift.png"
            }
            backgroundColor: "#dcdcde"
            onClicked: activeKeyboard = "upperCase"
        }

        KeyboardLetter {
            x: 66
            letter: "z"
            onClicked: pressLetter("z")
        }

        KeyboardLetter {
            x: 110
            letter: "x"
            onClicked: pressLetter("x")
        }

        KeyboardLetter {
            x: 154
            letter: "c"
            onClicked: pressLetter("c")
        }

        KeyboardLetter {
            x: 198
            letter: "v"
            onClicked: pressLetter("v")
        }

        KeyboardLetter {
            x: 242
            letter: "b"
            onClicked: pressLetter("b")
        }

        KeyboardLetter {
            x: 286
            letter: "n"
            onClicked: pressLetter("n")
        }

        KeyboardLetter {
            x: 330
            letter: "m"
            onClicked: pressLetter("m")
        }
    }

    // Upper Case Letters Keyboard - QWERTYUIOP
    Item {
        visible: activeKeyboard == "upperCase"
        y: 55
        KeyboardLetter {
            x: 22
            letter: "Q"
            onClicked: pressLetter("Q")
        }

        KeyboardLetter {
            x: 66
            letter: "W"
            onClicked: pressLetter("W")
        }

        KeyboardLetter {
            x: 110
            letter: "E"
            onClicked: pressLetter("E")
        }

        KeyboardLetter {
            x: 154
            letter: "R"
            onClicked: pressLetter("R")
        }

        KeyboardLetter {
            x: 198
            letter: "T"
            onClicked: pressLetter("T")
        }

        KeyboardLetter {
            x: 242
            letter: "Y"
            onClicked: pressLetter("Y")
        }

        KeyboardLetter {
            x: 286
            letter: "U"
            onClicked: pressLetter("U")
        }

        KeyboardLetter {
            x: 330
            letter: "I"
            onClicked: pressLetter("I")
        }

        KeyboardLetter {
            x: 374
            letter: "O"
            onClicked: pressLetter("O")
        }

        KeyboardLetter {
            x: 418
            letter: "P"
            onClicked: pressLetter("P")
        }
    }

    // Upper Case Letters Keyboard - ASDFGHJKL
    Item {
        visible: activeKeyboard == "upperCase"
        y: 108

        KeyboardLetter {
            x: 46
            letter: "A"
            onClicked: pressLetter("A")
        }

        KeyboardLetter {
            x: 90
            letter: "S"
            onClicked: pressLetter("S")
        }

        KeyboardLetter {
            x: 134
            letter: "D"
            onClicked: pressLetter("D")
        }

        KeyboardLetter {
            x: 178
            letter: "F"
            onClicked: pressLetter("F")
        }

        KeyboardLetter {
            x: 222
            letter: "G"
            onClicked: pressLetter("G")
        }

        KeyboardLetter {
            x: 266
            letter: "H"
            onClicked: pressLetter("H")
        }

        KeyboardLetter {
            x: 310
            letter: "J"
            onClicked: pressLetter("J")
        }
        KeyboardLetter {
            x: 354
            letter: "K"
            onClicked: pressLetter("K")
        }
        KeyboardLetter {
            x: 398
            letter: "L"
            onClicked: pressLetter("L")
        }
    }

    // Upper Case Letters Keyboard - ZXCVBNM
    Item {
        visible: activeKeyboard == "upperCase"
        y: 161

        // Shift Key
        KeyboardLetter {
            x: 22
            letter: ""
            Image {
                width: 18
                height: 16
                anchors.centerIn: parent
                source: "../../images/icons/keyboard/Shift.png"
            }
            backgroundColor: "#dcdcde"
            onClicked: activeKeyboard = "lowerCase"
        }

        KeyboardLetter {
            x: 66
            letter: "Z"
            onClicked: pressLetter("Z")
        }

        KeyboardLetter {
            x: 110
            letter: "X"
            onClicked: pressLetter("X")
        }

        KeyboardLetter {
            x: 154
            letter: "C"
            onClicked: pressLetter("C")
        }

        KeyboardLetter {
            x: 198
            letter: "V"
            onClicked: pressLetter("V")
        }

        KeyboardLetter {
            x: 242
            letter: "B"
            onClicked: pressLetter("B")
        }

        KeyboardLetter {
            x: 286
            letter: "N"
            onClicked: pressLetter("N")
        }

        KeyboardLetter {
            x: 330
            letter: "M"
            onClicked: pressLetter("M")
        }
    }

    // Number Keyboard - 1234567890
    Item {
        visible: activeKeyboard == "number"
        y: 55
        KeyboardLetter {
            x: 22
            letter: "1"
            onClicked: pressLetter("1")
        }

        KeyboardLetter {
            x: 66
            letter: "2"
            onClicked: pressLetter("2")
        }

        KeyboardLetter {
            x: 110
            letter: "3"
            onClicked: pressLetter("3")
        }

        KeyboardLetter {
            x: 154
            letter: "4"
            onClicked: pressLetter("4")
        }

        KeyboardLetter {
            x: 198
            letter: "5"
            onClicked: pressLetter("5")
        }

        KeyboardLetter {
            x: 242
            letter: "6"
            onClicked: pressLetter("6")
        }

        KeyboardLetter {
            x: 286
            letter: "7"
            onClicked: pressLetter("7")
        }

        KeyboardLetter {
            x: 330
            letter: "8"
            onClicked: pressLetter("8")
        }

        KeyboardLetter {
            x: 374
            letter: "9"
            onClicked: pressLetter("9")
        }

        KeyboardLetter {
            x: 418
            letter: "0"
            onClicked: pressLetter("0")
        }
    }

    // Number Keyboard - part 2
    Item {
        visible: activeKeyboard == "number"
        y: 108
        KeyboardLetter {
            x: 22
            letter: "-"
            onClicked: pressLetter("-")
        }

        KeyboardLetter {
            x: 66
            letter: "/"
            onClicked: pressLetter("/")
        }

        KeyboardLetter {
            x: 110
            letter: ":"
            onClicked: pressLetter(":")
        }

        KeyboardLetter {
            x: 154
            letter: ";"
            onClicked: pressLetter(";")
        }

        KeyboardLetter {
            x: 198
            letter: "("
            onClicked: pressLetter("(")
        }

        KeyboardLetter {
            x: 242
            letter: ")"
            onClicked: pressLetter(")")
        }

        KeyboardLetter {
            x: 286
            letter: "€"
            onClicked: pressLetter("€")
        }

        KeyboardLetter {
            x: 330
            letter: "&"
            onClicked: pressLetter("&")
        }

        KeyboardLetter {
            x: 374
            letter: "@"
            onClicked: pressLetter("@")
        }

        KeyboardLetter {
            x: 418
            letter: "\""
            onClicked: pressLetter("\"")
        }
    }

    // Number Keyboard - part 3
    Item {
        visible: activeKeyboard == "number"
        y: 161
        KeyboardLetter {
            width: 50
            x: 89
            letter: "."
            onClicked: pressLetter(".")
        }

        KeyboardLetter {
            width: 50
            x: 146
            letter: ","
            onClicked: pressLetter(",")
        }

        KeyboardLetter {
            width: 50
            x: 203
            letter: "?"
            onClicked: pressLetter("?")
        }

        KeyboardLetter {
            width: 50
            x: 260
            letter: "!"
            onClicked: pressLetter("!")
        }

        KeyboardLetter {
            width: 50
            x: 317
            letter: "'"
            onClicked: pressLetter("'")
        }
    }

    // Sign Keyboard - part 1
    Item {
        visible: activeKeyboard == "sign"
        y: 55
        KeyboardLetter {
            x: 22
            letter: "["
            onClicked: pressLetter("[")
        }

        KeyboardLetter {
            x: 66
            letter: "]"
            onClicked: pressLetter("]")
        }

        KeyboardLetter {
            x: 110
            letter: "{"
            onClicked: pressLetter("{")
        }

        KeyboardLetter {
            x: 154
            letter: "}"
            onClicked: pressLetter("}")
        }

        KeyboardLetter {
            x: 198
            letter: "#"
            onClicked: pressLetter("#")
        }

        KeyboardLetter {
            x: 242
            letter: "%"
            onClicked: pressLetter("%")
        }

        KeyboardLetter {
            x: 286
            letter: ""
            Image {
                width: 18
                height: 16
                anchors.centerIn: parent
                source: "../../images/icons/keyboard/Shift.png"
            }
            onClicked: pressLetter("^")
        }

        KeyboardLetter {
            x: 330
            letter: "*"
            onClicked: pressLetter("*")
        }

        KeyboardLetter {
            x: 374
            letter: "+"
            onClicked: pressLetter("+")
        }

        KeyboardLetter {
            x: 418
            letter: "="
            onClicked: pressLetter("=")
        }
    }

    // Sign Keyboard - part 2
    Item {
        visible: activeKeyboard == "sign"
        y: 108
        KeyboardLetter {
            x: 22
            letter: "_"
            onClicked: pressLetter("_")
        }

        KeyboardLetter {
            x: 66
            letter: "\\"
            onClicked: pressLetter("\\")
        }

        KeyboardLetter {
            x: 110
            letter: "|"
            onClicked: pressLetter("|")
        }

        KeyboardLetter {
            x: 154
            letter: "~"
            onClicked: pressLetter("~")
        }

        KeyboardLetter {
            x: 198
            letter: "<"
            onClicked: pressLetter("<")
        }

        KeyboardLetter {
            x: 242
            letter: ">"
            onClicked: pressLetter(">")
        }

        KeyboardLetter {
            x: 286
            letter: "$"
            onClicked: pressLetter("$")
        }

        KeyboardLetter {
            x: 330
            letter: "£"
            onClicked: pressLetter("£")
        }

        KeyboardLetter {
            x: 374
            letter: "¥"
            onClicked: pressLetter("¥")
        }

        KeyboardLetter {
            x: 418
            letter: "·"
            onClicked: pressLetter("·")
        }
    }

    // Sign Keyboard - part 3
    Item {
        visible: activeKeyboard == "sign"
        y: 161
        KeyboardLetter {
            width: 50
            x: 89
            letter: "."
            onClicked: pressLetter(".")
        }

        KeyboardLetter {
            width: 50
            x: 146
            letter: ","
            onClicked: pressLetter(",")
        }

        KeyboardLetter {
            width: 50
            x: 203
            letter: "¿"
            onClicked: pressLetter("¿")
        }

        KeyboardLetter {
            width: 50
            x: 260
            letter: "!"
            onClicked: pressLetter("!")
        }

        KeyboardLetter {
            width: 50
            x: 317
            letter: "'"
            onClicked: pressLetter("'")
        }
    }

    // Sign Key
    KeyboardLetter {
        visible: activeKeyboard == "number"
        width: 60
        x: 22
        y: 161
        letter: "#+="
        backgroundColor: "#dcdcde"
        onClicked: activeKeyboard = "sign"
    }

    // Number Key - inside sign keyboard
    KeyboardLetter {
        visible: activeKeyboard == "sign"
        width: 60
        x: 22
        y: 161
        letter: "123"
        backgroundColor: "#dcdcde"
        onClicked: activeKeyboard = "number"
    }

    // Number Key - on letter keyboard
    KeyboardLetter {
        visible: activeKeyboard == "lowerCase" || activeKeyboard == "upperCase"
        width: 59
        x: 22
        y: 214
        letter: "123"
        backgroundColor: "#dcdcde"
        onClicked: activeKeyboard = "number"
    }

    // lower case key
    KeyboardLetter {
        visible: activeKeyboard == "number" || activeKeyboard == "sign"
        width: 59
        x: 22
        y: 214
        letter: "abc"
        backgroundColor: "#dcdcde"
        onClicked: activeKeyboard = "lowerCase"
    }

    // Space Key
    KeyboardLetter {
        width: 241
        x: 85
        y: 214
        letter: "space"
        onClicked: pressLetter(" ")
    }

    // Delete Key
    KeyboardLetter {
        width: 84
        height: 48
        x: 374
        y: 161
        letter: ""
        Image {
            width: 44
            height: 32
            anchors.centerIn: parent
            source: "../../images/icons/keyboard/BackIcon.png"
        }

        backgroundColor: "#dcdcde"
        onClicked: remove.call()
    }

    // Submit Key
    KeyboardLetter {
        width: 128
        height: 48
        x: 330
        y: 214
        letter: "submit"
        letterColor: "white"
        backgroundColor: "#46b1e6"
        onClicked: submitPassword(currentPassword)
    }
}
