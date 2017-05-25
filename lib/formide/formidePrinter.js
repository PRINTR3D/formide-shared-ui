/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


.pragma library
// Includes
.import "Http.js" as HttpHelper
.import "formideShared.js" as Formide

function printer (port) {

    //port = port.substr(5) || globalPort;
    var decodedPort=port;
    port = encodeURIComponent(port);

    return {

        list: function(callback)
        {
            HttpHelper.doHttpRequest("GET", "/api/printer/", {}, function(err, response) {

                if(err)
                {
                    if(callback)
                       callback(err,null);
                }
                if(response)
                {
                   if(callback)
                       callback(null,response);
                }
            });
        },

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
        gcode: function(gcode,callback) {
           //console.log("Sending: "+gcode)
            var payload =
                    {
                    "command": gcode
                    }

            HttpHelper.doHttpRequest("POST", "/api/printer/" + port + "/gcode", JSON.stringify(payload),callback);
        },


        // Sends tune command to printer (when printing)
        tune: function(gcode,callback) {
           //console.log("Sending: "+gcode)

            var jsonSent =
                    {
                    "port":port,
                    "command": gcode
                    }
            HttpHelper.doHttpRequest("POST", "/api/printer/" + port + "/tune", JSON.stringify(jsonSent),callback);
        },

        // get queue for specific port
        getQueue: function(callback) {
            HttpHelper.doHttpRequest("GET", "/api/queue", {
                port: port
            }, function(err, response) {

                if(err)
                {
                    if(callback)
                        return callback(err,null);
                }
                if(response)
                {
                   if(callback)
                       return callback(null,response);
                }
            });
        },

        /**
         * Remove queue item by ID
         * @param {String} queueId The ID of the queue item to remove.
         * @param {Function} callback Callback function
         */
        removeQueueItem: function (queueId, callback) {
            HttpHelper.doHttpRequest("DELETE", "/api/queue" + queueId, JSON.stringify({}), function(err, response) {
                
                if(err) {
                    if (callback) return callback(err, null)
                }
                
                if(response) {
                    if (callback) return callback(null, response)
                }
            })
        },

        // Print a file from file path
        printFileFromFileSystem: function(filePath,callback) {
            console.log("Printing file from file system: " + filePath);

            var payload = {
                file:filePath,
                port:port

            };

            HttpHelper.doHttpRequest("POST", "/api/printer/" + port + "/print", JSON.stringify(payload), function(err, response) {
                    if(err)
                    {
                        if(callback)
                            return callback(err,null)
                    }
                    if (response)
                    {
                        if(callback)
                            return callback(null,response)
                    }
            });
        },

        // Start a print based on queue id
        start: function(queueId, gcode, callback) {
          console.log("Sending start print request");
           //console.log("POST /api/printer/" + port + "/start")

            var payload={
                port: decodedPort,
                gcode: gcode
            }
            HttpHelper.doHttpRequest("POST", "/api/queue/" + queueId + "/print", JSON.stringify(payload), function (err,response){
                if(err)
                {
                    console.log("Error starting a print",JSON.stringify(err));
                    if(callback)
                        return callback(err,null)
                }
                if (response)
                {
//                    console.log("Response starting a print",JSON.stringify(response))
                    if(callback)
                        return callback(null,response)
                }
            });
        },

        // pause the printer
        // example: Formide.printer().pause();
        pause: function(gcode) {

            if(gcode)
            {
                var payload={
                    "pauseGcode":gcode
                }
                HttpHelper.doHttpRequest("POST", "/api/printer/" + port + "/pause",JSON.stringify(payload));
            }

            else
                HttpHelper.doHttpRequest("POST", "/api/printer/" + port + "/pause",JSON.stringify({}));
        },

        // resume the printer
        // example: Formide.printer().resume();
        resume: function(gcode) {

            if(gcode)
            {
                console.log("resume gcode")
                var payload={
                    "resumeGcode":gcode
                }
                HttpHelper.doHttpRequest("POST", "/api/printer/" + port + "/resume",JSON.stringify(payload));
            }

            else
                HttpHelper.doHttpRequest("POST", "/api/printer/" + port + "/resume",JSON.stringify({}));
        },

        // stop the printer
        // example: Formide.printer().stop();
        stop: function(gcode) {

            if(gcode)
            {
                var payload={
                    "stopGcode":gcode
                }
                HttpHelper.doHttpRequest("POST", "/api/printer/" + port + "/stop",JSON.stringify(payload));
            }

            else
                HttpHelper.doHttpRequest("POST", "/api/printer/" + port + "/stop",JSON.stringify({}));
        }
    }
}
