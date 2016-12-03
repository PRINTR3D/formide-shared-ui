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
.import "formide.js" as Formide


function checkUpdate(callback){

        if(callback)
        {
            console.log("Response check for updates:\n"+JSON.stringify(callback))

            if(callback.needsUpdate)
            {
                Formide.updateInformation=callback;
                Formide.updateAvailable=true
            }
            else
            {
                console.log("No update needed")
                Formide.updateAvailable=false;
            }
            //{"message":"There is no update available at this moment","needsUpdate":false}

            //{"message":"update found","needsUpdate":true,"signature":"D0S4ZyJ3eN4mp3K1dSwxCr/FzJS7uV7ekA9yf+yKnTvROp2tt3uhWYTo1V/dcOsJda0lSnC0pwwmULCBMqgRd5mxK5HYNMyQDCDYfwcO7MeN2idTnx/8lxe0WtK3brJ0RMKEtRdGkqKMxxV9Mj0pVJURYNGcygAP0oiQ57hdy8oBEUDE1yqLijZcEcPZoALZGfBujFxdaQiWdS1IaGQsD2m2crjQq5Kh7XyeDX3+Nzin3yLnLEFzb2yYlBy/HDtt69LnWF3Sv3Dpr88hodHYV1EVJ4vnYf6IPE/bRBAgvkAUx+ZcB8N8dkU3tb4alFpgTdaDC2tcMtEqDh1L9YExybjh4wvoTxN3RiHy1dg0U99qHSp5N+i9eP7uu9CkX8KlbfTSI6zreaYuBv62eyjqRDRqsiptW1IWYGDCEUSfvZpoeZNT7Kc1LsukMX3hcXffMnsmrrAK0XJDgfL8gk80PBS1/VcZrsddo7CEv7QtQntq5lbnKmDgGAqIUfUltqFsWxdTw0ngIweY0u8616yWzu0pyGZd3B0E2PDc3YrLNf348kcED8eO0TKsJ6twcB/vGfPZfkHjZ/ZQTOIf+gNAVh1MMOcOGZ+z0se9CHb+jHdbZz8JEnz9g/zLrekzSc5mU9rIQb9nIQe6SiBDGKfIv0tIiG/QAHqzTDj/KvW7nTM=","version":"1.3.6-387","flavour":"standalone"}
        }
}



/*************
 NATIVE IMPLEMENTATION
 ************/

// Tip for callback: Check update variables!
function check(callback) {

    console.log("Checking for updates")
    HttpHelper.doHttpRequest("GET", "/api/update/check", {}, function (err, response) {

        if(err)
        {
            console.log("Response ERR check updates ",err);
            callback(err,null);
        }
        if(response)
        {
            console.log("Response ",response)
            if(response.needsUpdate)
            {
                Formide.updateInformation=response;
                Formide.updateAvailable=true;
            }
            else
            {
                console.log("No update needed")
                Formide.updateAvailable=false;
            }

            callback(null,response);
        }

    })
}

function status(callback) {

    HttpHelper.doHttpRequest("GET", "/api/update/status", {}, function (err, response) {

        if(err)
        {
            console.log("Error cloud status",err);
            callback(err,null)
        }
        if(response)
        {
            console.log("Response cloud status",response);
            callback(response);
        }

    })
}

function UpdateElement(callback) {
    HttpHelper.doHttpRequest("POST", "/api/update/do", JSON.stringify({}), function (err, response) {

        if(err)
        {
            console.log("Error Update Element",err);
            callback(err,null)
        }
        if (response)
        {
//           console.log('Response Update Element', response)
           callback(response);
        }
    });
}

// Tip for callback: currentClientVersion=callback.version;
function current(callback){
    HttpHelper.doHttpRequest("GET", "/api/update/current", JSON.stringify({}), function (err, response) {

        if(err)
        {
            console.log("Error Cloud Current",err);
            callback(err,null)
        }
        if(response)
        {
            console.log("Response Cloud current",response)
            return callback(response);
        }

    })
}
