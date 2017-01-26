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


    // UI
    //property var backendIP : "127.0.0.1" // For production, we use Localhost
    property var backendIP: "10.1.0.16" // Sometimes, for development, we use the IP of an Element
    property var sharedUiVersion

    // Printer status
    property var printerStatus    // Information about printer status
    property var flowRateValue:100
    property var speedMultiplierValue:100

    // Printer status blocked for override
    property var statusBlocked:false

    // Formide Data
    property var materials:[]
    property var printers:[]
    property var sliceProfiles:[]
    property var fileItems:[]
    property var queueItems:[]
    property var printJobs:[]

    // UI Status - general
    property var initialized:false       // UI is initialised
    property var accessToken:''
    property var loggedIn:false          // UI is authenticated

    // UI password for touch screen
    property var isLocked:false
    property var passcode

    // Print Job Status
    property var uniquePrinter           // Printer used for slicing
    property var currentPrintJobId       // Current print job for display
    property var currentPrintJob         // Current print job for display
    property var currentQueueItemId      // Current queue item for display

    // Slice Data
    property var slicing: false
    property var fileNameSelected
    property var modelFileSelected
    property var materialSelected
    property var qualitySelected
    property var printerSelected

    // Error Data - Error messages that will be displayed
    property var usbError:""
    property var slicerError:""
    property var queueError:""

    // USB Data
    property var usbAvailable:false
    property var driveFiles:[]           // Array of files and dirs found
    property var driveListing            // Toggle to see if content is file list or drive list
    property var drivePath               // Current folder path
    property var driveUnit               // Name of drive unit

    // Update Data
    property var updateInformation       // Update information from callback
    property var updateAvailable:false   // Boolean

    // Wi-Fi Data
    property var APMode:false
    property var ssidToConnect           // Name of network to connect to
    property var wifiList:[]             // Array of SSIDs
    property var isConnectedToWifi:false // Boolean
    property var singleNetwork           // Network currently connected to
    property var registrationToken:""    // Cloud registration token

    // Formide-client Data
    property var currentClientVersion:""
    property var ipAddress
    property var macAddress

    /* MOVE TO BUILDER UI */
    /***********************/
    // (Keeping it here for now)
    // Extruder ratio variables
    property var leftRatioValue:100
    property var rightRatioValue:0
    property var timeoutRatio:1000

    // Colors
    property var backgroundColor:"#ECECEC"
    property var statusBackgroundColor:"#D2D2D2"
    property var leftStatusBackgroundColor:"#E1E1E1"
    property var temperatureColor:"#6F6E6E"
    property var targetColor:"#8A8A8A"
    property var separatorColor:"#6F6E6E"

    /* MOVE TO FELIX UI */
    /*********************/
    // (Keeping it here for now)

    // Extruder selected for load/unload function
    property var extruderSelected:1




/************************************
     MAIN LOGIC - General
************************************/

    // Run at boot
    Component.onCompleted: {

        login();
    }

    // Printer status update
    onPrinterStatusChanged:{


        console.log("PrinterStatus")

    }

    function login(){
        Formide.auth().login('admin@local', 'admin',function(callback){
            if(callback==true)
            {
                if(Formide.auth().getAccessToken().length > 29)
                {
                    loginTimer.repeat = false
                    loginTimer.stop()

                    Formide.loggedIn=true
                    sock.active = true

                    //startTimers()
                }
            }
        });
    }


/************************************
     MAIN LOGIC - Wi-Fi
************************************/

    function getRegistrationToken()
    {
        Formide.wifi().getRegistrationCode(function(err,response){
            if(err)
            {
                console.log("Error registraton token",JSON.stringify(err));
            }
            if(response)
            {
                console.log("Response registration token",JSON.stringify(response));
                registrationToken=response.code.toString();
            }
        });
    }

    function checkConnection() {
        Formide.wifi().checkConnection(function (err, response) {

            if(err)
            {
                console.log("Error checking connection",JSON.stringify(err));
            }
            if(response)
            {
                if(response.connected)
                {
                    isConnectedToWifi=response.connected
                    ipAddress=response.internalIp;
                }
                console.log("Response checking connection",JSON.stringify(response));
            }


        });
    }


    function getSingleNetwork(){

        Formide.wifi().getSingleNetwork(function (err, network) {
            try {
                var net = network.ssid;
                singleNetwork=net;
            }
            catch (e) {
                console.log("Exception checking network",e)
            }
        });
    }

    function getWifiList(){

        Formide.wifi().getList(function (err, list) {
            try {
                var wifiArray = [];
                for (var key in list) {
                    wifiArray.push(list[key]['ssid']);
                }


                console.log("Found "+wifiArray.length+" networks")
                wifiList=wifiArray;
                if(callback)
                    callback(null, wifiArray);
            }
            catch (e) {
                console.log("Exception getting network list",e)
                if(callback)
                    callback(e);
            }
        });
    }


    function resetWifi()
    {
        Formide.wifi().reset(function (err, response) {

            if(err)
            {
                console.log("Error reset Wi-Fi",JSON.stringify(err));
            }
            if (response)
            {
               //console.log('Response reset Wi-Fi', JSON.stringify(response))
                singleNetwork=""
                wifiList=[]
            }
        });

    }

    // Check: Maybe we don't need to call it here
    function connectToWifi(ssid,password)
    {

        Formide.wifi().connect(ssid,password,function (err, response) {

            if(err)
            {
                console.log("Error connecting to Wi-Fi",JSON.stringify(err));
            }
            if (response)
            {
                checkConnection()
                console.log("Response connecting to network",JSON.stringify(response))
            }
        });
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
                    accessToken: /*savedAccessToken*/Formide.auth().getAccessToken()
                }
            }));
        }
        id: sock
        url:"ws://"+Formide.backendIP+":3001"

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
                    console.log(JSON.stringify(data.data))

                    // Only use printer status after printer is Online
                    if(data.data.status !== "connecting")
                    {
                        Formide.printerStatus=data.data

                        // If the app is not initialized, we initialize it and get the current client version
                        if(!initialized && loggedIn)
                        {
                            initialized=true

                            Formide.update().getCurrentClientVersion()
                        }

                    }

                    // If printer is printing, print job id needs to be updated
                    if(data.data.status==="printing")
                    {
                        if(Formide.currentPrintJobId!==data.data.queueItemId)
                        {
                            Formide.currentPrintJobId = data.data.queueItemId;
                            Formide.printer(printerStatus.port).getQueue();
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

            console.log("Checking Wi-Fi")
            if(printerStatus)
                if(printerStatus.status==="online" || printerStatus.status==="printing" || printerStatus.status==="heating")
                {
                    console.log("Wi-Fi Checking")
                    Formide.wifi().getList()
                    Formide.wifi().checkConnection()
                }

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
            if(Formide.auth().getAccessToken().length < 30)
                login()
            else
            {
                loginTimer.repeat = false
                loginTimer.running = false
                loginTimer.stop()


            }
        }
    }

}
