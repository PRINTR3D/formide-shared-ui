//    _    _ _____  _____       _______ ______
//
//              SYSTEM
//
//
.pragma library
// Includes
.import "Http.js" as HttpHelper
.import "formideShared.js" as Formide


// Exposure
function system(){
    return{
        getRegistrationCode:function(callback){return getRegistrationCode(callback)},
        info:function(callback){return info(callback);}
    }
}

// Native Implementation
// Tip: If error = 404, Make sure there is internet connection
function getRegistrationCode(callback)
{
    HttpHelper.doHttpRequest("GET","/api/system/cloud/code",{},function(err,response){
        if(err)
        {
            console.log("Error registraton token",JSON.stringify(err));
            if(callback)
                callback(err,null);
        }
        if(response)
        {
            console.log("Response registration token",JSON.stringify(response));
            if(callback)
                callback(null,response);
        }

    });
}


// Tip for callback: currentClientVersion=callback.version;
function info(callback){
    HttpHelper.doHttpRequest("GET", "/api/system/info", JSON.stringify({}), function (err, response) {

        if(err)
        {
            callback(err,null)
        }
        if(response)
        {
            callback(null,response);
        }

    })
}
