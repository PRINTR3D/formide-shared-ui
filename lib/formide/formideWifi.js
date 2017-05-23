/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */



.pragma library
// Includes
.import "Http.js" as HttpHelper


function wifi(){
    return{

        checkConnection:function(callback) {return checkConnection(callback)},
        getList:function(callback){return getList(callback)},
        reset:function(callback){return reset(callback)},
        hotspot:function(enabled,callback){return hotspot(enabled,callback)},
        connect:function(ssid,password,callback){return connect(ssid,password,callback)}

    }
}

// Native Implementation
function checkConnection(callback) {
    HttpHelper.doHttpRequest("GET", "/api/network/status", {}, function (err, response) {

        if(err)
        {
            console.log("Error checking connection",JSON.stringify(err));
            if(callback)
                callback(err,null);
        }
        if(response)
        {
            if(response.isConnected)
            {
//                Formide.isConnectedToWifi=response.connected
//                Formide.ipAddress=response.internalIp;
            }
//            console.log("Response checking connection",JSON.stringify(response));
            if(callback)
                callback(null,response);
        }


    });
}

function getList(callback) {

//    console.log("Retrieving Wi-Fi list")
    HttpHelper.doHttpRequest("GET", "/api/network/list", {}, function (err, list) {
        try {
            var wifiArray = [];
            for (var key in list) {
                wifiArray.push(list[key]['ssid']);
            }

            if(callback)
                callback(null, wifiArray);
        }
        catch (e) {
            if(callback)
                callback(e);
        }
    });
}

function reset(callback) {
   console.log("Reseting Wi-Fi");
    var payload =
            {
            };

    HttpHelper.doHttpRequest("POST", "/api/network/reset", JSON.stringify(payload), function (err, response) {

        if(err)
        {
            console.log("Error reset Wi-Fi",JSON.stringify(err));
            if(callback)
                callback(err,null);
        }
        if (response)
        {
           //console.log('Response reset', JSON.stringify(response))
            if(callback)
                callback(null,response.message);
        }
    });
}



function hotspot(enabled,callback) {
   console.log("Enable hotspot?",enabled);
    var payload =
            {
            "enabled":enabled
            };

    HttpHelper.doHttpRequest("POST", "/api/network/hotspot", JSON.stringify(payload), function (err, response) {

        if(err)
        {
            console.log("Error Hotspot Wi-Fi",JSON.stringify(err));
            if(callback)
                callback(err,null);
        }
        if (response)
        {
           //console.log('Response Hotspot', JSON.stringify(response))
            if(callback)
                callback(null,response.message);
        }
    });
}

function connect(ssid,password,callback) {
   //console.log("connecting to "+ssid + " pw: "+password)
    var payload =
            {
            "ssid":ssid,
            "password": password
            }
    HttpHelper.doHttpRequest("POST", "/api/network/connect", JSON.stringify(payload), function (err, response) {

        if(err)
        {
            console.log("Error connecting to Wi-Fi",JSON.stringify(err));
            if(callback)
                callback(err,null);
        }
        if (response)
        {

            // Check connection immediately after connecting
            console.log("Response connecting to network",JSON.stringify(response))

            if(callback)
                callback(null,response.message);
        }
    });
}
