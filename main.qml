import "formide.js" as Formide
import QtQuick 2.3
import QtQuick.Window 2.2
import Qt.WebSockets 1.0
import QtQuick.Controls 1.2
//import QtQuick.Layouts 1.1
//import QtQuick.Controls.Styles 1.0

Window {

    id: main
    visible: true

    width: 480
    height: 272

   /*************
    Variables
    ************/

    // Printer status
    property var printerStatus//:{ "extruders": [ { "id": 0, "temp": 198, "targetTemp": 198 },{ "id": 1, "temp": 198, "targetTemp": 0 } ], "bed": { "temp": 60, "targetTemp": 60 },"port": '/dev/tty.usbmodem12341',"status": 'printing',       "timeStarted": '2016-01-29.15:35:28',       "timeNow": '2016-01-29.16:01:03',       "baudrate": 250000,"ratio":60,       "queueItemId": 6,       "progress": 25,       "coordinates": { x: 97, y: 80, z: 3 },       "currentlyPrinting": 'INFILL',       "printSpeed": 40,       "materialAmount": 0 }
    // Needed for pages
    property var materials
    property var printer
    property var sliceProfiles
    property var fileItems
    property var queueItems
    property var printJobs
    property var wifiList
    property var initialized:false
    property var loggedIn:false

    // Specific
    property var uniquePrinter
    property var uniquePrintJob
    property var printJobId
    property var currentPrintJob
    property var fileNameSelected
    property var modelFileSelected
    property var materialSelected
    property var qualitySelected
    property var printerSelected

    property var bedPreheated:false
    property var nozzlePreheated:false

    /*************
     DRIVER
     ************/

    property var amountValue:100
    property var leftRatioValue:100
    property var rightRatioValue:0
    property var speedValue:100
    property var timeoutRatio:2000

    Timer{
        id:statusBlockedTimer
        running:false
        repeat:false
        interval:timeoutRatio*7
        onTriggered: {
            statusBlocked=false
        }
    }

    property var statusBlocked:false
    onPrinterStatusChanged:{

        if(statusBlocked==false){

            leftRatioValue=printerStatus.ratio;
            rightRatioValue=100-printerStatus.ratio

        }
    }


    /*************
     USB FUNCTIONS
     ************/

    property var driveFiles
    property var driveListing
    property var drivePath
    property var driveUnit

    function updateDriveFilesFromPath(){


        Formide.usb().readDrive(driveUnit,drivePath,function(err,list){
            if(err)
                console.log("Error: ",err);
            if(list)
            {
                //console.log("Response: ",list);

                driveListing=0;
                driveFiles=list;

            }
        });




    }
    function updateDrivePath(driveP){
        drivePath=driveP;

    }
    function updateDriveListing(i){
        driveListing=i;
    }
    function updateDriveUnit(driveU){
        driveUnit=driveU;
        Formide.usb().mount(driveUnit,function(err,response){
            if(err)
                console.log("Error: ",err);
            if(response)
                //console.log("Response: ",response);
                if(response.message=="drive mounted")
                {
                    updateDriveFilesFromPath()
                }


        });



    }
    function scanDrives()
    {
        Formide.usb().scanDrives(function(list)
        {

            if(list.length>0 && list[0]!=="platform-musb*part*")
            {
                //console.log("Updating drives list: ",list)
                driveFiles= list;
            }
            else
            {
                //console.log("Not updating drive")
                driveFiles = [];
            }
        });
    }

    function copyFileFromDrive(){


        Formide.usb().copyFile(driveUnit,drivePath,function(err,response){
            if(err)
                console.log("Error: ",err);
            if(response)
            {
                //console.log("Response: ",response);
                getFiles();

            }
        });
    }

    /*************
     WIFI FUNCTIONS
     ************/

    function wifiSettings()
    {

        getWifiList()
        pagestack.push(Qt.resolvedUrl("Wifi.qml"))
    }

    function getWifiList()
    {

        //console.log("Updating wifi list ")


        Formide.wifi().getList(function(err, response) {
            if (err) return; //console.log("ERR:", err);

            //console.log("RESPONSE WIFI:", response);
            updateWifiList(response);
        })
    }

    function resetWifi()
    {

        //console.log ("Trying to connect to wifi")

        pagestack.clear()
        pagestack.push(Qt.resolvedUrl("Home.qml"))
        pagestack.push(Qt.resolvedUrl("Disconnecting.qml"))

        Formide.wifi().reset(function (err,callback){


            if(callback)
            {
              console.log("Reset Wifi: "+callback)


            }
        });
    }


    function connectToWifi(password){


        //console.log ("Trying to connect to wifi")

        pagestack.clear()
        pagestack.push(Qt.resolvedUrl("Home.qml"))
        pagestack.push(Qt.resolvedUrl("Connecting.qml"))

        Formide.wifi().connect(ssid,password, function (err,callback){


            if(callback)
            {
              console.log("Attempt to connect to wifi: "+ callback)

                if(callback=="Device connected to network")
                    pagestack.push(Qt.resolvedUrl("Connected.qml"))

                else
                    pagestack.push(Qt.resolvedUrl("NotConnected.qml"))




            }
        });




    }

    function updateWifiList(response){

        wifiList=response
    }


    property var ssid
    function popPassword(ssidName)
    {
        ssid=ssidName

        pagestack.push(Qt.resolvedUrl("WifiPassword.qml"))
    }



    /*************
     PASSWORD
     ************/

    property var isLocked:false
    property var isConnectedToWifi:false
    property var passcode
    property var ipAddress

    function getIsConnectedToWifi()
    {


        Formide.wifi().isConnected(function(err, response) {
            if (err) return; //console.log("ERR:", err);


            isConnectedToWifi=response.connected;
            ipAddress=response.internalIp;
            //console.log("RESPONSE WIFI:", JSON.stringify(response));
        })
    }

    function setPassCode(code)
    {
        passcode=code

       //console.log("Locked: "+passcode)
        isLocked=true

        pagestack.clear()
        pagestack.push(Qt.resolvedUrl("Home.qml"))

    }

    function checkPassCode(code)
    {
        if (passcode == code)
        {
           //console.log("unlocked from main")
            isLocked=false

            pagestack.clear()
            pagestack.push(Qt.resolvedUrl("Home.qml"))
            return true
        }
        else
        {
           //console.log("Returning false")
            return false
        }


    }

    function toggleNozzle(value)
    {
        nozzlePreheated=value
    }

    function toggleBed(value)
    {
        bedPreheated=value
    }


    /**************
      COLORS
      **************/
    property var backgroundColor:"#ECECEC"
    //property var statusBackgroundColor:"#C3C3C3"
    property var statusBackgroundColor:"#D2D2D2"
    property var leftStatusBackgroundColor:"#E1E1E1"
    property var temperatureColor:"#6F6E6E"
    property var targetColor:"#8A8A8A"
    property var separatorColor:"#6F6E6E"


    /*************
     Login Functions
     ************/
    function login(){
        Formide.login('admin@local', 'admin',function(callback){
                   //console.log("Callback login: " + callback);
                    if(callback==true)
                    {
                        if(Formide.getAccessToken().length > 29)
                        {
                            getIsConnectedToWifi()
                            loginTimer.repeat = false
                            loginTimer.stop()

                            loggedIn=true
                            sock.active = true

                        }
                    }
        });
    }

    /*************
     GET Functions
     ************/
        function getFiles()
        {
            Formide.database().files(function(err,response){
                if(err)
                   console.log("ERR: "+err)
                if(response)
                {
                    //console.log("RESPONSE FILES: " +JSON.stringify(JSON.parse(response)))
                   //console.log("number of files: "+ JSON.parse(response).length)
                    updateFiles(JSON.parse(response))
                }
            })
        }

        function getPrintJobs()
        {
            Formide.database().printJobs(function(err,response){
                if(err)
                   console.log("ERR: "+err)
                if(response)
                {
                   //console.log("RESPONSE PRINTJOBS: " +JSON.stringify(JSON.parse(response)))
                   //console.log("number of printjobs: "+ JSON.parse(response).length)
                    updatePrintJobs(JSON.parse(response))
                }
            })
        }



        function getMaterials()
        {
            Formide.database().materials(function(err,response){
                if(err)
                   console.log("ERR: "+err)
                if(response)
                {
                    //console.log("RESPONSE MATERIALS: " +JSON.stringify(JSON.parse(response)))
                   //console.log("number of materials: "+ JSON.parse(response).length)
                    updateMaterials(JSON.parse(response))
                }
            })
        }

        function getPrinters()
        {
            Formide.database().printers(false,function(err,response){
                if(err)
                   console.log("ERR: "+err)
                if(response)
                {
                    //console.log("RESPONSE PRINTER: " ,response)
                    //console.log("number of printers: ", JSON.parse(response).length)
                    updatePrinter(JSON.parse(response))
                }
            })

        }

        function getSliceProfiles()
        {
            Formide.database().sliceprofiles(function(err,response){
                if(err)
                   console.log("ERR: "+err)
                if(response)
                {
                    //console.log("RESPONSE SLICEPROFILES: " +JSON.stringify(JSON.parse(response)))
                   //console.log("number of slice profiles: "+ JSON.parse(response).length)

                    updateSliceProfiles(JSON.parse(response))
                }
            })
        }

        function getQueue()
        {

           //console.log("Getting queue")
            if(!printerStatus)
                return


            Formide.printer(printerStatus.port).getQueue(function(err,response){
                if(err)
                   console.log("ERR: "+err)
                if(response)
                {
                   //console.log("RESPONSE QUEUE: ",response)
//                   //console.log("number of queue items: "+ JSON.parse(response).length)
                    updateQueue(JSON.parse(response))
                }
            })
        }
    /*************
     Update Functions
     ************/

        function updateMaterials(data) { materials=data }

        function updatePrinter(data) { printer=data; updateUniquePrinter(data) }

        function updateSliceProfiles(data) { sliceProfiles=data }

        function setPrintJobId(data) { printJobId = data }

        function updateFiles(data){
            fileItems=data
        }

        function updatePrintJobs(data){

            printJobs = data.filter(function(printJob) {
                if (printJob.sliceFinished)
                    return printJob;
            });
        }

        function updateCurrentPrintJob(id)
        {
            //console.log("Update current printjob")
            //console.log("ID",id)

            for (var i in printJobs) {
                if (data[i].id === id)
                    currentPrintJob=data[i]
            }
        }

        function updateUniquePrinter(data)
        {
            //console.log("unique printer info",JSON.stringify(data))
            for (var i in data) {
                if (data[i].port == printerStatus.port)
                {
                    uniquePrinter=data[i]
                }
            }
        }

        function updateQueue(data){


            queueItems = data.filter(function(queueItem) {
                if (queueItem.status == "queued")
                    return queueItem;
            });

            //queueItems=data

            for (var i in data) {
                if (data[i].status == "printing")
                    uniquePrintJob=data[i]
            }
        }



    /************
      TUNE FUNCTIONS
      ****************/

        function lessAmount(){

            if(amountValue >0)
            {

                amountValue--


                amountTimer.restart()
            }
        }

        function moreAmount(){

            if(amountValue < 500)
            {

                amountValue++

                amountTimer.restart()
            }
        }

        function moreLeftRatio(){

            if(rightRatioValue >0)
            {

                leftRatioValue++
                rightRatioValue--

                statusBlocked=true
                statusBlockedTimer.restart()
                ratioTimer.restart()

            }
        }

        function moreRightRatio(){

            if(leftRatioValue >0)
            {

                leftRatioValue--
                rightRatioValue++

                statusBlocked=true
                statusBlockedTimer.restart()
                ratioTimer.restart()
            }
        }

        function switchRatio(){
            leftRatioValue= 100-leftRatioValue
            rightRatioValue = 100 - rightRatioValue


            statusBlocked=true
            statusBlockedTimer.restart()
            ratioTimer.restart()

        }


        function lessSpeed(){

            if(speedValue >0)
            {

                speedValue--

                speedTimer.restart()
            }
        }

        function moreSpeed(){

            if(speedValue < 500)
            {

                speedValue++

                speedTimer.restart()


            }
        }

        /*************
          LOAD FUNCTIONS
          ************/

        property var extruderSelected:2


        function replacePosition(){

            Formide.printer(printerStatus.port).gcode("M104 S220\nG91\nG1 Z10\nG90\nG28 X\nG28 Y\nG1 F4000 X100 Y100\nG91 E0\nG91")

        }

        function loadFirst(){

            if(printerStatus.extruders[0].temp >= 210)
            {
                if (extruderSelected==0)
                    Formide.printer(printerStatus.port).gcode("G1 E2 F300\n")
                else
                {
                    extruderSelected=0
                    Formide.printer(printerStatus.port).gcode("T0\nG91\nG1 E2 F300\n")
                }
            }
            else
               console.log("Temperature not high enough")

        }
        function loadSecond(){

            if(printerStatus.extruders[0].temp >= 210)
            {
                if (extruderSelected==1)
                    Formide.printer(printerStatus.port).gcode("G1 E2 F300\n")
                else
                {
                    extruderSelected=1
                    Formide.printer(printerStatus.port).gcode("T1\nG91\nG1 E2 F300\n")
                }
            }
            else
               console.log("Temperature not high enough")
        }
        function unloadFirst(){

            if(printerStatus.extruders[0].temp >= 210)
            {
                if (extruderSelected==0)
                    Formide.printer(printerStatus.port).gcode("G1 E-2 F300\n")
                else
                {
                    extruderSelected=0
                    Formide.printer(printerStatus.port).gcode("T0\nG91\nG1 E-2 F300\n")
                }
            }
            else
               console.log("Temperature not high enough")
        }
        function unloadSecond(){

            if(printerStatus.extruders[0].temp >= 210)
            {
                if (extruderSelected==1)
                    Formide.printer(printerStatus.port).gcode("G1 E-2 F300\n")
                else
                {
                    extruderSelected=1
                    Formide.printer(printerStatus.port).gcode("T0\nG91\nG1 E-2 F300\n")
                }
            }
            else
               console.log("Temperature not high enough")

        }


    /*************
      SLICE FUNCTIONS
      ************/

      function selectSTL(model){

        modelFileSelected=model.id
         fileNameSelected=model.prettyname


          materialSelected=0
          qualitySelected=0

          pagestack.push(Qt.resolvedUrl("Slice.qml"))

      }

      function printGCodeFast()
      {
          addToQueue(printJobId)
          updateCurrentPrintJob(printJobId)
      }

      function printGCode(printjobid){

          addToQueue(printjobid)
          updateCurrentPrintJob(printjobid)
      }

      function printQueueItem(id)
      {
          printFile(id)
      }

      function printCustomGcode(id,gcode)
      {

          Formide.printer(printerStatus.port).addCustomGcodeToPrintJobs(id,function(err,callback){
              if(err)
                    console.log("ERR: "+err)
              if(callback)
              {
                  var response = JSON.parse(callback)
                 console.log("RESPONSE add customgcode to printjobs: " +JSON.stringify(JSON.parse(callback)))

                  addToQueue(response.printJob.id)

                  //printQueueItem(response.printJob.id,response.printJob.gcode)


              }
          })
      }

      function removeQueueItem(id){

          Formide.database().removeQueueItem(id,function(err,callback){
              if(err)
                    console.log("ERR: "+err)
              if(callback)
              {
                 //console.log("RESPONSE REMOVE QUEUE ITEM: " +JSON.stringify(JSON.parse(callback)))
                  getQueue()
              }
          })
      }

      function addToQueue(printjobid)
      {
         //console.log("Adding to queue",printerStatus.port,printjobid)
          Formide.printer(printerStatus.port).addToQueue(printjobid, function (callback){
              if(callback)
              {
                  //console.log("Callback add to queue: ",callback)

                  var callbackJson=JSON.parse(callback)
                  if(callbackJson.queueItem.status==="queued")
                  {


                       var queueId = callbackJson.queueItem.id
                       //var gcode = callbackJson.queueItem.gcode

                      printFile(queueId)
                  }
              }

          });
      }

      function printFile(queueId){
          pagestack.clear()
          pagestack.push(Qt.resolvedUrl("StartingPrint.qml"))

         //console.log("start print ",queueId, gcode)
          Formide.printer(printerStatus.port).start(queueId)

      }

      function sendSliceRequest(uniquePrinter,modelFileSelected,materialSelected,qualitySelected)
      {

          //variables
          var modelfile= modelFileSelected
          var sliceprofile = sliceProfiles[qualitySelected].id
          var material = materials[materialSelected].id
          var printer = uniquePrinter.id

          //activate slicing page
          pagestack.push(Qt.resolvedUrl("Slicing.qml"))
          //clearTimer.start()


          Formide.slicer().slice(modelfile, sliceprofile, material, printer/*, settings*/, function (callback){


             if(callback)
             {
               //console.log("SLICER RESPONSE: "+ callback)

                 var sliceResponse = JSON.parse(callback)
                 //console.log("PrintJobId: "+sliceResponse.printJob.id)

                 setPrintJobId(sliceResponse.printJob.id)

             }
         });

      }

      function removeFile(id){


          Formide.database().removeFile(id,function(err,callback){
              if(err)
                    console.log("ERR: "+err)
              if(callback)
              {
                 //console.log("RESPONSE REMOVE FILE: " +JSON.stringify(JSON.parse(callback)))
                  getFiles()
              }
          })

      }

      function removePrintJob(id){


         //console.log("REMOVE STEP 3")
          Formide.database().removePrintJob(id,function(err,callback){
              if(err)
                 console.log("ERR: "+err)
              if(callback)
              {
                 //console.log("RESPONSE REMOVE PRINTJOB: " +JSON.stringify(JSON.parse(callback)))
                  getPrintJobs()
              }
          })

      }

      function clearScreenFast(){
          pagestack.clear()
          pagestack.push(Qt.resolvedUrl("Home.qml"))
      }

      function clearScreen()
      {
          clearTimer.start()
      }

      function sliceFinished()
      {

          clearTimer.stop()
          pagestack.push(Qt.resolvedUrl("SliceFinished.qml"))
      }
      function sliceFailed()
      {
          clearTimer.start()
          pagestack.push(Qt.resolvedUrl("SliceFailed.qml"))
      }

      function updateFileList()
      {
          getFiles(); getPrintJobs(); getQueue();
      }


      function getEverything()
      {
          getFiles(); getMaterials(); getPrinters(); getSliceProfiles(); getQueue(); getWifiList(); getPrintJobs(); getIsConnectedToWifi();
      }

    /*************
     Timers
     ************/
        // All info, every 5 min
        Timer {
            id: statusTimer
            interval: 60000
            repeat: true
            running: true
            onTriggered:
            {
                getEverything()
            }
        }

        // Login timer
        Timer {
            id: loginTimer
            interval: 30000
            repeat: true
            running: true

            onTriggered:
            {

               //console.log("Connecting")
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

        // The next timer, printingTimer, is not used for now. But it will be used soon.

        // Printing Timer
//        Timer{
//            id:printingTimer
//            running:false
//            repeat:false
//            interval:5000
//            onTriggered: {
//                pagestack.clear()
//                pagestack.push(Qt.resolvedUrl("printing.qml"))
//            }
//        }

        // Clear Timer
        Timer{
            id:clearTimer
            running:false
            repeat:false
            interval:5000
            onTriggered: {
                pagestack.clear()
                pagestack.push(Qt.resolvedUrl("Home.qml"))
            }
        }

        // Speed Timer
        Timer{
            id:speedTimer
            running:false
            repeat:false
            interval:timeoutRatio
            onTriggered: {
                Formide.printer(printerStatus.port).tune("M220 S"+speedValue)
            }
        }

        // Amount/Flow Timer
        Timer{
            id:amountTimer
            running:false
            repeat:false
            interval:timeoutRatio
            onTriggered: {
                Formide.printer(printerStatus.port).tune("M221 S"+amountValue)
            }
        }

        // Ratio Timer
        Timer{
            id:ratioTimer
            running:false
            repeat:false
            interval:timeoutRatio
            onTriggered: {
                Formide.printer(printerStatus.port).tune("G93 R"+leftRatioValue)
            }
        }


    /*************
     WEBSOCKET WEB SOCKET
     ************/

    WebSocket {
        active: false

        function socketLogin () {
            sock.sendTextMessage(JSON.stringify({
                channel: "authenticate",
                data: {
                    type: "user",
                    accessToken: Formide.getAccessToken()
                }
            }));
        }

        id: sock
        url: "ws://127.0.0.1:3001"
        //url: "ws://10.1.0.68:3001"
        //url: "ws://10.30.0.229:3001"

        onTextMessageReceived: {
            try {
                var data = JSON.parse(message);
                //console.log("received event: " + JSON.stringify(data.channel));

                if(data.channel === "slicer.finished")
                {
                    sliceFinished()
                }
                if(data.channel === "slicer.failed")
                {
                    sliceFailed()
                }

                if(data.channel === "printer.status")
                {

                    //console.log(JSON.stringify(data.data))

                    if(data.data.status != "connecting")
                    {
                        printerStatus=data.data

                        if(!initialized && loggedIn)
                        {
                            initialized=true
                            getEverything()
                            splash.visible=false
                        }

                    }


                }
                if(data.channel === "printer.connected")
                {
                    statusBall.color="yellow"
                }
                if(data.channel === "printer.disconnected")
                {
                    statusBall.color="grey"
                }

                if (data.data.notification) {
                   notifications.notify(data.data.level, data.data.message);

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

    /*************
     QML Elements
     ************/
    Component.onCompleted:
        {
            login()
        }


    StackView
    {

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
            }

        id:pagestack
        anchors.fill: parent
        focus: true

        // Link properties and functions
        property var printerStatus:main.printerStatus
        property var materials:main.materials
        property var printer:main.printer
        property var sliceProfiles:main.sliceProfiles
        property var fileItems:main.fileItems
        property var queueItems:main.queueItems
        property var printJobs:main.printJobs
        property var currentPrintJob: main.currentPrintJob
        property var wifiList:main.wifiList

        property var bedPreheated:main.bedPreheated
        property var nozzlePreheated:main.nozzlePreheated

        property var printJobId:main.printJobId
        property var fileNameSelected:main.fileNameSelected
        property var modelFileSelected:main.modelFileSelected
        property var materialSelected:main.materialSelected
        property var qualitySelected:main.materialSelected


        property var uniquePrinter:main.uniquePrinter
        property var uniquePrintJob:main.uniquePrintJob


        property var amountValue:main.amountValue
        property var leftRatioValue:main.leftRatioValue
        property var rightRatioValue:main.rightRatioValue
        property var speedValue:main.speedValue


        property var isLocked:main.isLocked
        property var isConnectedToWifi:main.isConnectedToWifi
        property var ipAddress:main.ipAddress


        property var driveFiles:main.driveFiles
        property var driveListing:main.driveListing
        property var drivePath: main.drivePath
        property var driveUnit: main.driveUnit



        function updateDriveFilesFromPath(){main.updateDriveFilesFromPath()}
        function updateDrivePath(drivePath){main.updateDrivePath(drivePath)}
        function updateDriveListing(i){main.updateDriveListing(i)}
        function updateDriveUnit(driveUnit){main.updateDriveUnit(driveUnit)}
        function scanDrives(){main.scanDrives()}
        function copyFileFromDrive(){main.copyFileFromDrive()}

        function setPrintJobId(data){ main.setPrintJobId(data) }

        function loadFirst(){main.loadFirst()}
        function loadSecond(){main.loadSecond()}
        function unloadFirst(){main.unloadFirst()}
        function replacePosition(){main.replacePosition()}
        function unloadSecond(){main.unloadSecond()}
        function lessAmount(){main.lessAmount()}

        function moreAmount(){main.moreAmount() }

        function moreLeftRatio(){main.moreLeftRatio()}

        function moreRightRatio(){main.moreRightRatio()}

        function switchRatio(){main.switchRatio()}

        function lessSpeed(){main.lessSpeed()}

        function moreSpeed(){main.moreSpeed()}

        function setPassCode(code){main.setPassCode(code)}

        function checkPassCode(code){return main.checkPassCode(code)}

        function toggleNozzle(value) {  main.toggleNozzle(value)  }

        function toggleBed(value) { main.toggleBed(value) }

        function selectSTL(model){ main.selectSTL(model) }

        function printGCode(gcode){ main.printGCode(gcode) }

        function printGCodeFast() { main.printGCodeFast()}

        function clearScreenFast(){ main.clearScreenFast()}

        function sendSliceRequest(uniquePrinter,modelFileSelected,materialSelected,qualitySelected){

            main.sendSliceRequest(uniquePrinter,modelFileSelected,materialSelected,qualitySelected)
        }

        function wifiSettings(){ main.wifiSettings()}

        function getWifiList(){main.getWifiList()}

        function connectToWifi(password) {main.connectToWifi(password)}

        function resetWifi(){main.resetWifi()}

        function popPassword(ssid) { main.popPassword(ssid) }

        function removeFile(id){main.removeFile(id)}

        function removePrintJob(id){main.removePrintJob(id)}

        function getFiles(){main.getFiles()}

        function getPrintJobs(){main.getPrintJobs()}

        function printQueueItem(id,gcode){main.printQueueItem(id)}

        function removeQueueItem(id){main.removeQueueItem(id)}

        function printCustomGcode(id, gcode){main.printCustomGcode(id)}

        function updateFileList(){main.updateFileList()}



        initialItem: Qt.resolvedUrl("Home.qml")

    }




    Timer{
        id:splashTimer

        interval: 60000
        repeat: false
        running: true

        onTriggered:
        {
            console.log("Disabling splash")
            splash.visible=false
        }
    }

    //Splash

    Rectangle{

        id:splash

        visible:true
        anchors.fill: parent

        Image{
            anchors.fill: parent
            source:"Images/splash.jpg"
        }




    }

}

