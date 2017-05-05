import QtQuick 2.0

Item {
    id:root

    width:480
    height:272

    property var firstText:""                   // Text shown as title
    property var secondText:""                  // Text shown in subtitle

    property var cancelButtonText:""            // Text shown on cancel button
    property var confirmButtonText:""           // Text shown in confirm button

    property bool cancelButton:true             // Showing cancel button
    property bool confirmButton:true            // Showing confirm button

    signal cancelButtonSignal                   // Event emitted when pressing cancel
    signal confirmButtonSignal                  // Event emitted when pressing confirm
    signal quitButtonSignal                     // Event emitted when pressing the [X] button

    // Blurry Background
    Image{
        anchors.fill: parent
        source:"../images/blurBackground.png"
    }

    DefaultText{

        width:368
        height:32
        x:56
        y:64

        font.pixelSize:24
        font.weight: Font.Black
        color: "#ffffff"

        text:firstText
    }

    DefaultText{
        width:368
        height:48
        x:56
        y:112

        font.family: "OpenSans"
        font.pixelSize:16
        color: "#ffffff"

        text: secondText
    }

    Rectangle{
        visible:confirmButton

        x:56
        y:176
        width: 176
        height: 48
        radius: 3
        color: "#46b1e6"

        DefaultText{
           font.family: "OpenSans"
           font.pixelSize: 16
           anchors.centerIn: parent
           color: "#ffffff"

           text:confirmButtonText
        }

        MouseArea{

            anchors.fill: parent
            onClicked:{

                confirmButtonSignal.call()
            }
        }
    }

    Rectangle{
        visible:cancelButton
        x:248
        y:176

        width: 176
        height: 48
        radius: 3
        color:mo.pressed?"#878896": "#ef4661"

        DefaultText{
           font.family: "OpenSans"
           font.pixelSize: 16
           anchors.centerIn: parent
           color: "#ffffff"

           text: cancelButtonText
        }

        MouseArea{

            id:mo
            anchors.fill: parent
            onClicked:{
                cancelButtonSignal.call()
            }
        }
    }
}


