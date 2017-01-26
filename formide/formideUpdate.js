//    _    _ _____  _____       _______ ______
//   | |  | |  __ \|  __ \   /\|__   __|  ____|
//   | |  | | |__) | |  | | /  \  | |  | |__
//   | |  | |  ___/| |  | |/ /\ \ | |  |  __|
//   | |__| | |    | |__| / ____ \| |  | |____
//    \____/|_|    |_____/_/    \_|_|  |______|
//
//
.pragma library
// Includes
.import "Http.js" as HttpHelper
.import "formideShared.js" as Formide


// Exposure
function update(){
    return{
        checkUpdate:function(callback){return checkUpdate(callback);},
        status:function(callback){return status(callback);},
        updateElement:function(callback){return updateElement(callback);},
        current:function(callback){return current(callback);}
    }
}

/*************
 NATIVE IMPLEMENTATION
 ************/

// Tip for callback: Check update variables!
function checkUpdate(callback) {

    console.log("Checking for updates")
    HttpHelper.doHttpRequest("GET", "/api/update/check", {}, function (err, response) {

        if(err)
        {
            callback(err,null);
        }
        if(response)
        {
            callback(null,response);
        }

    })
}

function status(callback) {

    HttpHelper.doHttpRequest("GET", "/api/update/status", {}, function (err, response) {

        if(err)
        {
            callback(err,null)
        }
        if(response)
        {
            callback(response);
        }

    })
}

function updateElement(callback) {
    HttpHelper.doHttpRequest("POST", "/api/update/do", JSON.stringify({}), function (err, response) {

        if(err)
        {
            callback(err,null)
        }
        if (response)
        {
           callback(response);
        }
    });
}

// Tip for callback: currentClientVersion=callback.version;
function current(callback){
    HttpHelper.doHttpRequest("GET", "/api/update/current", JSON.stringify({}), function (err, response) {

        if(err)
        {
            callback(err,null)
        }
        if(response)
        {
            callback(response);
        }

    })
}
