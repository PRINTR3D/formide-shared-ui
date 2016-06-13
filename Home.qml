import QtQuick 2.0
import "formide.js" as Formide

Item {

    id:home
    visible:true
    width:parent.width
    height:parent.height

    /**************
      COLORS
      **************/
    property var backgroundColor:"#ECECEC"
    property var statusBackgroundColor:"#D6D6D6"
    property var leftStatusBackgroundColor:"#E1E1E1"
    property var temperatureColor:"#6F6E6E"
    property var targetColor:"#8A8A8A"
    property var separatorColor:"#6F6E6E"


    /**************
      INDICATORS
      **************/

    property var wifi:false
    property var network:false
    property var usb:false
    property var sdCard:false
    property var lock:parent.isLocked
    property var isConnectedToWifi:parent.isConnectedToWifi


    /**************
      PROPERTIES
      **************/

    // Link properties and functions

    property var fileNameVisible:false
    property var printerStatus:parent.printerStatus
    property var materials:parent.materials
    property var printer:parent.printer
    property var sliceProfiles:parent.sliceProfiles
    property var fileItems:parent.fileItems
    property var queueItems:parent.queueItems

    property var printJobId:parent.printJobId
    property var currentPrintJob:parent.currentPrintJob
    property var modelFileSelected:parent.modelFileSelected

    property var uniquePrinter:parent.uniquePrinter
    property var uniquePrintJob:parent.uniquePrintJob

    function setPrintJobId(data){ parent.setPrintJobId(data) }


    function getFileName() {
        if (uniquePrintJob)
        {
            //console.log("UniquePrintJob: ",uniquePrintJob);
            return uniquePrintJob.printJob.name
        }
        else
            return ""

    }

    function calculateRemainingTime(){

        if (!printerStatus)
            return ""

        if (printerStatus.status!=="printing" && printerStatus.status!=="heating" && printerStatus.status!=="paused")
            return ""


        // Calculate time elapsed
        var prevTime = new Date(printerStatus.timeStarted);
        var thisTime = new Date(printerStatus.timeNow);
        var diff = (thisTime.getTime() - prevTime.getTime()) / 1000;   // now - Feb 1
        //console.log("Time elapsed in seconds: ",diff);     // positive number of days

        // Calculate progress left

        var progress;
        if(!printerStatus.currentLine || !printerStatus.totalLines)
        {

            //console.log("currentLine: ",printerStatus.currentLine)
            //console.log("Total lines: " ,printerStatus.totalLines)
            progress = printerStatus.progress;

        }
        else
        {

            //console.log("Current line: " ,printerStatus.currentLine)
            //console.log("Total lines: " ,printerStatus.totalLines)
            progress = printerStatus.currentLine * 100 / printerStatus.totalLines;
        }

        //console.log("Progress: " + progress)
        if (progress < 1)
            return "Calculating"


        var progressLeft =  100 - progress;

        var totalSec = Math.abs(diff * progressLeft / progress);

        //console.log("Time left in seconds: ",totalSec)

        //var totalSec = uniquePrintJob.printJob.sliceResponse.totalTime * (100 - printerStatus.progress ) / 100; // - (difference/1000);
        var days = (parseInt( totalSec / 3600 ) / 24).toFixed(0);
        var hours = (parseInt( totalSec / 3600 ) % 24).toFixed(0);
        var minutes = (parseInt( totalSec / 60 ) % 60).toFixed(0);
        var seconds = (totalSec % 60).toFixed(0);

        var result = (days<1?"":days +"d ") + (hours < 10 ? "0" + hours : hours) + ":" + (minutes < 10 ? "0" + minutes : minutes) + "h"/*+ ":" + (seconds  < 10 ? "0" + seconds : seconds)*/;


        //console.log("TIME: " + result)
        return result

    }




    /**************
      FUNCTIONS
      **************/




    /**************
      VALUES
      *************/

    function getProgress()
    {
        if (!printerStatus)
            return 0
        else
            return printerStatus.progress/100
    }

    function nozzleTemperature(){
        if(!printerStatus)
            return "000"
        else
            return printerStatus.extruders[0].temp
    }

    function nozzleTarget(){
        if(!printerStatus)
            return "000"
        else
            return printerStatus.extruders[0].targetTemp
    }

    function bedTemperature(){
        if(!printerStatus)
            return "000"
        else
            return printerStatus.bed.temp
    }

    function bedTarget(){
        if(!printerStatus)
            return "000"
        else
            return printerStatus.bed.targetTemp
    }

    function bedHeight(){
        if(!printerStatus)
            return "000"
        else
        {
            if ((printerStatus.coordinates.z).toFixed(2) < 0.01)
                return "0.00"
            else
                return (printerStatus.coordinates.z).toFixed(2)
        }
    }




    /**************
      QML ELEMENTS
      **************/

    Rectangle{

        //Empty
    }


}

