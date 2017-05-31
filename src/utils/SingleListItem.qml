/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0

Rectangle {

    width: parent.width
    height: 65
    color: "#141414"

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
        y: 8
        width: 48
        height: 48
        radius: 3
        visible:(wifi || wifiActive)?false:true

        Image{

//            anchors.fill: parent
            source: fileImagePath

            width:38
            height:38
            anchors.centerIn: parent

//            property bool adapt: true

//            layer.enabled: rounded
//            layer.effect: ShaderEffect {
//                    property real adjustX: image.adapt ? Math.max(width / height, 1) : 1
//                    property real adjustY: image.adapt ? Math.max(1 / (width / height), 1) : 1

//                    fragmentShader: "
//                    #ifdef GL_ES
//                        precision lowp float;
//                    #endif // GL_ES
//                    varying highp vec2 qt_TexCoord0;
//                    uniform highp float qt_Opacity;
//                    uniform lowp sampler2D source;
//                    uniform lowp float adjustX;
//                    uniform lowp float adjustY;

//                    void main(void) {
//                        lowp float x, y;
//                        x = (qt_TexCoord0.x - 0.5) * adjustX;
//                        y = (qt_TexCoord0.y - 0.5) * adjustY;
//                        float delta = adjustX != 1.0 ? fwidth(y) /*/ 2.0*/ : fwidth(x) /*/ 2.0*/;
//                        gl_FragColor = texture2D(source, qt_TexCoord0).rgba
//                            * step(x * x + y * y, 0.25)
//                            * smoothstep((x * x + y * y) , 0.25 + delta, 0.25)
//                            * qt_Opacity;
//                    }"
//                }

        }
    }

    Image{
        width:48
        height:34.9
        y:12
        x:24
        visible:(wifi || wifiActive)
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

//    // Times
//    Item{
//        width:45
//        height:48
//        x:412
//        y:8

//        Image{
//            id:timesImage
//            anchors.fill: parent
//            source:timesImagePath
//        }
//    }

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
