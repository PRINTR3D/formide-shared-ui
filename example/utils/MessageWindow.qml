import QtQuick 2.0

Item {
    id:root

    width:480
    height:272

    property var firstText:""                   // Text shown as title
    property var secondText:""                  // Text shown in subtitle

    property var confirmButtonText:""           // Text shown in confirm button

    property bool confirmButton:true            // Showing confirm button
    property bool exitButton:false

    signal confirmButtonSignal                  // Event emitted when pressing confirm
    signal quitButtonSignal                     // Event emitted when pressing the [X] button

    property var loading:false

    // Blurry Background
    Image{
        anchors.fill: parent
        source:"../Images/blurBackground.png"
    }

    MouseArea{
        anchors.fill: parent
    }

    // Home icon
    Item{
        width:80
        height:52
        visible:exitButton


        Image{
            width:30
            height:30
            x:25
            y:11
            source:"../Images/icons/noIcon.png"

        }

        MouseArea{
            anchors.fill: parent
            onClicked: quitButtonSignal.call()
        }
    }



    DefaultText{

        width:368
        height:32
        x:56
        y:64

        font.family: "OpenSans"
        font.pixelSize:24
        lineHeightMode:Text.FixedHeight
        lineHeight:1.5
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
        wrapMode: "WordWrap"

        text: secondText
    }


    Rectangle{
        visible:confirmButton

        x:100
        y:176

        width: 280
        height: 48
        radius: 3
        color: "#46b1e6"

        DefaultText{
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


}


