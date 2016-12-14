//   __          ___        ______ _
//   \ \        / (_)      |  ____(_)
//    \ \  /\  / / _ ______| |__   _
//     \ \/  \/ / | |______|  __| | |
//      \  /\  /  | |      | |    | |
//       \/  \/   |_|      |_|    |_|
//
//


.pragma library
// Includes
.import "Http.js" as HttpHelper
.import "formideShared.js" as Formide


function wifi(){
    return{

        getRegistrationCode:function(callback){return getRegistrationCode(callback)},
        checkConnection:function(callback) {return checkConnection(callback)},
        getSingleNetwork:function(callback){return getSingleNetwork(callback)},
        getList:function(callback){return getList(callback)},
        reset:function(callback){return reset(callback)},
        connect:function(ssid,password,callback){return connect(ssid,password,callback)}

    }
}



/*************
 NATIVE IMPLEMENTATION
 ************/

// Tip: If error = 404, Make sure there is internet connection
function getRegistrationCode(callback)
{
    HttpHelper.doHttpRequest("GET","/api/cloud/code",{},function(err,response){
        if(err)
        {
            console.log("Error registraton token"+JSON.stringify(err));
            if(callback)
                callback(err,null);
        }
        if(response)
        {
            console.log("Response registration token: ",JSON.stringify(response));
            Formide.registrationToken=response.code.toString();
            if(callback)
                callback(null,response);
        }

    });
}

function checkConnection(callback) {
    //console.log("Checking if it's connected!");
    HttpHelper.doHttpRequest("GET", "/api/cloud/status", {}, function (err, response) {

        if(err)
        {
            console.log("Error checking connection",JSON.stringify(err));
            if(callback)
                callback(err,null);
        }
        if(response)
        {
            if(response.connected)
            {
                Formide.isConnectedToWifi=response.connected
                Formide.ipAddress=response.internalIp;
            }
//            console.log("Response checking connection",JSON.stringify(response));
            if(callback)
                callback(null,response);
        }


    });
}

// Tip for callback: It returns the name of the network!
function getSingleNetwork(callback) {

    HttpHelper.doHttpRequest("GET", "/api/cloud/network", {}, function (err, network) {
        try {
            var net = network.ssid;
            Formide.singleNetwork=net;
            if(callback)
                callback(null, net);
        }
        catch (e) {
            console.log("Exception checking network",e)
            if(callback)
                callback(e,null);
        }
    });
}



function getList(callback) {

    HttpHelper.doHttpRequest("GET", "/api/cloud/networks", {}, function (err, list) {
        try {
            var wifiArray = [];
            for (var key in list) {
                wifiArray.push(list[key]['ssid']);
            }


//            console.log("Found "+wifiArray.length+" networks")
            Formide.wifiList=wifiArray;
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



function reset(callback) {
   console.log("Reseting wifi");
    var payload =
            {

            };
    HttpHelper.doHttpRequest("POST", "/api/cloud/setup", JSON.stringify(payload), function (err, response) {

        if(err)
        {
            console.log("Error reset Wi-Fi",JSON.stringify(err));
            if(callback)
                callback(err,null);
        }
        if (response)
        {
           //console.log('Response reset Wi-Fi', JSON.stringify(response))
            Formide.singleNetwork=""
            Formide.wifiList=[]
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
    HttpHelper.doHttpRequest("POST", "/api/cloud/wifi", JSON.stringify(payload), function (err, response) {

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
            checkConnection();
            if(callback)
                callback(null,response.message);
        }
    });
}
