import QtQuick 2.0

Item {

    width:480
    height:233

    property var activeKeyboard:"letters"

    property var shift:false

    signal letterReceived(var letter)
    signal remove
    signal connectToWifi(var password)


    // letters
    // first row
    Rectangle{

        visible:activeKeyboard=="letters"
        width:parent.width
        height:parent.height
        color:"lightgreen"
        Image{
            anchors.centerIn: parent
            source:"Images/keyboard_abc.jpg"
        }

        Rectangle{

            width:40
            height:48
            x:24
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("Q"):letterReceived("q")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 1
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("W"):letterReceived("w")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 2
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("E"):letterReceived("e")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 3
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("R"):letterReceived("r")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 4
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("T"):letterReceived("t")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 5
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("Y"):letterReceived("y")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 6
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("U"):letterReceived("u")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 7
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("I"):letterReceived("i")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 8
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("O"):letterReceived("o")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 9
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("P"):letterReceived("p")
            }

        }

        // 2nd row 20+53

        Rectangle{

            width:40
            height:48
            x:24+20
            y:17+53
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("A"):letterReceived("a")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24+20 + 44 * 1
            y:17+53
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("S"):letterReceived("s")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24+20 + 44 * 2
            y:17+53
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("D"):letterReceived("d")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24+20 + 44 * 3
            y:17+53
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("F"):letterReceived("f")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24+20 + 44 * 4
            y:17+53
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("G"):letterReceived("g")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24+20 + 44 * 5
            y:17+53
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("H"):letterReceived("h")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24+20 + 44 * 6
            y:17+53
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("J"):letterReceived("j")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24+20 + 44 * 7
            y:17+53
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("K"):letterReceived("k")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24+20 + 44 * 8
            y:17+53
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("L"):letterReceived("l")
            }

        }

        // 3rd row

        Image{
            x:24
            y:17+105
            width:40
            height:48
            source:"Images/keyboard_shift_active.png"
            visible:shift
        }
        Rectangle{

            width:40
            height:48
            x:24
            y: 17+105
            opacity:0

            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift=!shift
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 1
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("Z"):letterReceived("z")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 2
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("X"):letterReceived("x")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 3
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("C"):letterReceived("c")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 4
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("V"):letterReceived("v")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 5
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("B"):letterReceived("b")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 6
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("N"):letterReceived("n")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 7
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    shift?letterReceived("M"):letterReceived("m")
            }

        }

        Rectangle{

            width:90 ////// EXTRA
            height:48
            x:24 + 44 * 8

            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    remove.call()
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 9
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    remove.call()
            }

        }

        //Bottom
        Rectangle{

            width:40
            height:48
            x:24
            y:17 + 158
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    activeKeyboard="numbers"
            }

        }

        Rectangle{

            width: 260
            height:48
            x:24 + 44
            y:17 + 158
            opacity:0

            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived(" ")
            }


        }


        Rectangle{

            width: 130
            height:48
            x:24 + 44 * 7
            y:17 + 158
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    connectToWifi(pass.password)
            }

        }



    }



    // non keyboard




    //numbers
    Rectangle{

        visible:activeKeyboard=="numbers"
        width:parent.width
        height:parent.height
        color:"lightgreen"
        Image{
            anchors.centerIn: parent
            source:"Images/keyboard_0-9.jpg"
        }

        //first row
        Rectangle{

            width:40
            height:48
            x:24
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("1")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 1
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("2")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 2
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("3")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 3
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("4")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 4
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("5")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 5
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("6")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 6
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("7")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 7
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("8")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 8
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("9")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 9
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("0")
            }

        }

        // 2nd row 20+53

            Rectangle{

                width:40
                height:48
                x:24
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived("-")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 1
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived("/")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 2
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived(":")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 3
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived(";")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 4
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived("(")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 5
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived(")")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 6
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived("$")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 7
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived("&")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 8
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived("@")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 9
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived("\"")
                }

            }

        // 3rd row

        Rectangle{

            width:40
            height:48
            x:24
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    activeKeyboard="symbols"
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 2
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived(".")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 3
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived(",")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 4
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("?")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 5
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("!")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 6
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("'")
            }

        }


        Rectangle{

            width:90 ////// EXTRA
            height:48
            x:24 + 44 * 8

            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    remove.call()
            }

        }



        //Bottom
        Rectangle{

            width:40
            height:48
            x:24
            y:17 + 158
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                {shift=false; activeKeyboard="letters"}
            }

        }

        Rectangle{

            width: 260
            height:48
            x:24 + 44
            y:17 + 158
            opacity:0

            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived(" ")
            }


        }


        Rectangle{

            width: 130
            height:48
            x:24 + 44 * 7
            y:17 + 158
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    connectToWifi(pass.password)
            }

        }

        }


        //singns

    Rectangle{

        visible:activeKeyboard=="symbols"

        width:parent.width
        height:parent.height
        color:"lightgreen"
        Image{
            anchors.centerIn: parent
            source:"Images/keyboard_signs.jpg"
        }

        //first row
        Rectangle{

            width:40
            height:48
            x:24
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("[")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 1
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("]")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 2
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("{")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 3
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("}")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 4
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("#")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 5
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("%")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 6
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("^")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 7
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("*")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 8
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("+")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 9
            y:17
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("=")
            }

        }

        // 2nd row 20+53

            Rectangle{

                width:40
                height:48
                x:24
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived("_")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 1
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived("\\")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 2
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived("|")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 3
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived("~")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 4
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived("<")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 5
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived(">")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 6
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived("€")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 7
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived("£")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 8
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived("¥")
                }

            }

            Rectangle{

                width:40
                height:48
                x:24 + 44 * 9
                y:17+53
                opacity:0
                MouseArea{
                    anchors.fill: parent
                    onClicked:
                        letterReceived("·")
                }

            }

        // 3rd row

        Rectangle{

            width:40
            height:48
            x:24
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    activeKeyboard="numbers"
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 2
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived(".")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 3
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived(",")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 4
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("?")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 5
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("!")
            }

        }

        Rectangle{

            width:40
            height:48
            x:24 + 44 * 6
            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived("'")
            }

        }


        Rectangle{

            width:90 ////// EXTRA
            height:48
            x:24 + 44 * 8

            y: 17+105
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    remove.call()
            }

        }

        //bottom

        //Bottom
        Rectangle{

            width:40
            height:48
            x:24
            y:17 + 158
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    {shift=false; activeKeyboard="letters"}
            }

        }

        Rectangle{

            width: 260
            height:48
            x:24 + 44
            y:17 + 158
            opacity:0

            MouseArea{
                anchors.fill: parent
                onClicked:
                    letterReceived(" ")
            }


        }


        Rectangle{

            width: 130
            height:48
            x:24 + 44 * 7
            y:17 + 158
            opacity:0
            MouseArea{
                anchors.fill: parent
                onClicked:
                    connectToWifi(pass.password)
            }

        }

        }





}

