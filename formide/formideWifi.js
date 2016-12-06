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
            console.log("Error registraton token"+err);
            callback(err,null);
        }
        if(response)
        {
            console.log("Response registration token: ",response);
            Formide.registrationToken=response.code.toString();
            callback(null,response);
        }

    });
}

function checkConnection(callback) {
    //console.log("Checking if it's connected!");
    HttpHelper.doHttpRequest("GET", "/api/cloud/status", {}, function (err, response) {

        if(err)
        {
            console.log("Error Is Connected",err);
            callback(err,null);
        }
        if(response)
        {
            if(response.connected)
            {
                Formide.isConnectedToWifi=response.connected
                Formide.ipAddress=response.internalIp;
            }
//            console.log("Response Is Connected",response);
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
            callback(null, net);
        }
        catch (e) {
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
            callback(null, wifiArray);
        }
        catch (e) {
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
            console.log("Error reset Wi-Fi",err);
            callback(err,null);
        }
        if (response)
        {
           //console.log('Response reset Wi-Fi', response)
            Formide.singleNetwork=""
            Formide.wifiList=[]
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
            console.log("Error connecting to Wi-Fi",err);
            callback(err,null);
        }
        if (response)
        {

            // Check connection immediately after connecting
            checkConnection();
            callback(null,response.message);
        }
    });
}
