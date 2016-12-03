//    _____  _____  _____ _   _ _______ ______ _____
//   |  __ \|  __ \|_   _| \ | |__   __|  ____|  __ \
//   | |__) | |__) | | | |  \| |  | |  | |__  | |__) |
//   |  ___/|  _  /  | | | . ` |  | |  |  __| |  _  /
//   | |    | | \ \ _| |_| |\  |  | |  | |____| | \ \
//   |_|    |_|  \_|_____|_| \_|  |_|  |______|_|  \_\
//
//


.pragma library
// Includes
.import "Http.js" as HttpHelper
.import "formide.js" as Formide
.import "formideDatabase.js" as FormideDatabase

function printer (port) {

    port = port.substr(5) || globalPort;

    return {

        // Home the printer - Sends G28
        home: function() {
           //console.log("Homing printer")
            HttpHelper.doHttpRequest("GET", "/api/printer/" + port + "/home");
        },

        // Home specific Axis - Sends G28 + axis letter
        homeAxis: function(axis) {
            HttpHelper.doHttpRequest("GET", "/api/printer/" + port + "/home_" + axis);
        },

        // Move the printer - Sends G1 + axis + dist
        jog: function(axis, dist) {
           //console.log("Jog axis: "+axis+" "+dist)
            HttpHelper.doHttpRequest("GET", "/api/printer/" + port + "/jog", {
                axis: axis,
                dist: parseInt(dist)
            });
        },


        // Set extruder temperature - Sends M104 S{temperature} T{extruderNumber}
        setExtruderTemperature: function(extruder, temperature) {
            //console.log("Port: "+port+". Setting extruder"+extruder+" temperature to "+temperature);
            HttpHelper.doHttpRequest("GET", "/api/printer/" + port + "/temp_extruder", {
                temp: parseInt(temperature),
                extnr: parseInt(extruder)
            });
        },

        // Set extruder temperature - Sends M140 S{temperature}
        setBedTemperature: function(temperature) {
            HttpHelper.doHttpRequest("GET", "/api/printer/" + port + "/temp_bed", {
                temp: parseInt(temperature)
            });
        },

        // Sends custom gcode to printer
        gcode: function(gcode) {
           //console.log("Sending: "+gcode)
            var jsonSent =
                    {
                    "command": gcode
                    }
            HttpHelper.doHttpRequest("POST", "/api/printer/" + port + "/gcode", JSON.stringify(jsonSent));
        },


        // Sends tune command to printer (when printing)
        tune: function(gcode) {
           //console.log("Sending: "+gcode)

            var jsonSent =
                    {
                    "command": gcode
                    }
            HttpHelper.doHttpRequest("POST", "/api/printer/" + port + "/tune", JSON.stringify(jsonSent));
        },

        // get queue for specific port
        getQueue: function(callback) {

            Formide.loadingQueue=true;
            HttpHelper.doHttpRequest("GET", "/api/db/queue", {
                port: "/dev/"+port
            }, function(err, response) {

                if(err)
                {
                    //console.log("Error loading queue",err)
                    Formide.loadingQueue=false;
                    if(callback)
                        return callback(err,null);
                }
                if(response)
                {
                   console.log("Response get queue",response);

                   for (var i in data) {
                       if (data[i].id === Formide.currentQueueItemId)
                       {
                           Formide.currentPrintJob=data[i].printJob
                           break;
                       }
                   }

                   // Update queue items
                   Formide.queueItems = response.filter(function(queueItem) {
                       if (queueItem.status == "queued")
                           return queueItem;
                   });


                   Formide.loadingQueue=false;

                   if(callback)
                       return callback(null,response);
                }
            });
        },

        // Add item to queue for specific port
        // example: Formide.printer().addToQueue(function(err, response) {});

        addCustomGcodeToPrintJobs: function (gcodefileId, addToQueueToo, directPrint, callback) {

            var payload =
                {
                    "file": gcodefileId
                }

            HttpHelper.doHttpRequest("POST", "/api/db/printjobs", JSON.stringify(payload) , function (err, response) {

                if(err)
                {
                    console.log("Error adding custom gcode to print jobs: "+err)
                    if(callback)
                        return callback(err,null)
                }
                if(response)
                {
                    //console.log('Response add custom gcode to print jobs: ', response)

                    // If necessary, we can add print job to Queue and print it
                    if(addToQueueToo || directPrint)
                    {
                        printer(Formide.printerStatus.port).addToQueue(response.printJob.id,directPrint);
                    }


                    if(callback)
                        return callback(null,response)
                }
            });

        },


        addToQueue: function(printJobId, directPrint, callback) {

            var payload =
                    {
                    "printJob": printJobId,
                    "port": "/dev/"+port
                    }

            HttpHelper.doHttpRequest("POST", "/api/db/queue", JSON.stringify(payload) , function (err, response) {

                if(err)
                {
                    //console.log("Error adding a file to queue",err);
                    if(callback)
                        return callback(err,null)
                }
                if (response)
                {
                    //console.log('Response adding a file to queue', response)

                    // After adding a file to queue, we update our queue items (to be removed with event implementation)
                    printer(port).getQueue();

                    // Print file after being added to queue
                    if(directPrint)
                    {
                        if(response.queueItem.status==="queued")
                        {
                            var queueId = response.queueItem.id
                            printer(port).start(queueId);
                        }
                    }

                    if(callback)
                        return callback(null,response);
                }
            });
        },

        // Print a file from file path
        printFileFromFileSystem: function(filePath,callback) {
            console.log("Printing file from file system: "+filePath);
            HttpHelper.doHttpRequest("GET","/api/printer/"+ port + "/print",
                {
                    file:filePath
                }, function(err,response){
                    if(err)
                    {
                        //console.log("Error printing a file from file system",err);
                        if(callback)
                            return callback(err,null)
                    }
                    if (response)
                    {
                        console.log("Response print a file from file system",response)
                        if(callback)
                            return callback(null,response)
                    }
            });
        },

        // Start a print based on queue id
        start: function(queueId, callback) {
          console.log("Sending start print request");
           //console.log("GET /api/printer/" + port + "/start")
            HttpHelper.doHttpRequest("GET", "/api/printer/" + port + "/start", {
                queueItem: queueId
            }, function (err,response){
                if(err)
                {
                    //console.log("Error starting a print",err);
                    if(callback)
                        return callback(err,null)
                }
                if (response)
                {
                    console.log("Response starting a print",response)
                    if(callback)
                        return callback(null,response)
                }
            });
        },

        // pause the printer
        // example: Formide.printer().pause();
        pause: function() {
            HttpHelper.doHttpRequest("GET", "/api/printer/" + port + "/pause");
        },

        // resume the printer
        // example: Formide.printer().resume();
        resume: function() {
            HttpHelper.doHttpRequest("GET", "/api/printer/" + port + "/resume");
        },

        // stop the printer
        // example: Formide.printer().stop();
        stop: function() {
            HttpHelper.doHttpRequest("GET", "/api/printer/" + port + "/stop");
        }
    }
}
