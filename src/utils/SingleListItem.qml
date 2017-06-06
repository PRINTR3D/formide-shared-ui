/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../"

Rectangle {

    width: parent.width
    height: 65

    Background{}

    property int textSize:24

    property string name:"File name"
    property string arrowImagePath
    property string timesImagePath
    property string fileImagePath
    property var wifiActive:false
    property var wifi:false

    signal clickedSignal


    function rotateArrow()
    {
        rotate.start()
    }

    function unrotateArrow()
    {
        unrotate.start()
    }

    Rectangle{
        x: 24
        y: 10
        width: 44
        height: 44
        radius: 3
        visible: !(wifi || wifiActive)

        Image{
            source: fileImagePath

            width:38
            height:38
            anchors.centerIn: parent
        }
    }

    Image{
        width:48
        height:34.9
        y:12
        x:24
        visible: (wifi || wifiActive)
        source:getWifiIcon()

        function getWifiIcon()
        {
            if(wifiActive)
                return Qt.resolvedUrl("../images/icons/overlays/WifiIconA.png")
            else if(wifi)
                return Qt.resolvedUrl("../images/icons/overlays/WifiIcon.png")
            else
                return fileImagePath
        }
    }

    // Label
    DefaultText{
        x: 80
        y: 16
        width: 328
        height: 32
        font.family: "OpenSans-Regular"
        font.pixelSize: textSize
        font.weight: Font.Normal
        color: "#ffffff"
        text: name
        clip:true
    }

    // Arrow
    Item{
        width:32
        height:48
        x:424
        y:8

        Image{
            id:image
            anchors.fill: parent
            source:arrowImagePath
        }

        PropertyAnimation{
            id:rotate
            target: image
            property:"rotation"
            from: 180
            to:360
            duration:150
        }

        PropertyAnimation{
            id:unrotate
            target: image
            property:"rotation"
            from: 180
            to:0
            duration:150
        }
    }

    // Separator
    Rectangle{
        width: parent.width - 32
        height: 1
        x: 16
        y: 64
        color: "#d8d8d8"
    }

    // We will use this in the future
    MouseArea{
        anchors.fill: parent
        onClicked:{
            clickedSignal.call()
        }
    }
}
