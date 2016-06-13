import QtQuick 2.0

Item {

    width:parent.width
    height:parent.height
    id:root


    function connectWifi(password)
    {
        console.log("Connect to wifi")
        parent.connectToWifi(password)
    }
    VirtualKeyboard{

        id:keyboard
        y:parent.height - height
        onLetterReceived:{
            console.log(letter)
            pass.password=pass.password+letter
}
        onRemove: {
            if(pass.password.length == 0)
                root.parent.pop()
            else
                pass.password= pass.password.substring(0, pass.password.length-1)
        }

        onConnectToWifi: connectWifi(password)
    }


    Rectangle
    {

        height:parent.height -keyboard.height
        width:parent.width

        Text{

            id:pass
            anchors.centerIn: parent

            property var password:""
            font.pixelSize: 20

            text:password
        }
    }
}

