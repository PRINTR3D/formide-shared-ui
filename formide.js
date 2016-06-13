.pragma library

Qt.include("socketParser.js");



// vars
var baseUrl = 'http://127.0.0.1:1337';
//var baseUrl = 'http://10.1.0.52:1337';
//var accessToken = '7e109efa-c2a4-4fab-b7f4-f348842111d9';

var accessToken = '';
var globalPort //= "tty.usbserial-A603FBZE";


// do an http request
function doHttpRequest(method, path, data, callback) {
    var xhr = new XMLHttpRequest;
    var uri = baseUrl + path;
    var queryString = "";

    // populate query string on GET request


    if (data && method === "GET") {
        for (var i in data) {
            queryString += "&" + i + "=" + data[i];
        }
        uri += "?q=1" + queryString;
    }

    // config http request
    xhr.open(method, uri, true);
    xhr.setRequestHeader("authorization", "Bearer " + accessToken);

    // listen to http response
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            var response = xhr.responseText;
            if (callback) return callback(null, response);
        }
    }

    // perform http request
    if (method === "GET") {
        xhr.send();
    }
    else {

//        if(path==="/api/auth/login")
//        {
//            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
//            xhr.setRequestHeader("Content-length", queryString.length);
//            xhr.send(queryString);
//        }

//        else
//        {
            xhr.setRequestHeader("Content-type", "application/json");
            xhr.setRequestHeader("Content-length", data.length);
             xhr.send(data);
        //}
    }
}

// call http login
function login (username, password, callback) {
    // only request new access token when not set yet
    if (accessToken === '') {

        var credentials = {
            "email": username,
            "password": password
        }
        doHttpRequest("POST", "/api/auth/login", JSON.stringify(credentials), function (err, response) {
            // set access token

            if(err)
                console.log("ERROR LOGIN: ",err);


            accessToken = JSON.parse(response).access_token;

           console.log("recv bearer: "+accessToken)
            callback(true)
//            events.authenticate(accessToken, function (err, response) {
//                if (err)//console.log(err);
//                if (callback) return callback(null, response);
//            });
        });
    }
    else {
        if (callback) return callback(null, false);
    }
}

// get access token
function getAccessToken() {
    return accessToken;
}

function usb() {

    return {

        readDrive:function (drive,path,callback) {

            //console.log("Reading drive");

            var data=
            {
                "path":path
            }

            var res = encodeURIComponent(drive);

            //console.log("URL: ",res);

            doHttpRequest("GET", "/api/files/read/"+res, data, function (err, list) {

                if(err)
                    console.log("Response ERR: ",err);
                if(list)
                {
                    //console.log("Response OK: ",list)
                    callback(null,JSON.parse(list));
                }

            });

        },

        copyFile:function (drive,path,callback) {

            console.log("Copying file to FORMIDE");

            var data=
            {
                "path":path
            }

            var res = encodeURIComponent(drive);

            //console.log("URL: ",res);

            doHttpRequest("POST", "/api/files/copy/"+res, JSON.stringify(data), function (err, list) {

                if(err)
                    console.log("Response ERR: ",err);
                if(list)
                {
                    //console.log("Response OK: ",list)
                    callback(null,JSON.parse(list));
                }

            });

        },


        scanDrives: function (callback) {

            console.log("Scanning drives");
            doHttpRequest("GET", "/api/files/drives", {}, function (err, list) {

                if(err)
                    console.log("Response ERR: ",err);
                if(list)
                {
                    console.log("Response: ",list);
                    callback(JSON.parse(list));
                }

            });

        },
        mount: function (drive,callback) {

            console.log("Scanning drives");
            var res = encodeURIComponent(drive);
            doHttpRequest("POST", "/api/files/mount/"+res, "", function (err, response) {

                if(err)
                    console.log("Response ERR: ",JSON.stringify(err));
                if(response)
                {
                    //console.log("Response mount OK: ",response)
                    callback(null,JSON.parse(response));
                }

            });

        },
        unmount: function (drive,callback) {

            console.log("Scanning drives");
            doHttpRequest("POST", "/api/files/unmount/"+drive, {}, function (err, response) {

                if(err)
                    console.log("Response ERR: ",err);
                if(response)
                {
                    //console.log("Response OK: ",response)
                    callback(JSON.parse(response));
                }

            });

        },
    }
}

function database () {
    return {

        // get user files, includes previously sliced printjobs
        // example: Formide.database().files(function(err, files) {});
        files: function (callback) {
            doHttpRequest("GET", "/api/db/files", {}, function (err, files) {
                return callback(err, files);
            });
        },

        printJobs: function (callback) {
            doHttpRequest("GET", "/api/db/printjobs", {}, function (err, printjobs) {
                return callback(err, printjobs);
            });
        },



        removeFile: function (id,callback) {
            doHttpRequest("DELETE", "/api/db/files/" + id, {}, function (err, result) {
                return callback(err, result);
            });
        },

        removePrintJob: function (id,callback) {

           //console.log("REMOVE STEP 4")
            doHttpRequest("DELETE", "/api/db/printjobs/" + id, {}, function (err, result) {
                return callback(err, result);
            });
        },

        removeQueueItem: function (id,callback) {

            doHttpRequest("DELETE", "/api/db/queue/" + id, {}, function (err, result) {
                return callback(err, result);
            });
        },

        // get material profiles, we will ship presets (like "PLA")
        // example: Formide.database().materials(function(err, files) {});
        materials: function (callback) {
            doHttpRequest("GET", "/api/db/materials", {}, function (err, materials) {
                return callback(err, materials);
            });
        },

        // get slice profiles, we will ship presets per manufacturer (like "High Quality")
        // example: Formide.database().sliceprofiles(function(err, files) {});
        sliceprofiles: function (callback) {
            doHttpRequest("GET", "/api/db/sliceprofiles", {}, function (err, sliceprofiles) {
                return callback(err, sliceprofiles);
            });
        },

        // get printer profiles, embedded you usually want the first item in this array when slicing
        // example: Formide.database().printers(true, function(err, printers) {});
        printers: function (getSingle, callback) {
            doHttpRequest("GET", "/api/db/printers", {}, function (err, printers) {
                return callback(err, (getSingle ? printers[0] : printers));
            });
        }
    }
}

function slicer() {
    return {

        // slice request
        // example: Formide.slicer().slice([1], [1], 1, 1, {SETTINGS}, function(err, printjob) {});
        slice: function(modelfiles, sliceprofile, materials, printer/*, settings*/, callback) {

            var jsonSent =
                    {
                    "files": [modelfiles],
                    "sliceProfile": sliceprofile,
                    "materials":[materials, materials],
                    "printer":printer,
                    "settings": {
                          "brim": {
                              "use": false
                          },
                          "raft": {
                              "use": false
                          },
                          "bed": {
                              "use": true,
                              "temperature":60,
                              "firstLayersTemperature":60
                          },
                          "support": {
                              "use": false
                          },
                          "skirt": {
                              "use": true,
                              "extruder": 0
                          },
                          "fan": {
                              "use": true,
                              "speed": 100
                          },
                          "override": {
                          },
                          "files": [
                              {
                                  "id": 1,
                                  "extruder": 0,
                                  "position": {
                                      "x": 0,
                                      "y": 0,
                                      "z": 0
                                  },
                                  "rotation": {
                                      "x": 0,
                                      "y": 0,
                                      "z": 0
                                  },
                                  "scale": {
                                      "x": 1,
                                      "y": 1,
                                      "z": 1
                                  }
                              }
                          ]
                      }
                    }


           //console.log("Sending slice request jsonSent: ",JSON.stringify(jsonSent))


            doHttpRequest("POST", "/api/slicer/slice", JSON.stringify(jsonSent) , function (err, response) {


               //console.log("Receiving something")
                if(err)
                   console.log("SLICING ERROR: ",err)
                if (response)
                {

                    console.log('SLICING RESPONSE: ', response)
                    return callback(response)
                }
            });



        }
    }
}

function wifi() {
    return {


        isConnected: function (callback) {

            //console.log("Checking if it's connected!");
            doHttpRequest("GET", "/api/cloud/status", {}, function (err, list) {

                if(err)
                    console.log("Response ERR cloud status: ",err);
                if(list)
                {
                    callback(null,JSON.parse(list));
                }
                    //console.log("Response LIST cloud status: ",list);

            });
        },



        getList: function (callback) {


            //console.log("Getting wifi list!")
            doHttpRequest("GET", "/api/cloud/networks", {}, function (err, list) {
                try {
                    var wifiArray = [];
                    for (var key in JSON.parse(list)) {
                        wifiArray.push(JSON.parse(list)[key]['ssid']);
                    }
                    return callback(null, wifiArray);
                }
                catch (e) {
                    return callback(e);
                }
            });
        },



        reset: function(callback) {
           console.log("Reseting wifi");
            var jsonSent =
                    {

                    };
            doHttpRequest("POST", "/api/cloud/setup", JSON.stringify(jsonSent), function (err, response) {

                if(err)
                   console.log("ERROR: ",err)
                if (response)
                {
                   //console.log('RESPONSE: ', response)
                    return callback(null,JSON.parse(response).message);
                }
            });
        },

        connect: function(ssid,password,callback) {
           //console.log("connecting to "+ssid + " pw: "+password)
            var jsonSent =
                    {
                    "ssid":ssid,
                    "password": password
                    }
            doHttpRequest("POST", "/api/cloud/wifi", JSON.stringify(jsonSent), function (err, response) {

                if(err)
                   console.log("ERROR: ",err)
                if (response)
                {
                   //console.log('RESPONSE: ', response)
                    return callback(null,JSON.parse(response).message);
                }
            });
        }

    }



}



// printer functions
function printer (port) {

    port = port.substr(5) || globalPort;
   // port=port;
    return {

        // get the printer status
        // example: Formide.printer().status(function(err, status) {});
        status: function(callback) {
            doHttpRequest("GET", "/api/printer/" + port + "/status", false, function(err, response) {
                if (callback) return callback(err, JSON.parse(response));
            });
        },

        // home the printer
        // example: Formide.printer().home()
        home: function() {
           //console.log("Homing printer")
            doHttpRequest("GET", "/api/printer/" + port + "/home");
        },

        // home a specific axis
        // example: Formide.printer().home('x')
        homeAxis: function(axis) {
            doHttpRequest("GET", "/api/printer/" + port + "/home_" + axis);
        },

        // move the printer
        // example: Formide.printer().jog('X', 10)
        jog: function(axis, dist) {
           //console.log("Jog axis: "+axis+" "+dist)
            doHttpRequest("GET", "/api/printer/" + port + "/jog", {
                axis: axis,
                dist: parseInt(dist)
            });
        },

        // set the extruder temperature
        // example: Formide.printer().setExtruderTemperature(0, 200)
        setExtruderTemperature: function(extruder, temperature) {
            //console.log("Port: "+port+". Setting extruder"+extruder+" temperature to "+temperature);
            doHttpRequest("GET", "/api/printer/" + port + "/temp_extruder", {
                temp: parseInt(temperature),
                extnr: parseInt(extruder)
            });
        },

        // set the temperature of the heated bed
        // example: Formide.printer().setBedTemperature(50)
        setBedTemperature: function(temperature) {
            doHttpRequest("GET", "/api/printer/" + port + "/temp_bed", {
                temp: parseInt(temperature)
            });
        },

        gcode: function(gcode) {
           //console.log("Sending: "+gcode)
            var jsonSent =
                    {
                    "command": gcode
                    }
            doHttpRequest("POST", "/api/printer/" + port + "/gcode", JSON.stringify(jsonSent));
        },

        tune: function(gcode) {
           //console.log("Sending: "+gcode)

            var jsonSent =
                    {
                    "command": gcode
                    }
            doHttpRequest("POST", "/api/printer/" + port + "/tune", JSON.stringify(jsonSent));
        },

        // get queue for specific port
        // example: Formide.printer().getQueue(function(err, response) {});
        getQueue: function(callback) {
            doHttpRequest("GET", "/api/db/queue", {
//                port: port
            }, function(err, response) {
                return callback(null, response);
            });
        },

        // Add item to queue for specific port
        // example: Formide.printer().addToQueue(function(err, response) {});

        addCustomGcodeToPrintJobs: function (gcodefile, callback) {

            var jsonSent =
                    {
                    "file": gcodefile
                    }

            doHttpRequest("POST", "/api/db/printjobs", JSON.stringify(jsonSent) , function (err, response) {

                if(err)
                   console.log("ERROR: ",err)
                if (response)
                {
                    //console.log('RESPONSE: ', response)
                    return callback(null,response)
                }
            });

        },


        addToQueue: function(printJobId, callback) {

            var jsonSent =
                    {
                    "printJob": printJobId,
                    "port": port
                    }


           ////console.log("Sending slice request jsonSent: ",JSON.stringify(jsonSent))


            doHttpRequest("POST", "/api/db/queue", JSON.stringify(jsonSent) , function (err, response) {

                if(err)
                   console.log("ERROR: ",err)
                if (response)
                {
                    //console.log('RESPONSE: ', response)
                    return callback(response)
                }
            });
        },

        // start a print based on queue id and gcodefile hash
        // example: Formide.printer().start(1);
        start: function(queueId) {
          console.log("Sending start print request");
           //console.log("GET /api/printer/" + port + "/start")
            doHttpRequest("GET", "/api/printer/" + port + "/start", {
                queueItem: queueId
                //gcode: gcodeHash
            }, function (err,response){
                if(err)
                   console.log("err",err)
                if(response)
                   console.log("response",response)
            });
        },

        // pause the printer
        // example: Formide.printer().pause();
        pause: function() {
            doHttpRequest("GET", "/api/printer/" + port + "/pause");
        },

        // resume the printer
        // example: Formide.printer().resume();
        resume: function() {
            doHttpRequest("GET", "/api/printer/" + port + "/resume");
        },

        // stop the printer
        // example: Formide.printer().stop();
        stop: function() {
            doHttpRequest("GET", "/api/printer/" + port + "/stop");
        }
    }
}
