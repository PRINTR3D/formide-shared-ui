import QtQuick 2.0


MouseArea {

    id: pushButton

    width:216
    height:48

    property var buttonText:""

    property var backgroundColor:"#dcdcde"
    property var textColor:"4a4a4a"
    property var textSize:16

    Rectangle{
        width:pushButton.width
        height:pushButton.height
        radius:3
        color:pushButton.pressed?"#46b1e6":backgroundColor
    }

    DefaultText{

        font.pixelSize: textSize
        color:pushButton.pressed?"#ffffff":textColor
        anchors.centerIn: parent
        text:buttonText
    }

}
