//    ______ ____  _____  __  __ _____ _____  ______
//   |  ____/ __ \|  __ \|  \/  |_   _|  __ \|  ____|
//   | |__ | |  | | |__) | \  / | | | | |  | | |__
//   |  __|| |  | |  _  /| |\/| | | | | |  | |  __|
//   | |   | |__| | | \ \| |  | |_| |_| |__| | |____
//   |_|    \____/|_|  \_|_|  |_|_____|_____/|______|
//
//
//    _   _       _______ _______      ________   _    _ _____
//   | \ | |   /\|__   __|_   _\ \    / |  ____| | |  | |_   _|
//   |  \| |  /  \  | |    | |  \ \  / /| |__    | |  | | | |
//   | . ` | / /\ \ | |    | |   \ \/ / |  __|   | |  | | | |
//   | |\  |/ ____ \| |   _| |_   \  /  | |____  | |__| |_| |_
//   |_| \_/_/    \_|_|  |_____|   \/   |______|  \____/|_____|
//
//

import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import Qt.WebSockets 1.0

import "formide/formideAuth.js" as FormideAuth
import "formide/formideDatabase.js" as FormideDatabase
import "formide/formidePrinter.js" as FormidePrinter
import "formide/formideSlicer.js" as FormideSlicer
import "formide/formideUpdate.js" as FormideAUpdate
import "formide/formideUsb.js" as FormideUSB
import "formide/formideWifi.js" as FormideWifi

import "formide/formide.js" as Formide

Window {
    visible: true
    width: 480
    height: 272

/************************************
        MAIN VARIABLES
 ************************************/

    // Events - Signals we can emit (different printers have different behavior)
    signal printerFinished
    signal printerStarted
    signal printerStopped
    signal printerPaused
    signal printerResumed

    signal slicerFinished
    signal slicerFailed

    signal printerConnected
    signal printerOnline
    signal printerDisconnected

    // Printer status: All information about the printer and current print
    property var printerStatus:Formide.printerStatus


/************************************
     MAIN LOGIC
************************************/

    // Run at boot
    Component.onCompleted: {

        login();
    }

    // Printer status update
    onPrinterStatusChanged:{

        if(statusBlocked==false){

            leftRatioValue=printerStatus.ratio;
            rightRatioValue=100-printerStatus.ratio;

            speedValue=printerStatus.speedMultiplier;
            amountValue=printerStatus.flowRate;
        }
    }

    function login(){
        Formide.login('admin@local', 'admin',function(callback){
            if(callback==true)
            {
                if(Formide.getAccessToken().length > 29)
                {
                    getIsConnectedToWifi()
                    loginTimer.repeat = false
                    loginTimer.stop()

                    Formide.loggedIn=true
                    sock.active = true

                }
            }
        });
    }

    function popPagestack()
    {
        pagestack.pop()
    }

    function pushPagestack(page)
    {
        pagestack.push(Qt.resolvedUrl(page))
    }


/************************************
     WEBSOCKET EVENTS
************************************/

    WebSocket {
        active: false

        function socketLogin () {
            sock.sendTextMessage(JSON.stringify({
                channel: "authenticate",
                data: {
                    type: "user",
                    accessToken: /*savedAccessToken*/Formide.getAccessToken()
                }
            }));
        }
        id: sock

//      Use localhost (for production)
        url: "ws://127.0.0.1:3001"

//      Use this IP for remote access (for development)
//        url: "ws://10.0.1.69:3001"

        onTextMessageReceived: {
            try {
                var data = JSON.parse(message);
                //console.log("received event: " + JSON.stringify(data.channel));


                // For each socket event, we emit a signal, so we can add the implementation
                // outside the library

                if(data.channel === "slicer.finished")
                {
                    slicerFinished(data.data)
                }
                if(data.channel === "slicer.failed")
                {
                    slicerFailed(data.data)
                }

                if(data.channel === "printer.stopped")
                {
                    printerStopped(data.data)
                }

                if(data.channel === "printer.started")
                {
                    printerStarted(data.data)
                }

                if(data.channel === "printer.connected")
                {
                    printerConnected(data.data)
                }
                if(data.channel === "printer.disconnected")
                {
                    printerDisconnected(data.data)
                }

                if(data.channel === "printer.status")
                {

                    //TODO: Rewrite and implement this somewhere else
                    // Convert in event

                    //console.log(JSON.stringify(data.data))

                    if(data.data.status != "connecting")
                    {
                        Formide.printerStatus=data.data

                        //TODO: Move out of here
                        if(!initialized && loggedIn)
                        {
                            initialized=true
                            getEverything()
                            splash.visible=false

                            getCurrentClientVersion()
                        }

                    }

                    if(data.data.status=="printing")
                    {
                        //console.log("currentprintjob: "+currentPrintJob)
                        if(currentPrintJob!==data.data.queueItemId)
                        {
                            currentPrintJob = data.data.queueItemId;
                            getQueue()
                        }
                    }


                }

            }
            catch (e) {
               //console.log(e);
            }
        }
        onStatusChanged: {
           console.log("onStatusChanged")
            if (sock.status == WebSocket.Error) {
               console.log(qsTr("Client error: %1").arg(sock.errorString));
            } else if (sock.status == WebSocket.Closed) {
               console.log(qsTr("Client socket closed."));
            } else if (sock.status == WebSocket.Open) {
                socketLogin();
            }
            else {
               console.log("websocket status: "+ sock.status);
            }
        }
    }


/************************************
     TIMERS
************************************/

    // /!\ Printer specific timers need to be implemented out of here, in main.qml

    // Timer for printer status override
    Timer{
        id:statusBlockedTimer
        running:false
        repeat:false
        interval:Formide.timeoutRatio*5
        onTriggered: {
            statusBlocked=false
        }
    }


    // Timer to check Wi-Fi status
    Timer {
        id: wifiTimer
        interval: 15000
        repeat: true
        running: true
        onTriggered:
        {
            if(printerStatus)
                if(printerStatus.status==="online")
                    getIsConnectedToWifi()

        }
    }

    // Initial loop to login in. It stops after connecting with Formide.
    Timer {
        id: loginTimer
        interval: 20000
        repeat: true
        running: true

        onTriggered:
        {
           console.log("Connecting")
            if(Formide.getAccessToken().length < 30)
                login()
            else
            {
                loginTimer.repeat = false
                loginTimer.running = false
                loginTimer.stop()
            }
        }
    }


/************************************
      MAIN PAGE STACK
*************************************/

    // This is the main page stack (StackView) of the application.
    // You can push pages and pop them by simply calling the functions push and pop


    Rectangle{

        width:parent.width
        height:parent.height
        rotation:0

        StackView
        {
            id:pagestack
            anchors.fill: parent
            focus: true

            initialItem: Qt.resolvedUrl("TemplateUsb.qml")


            delegate: StackViewDelegate {
                    function transitionFinished(properties)
                    {
                        properties.exitItem.opacity = 1
                    }

                    pushTransition: StackViewTransition {
                        PropertyAnimation {
                            target: enterItem
                            property: "opacity"
                            from: 0
                            to: 1
                            duration: 0
                        }
                        PropertyAnimation {
                            target: exitItem
                            property: "opacity"
                            from: 1
                            to: 0
                            duration: 0
                        }
                    }

                } // delegate

        }//Stackview

    }// Rectangle

}
