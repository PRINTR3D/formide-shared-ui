.pragma library
.import "formideShared.js" as FormideShared

Qt.include("socketParser.js");

// vars
var baseUrl = 'http://'+FormideShared.backendIP+':1337';

var accessToken = '';
var globalPort;

// Do an http request
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

            var responseCode = xhr.status;
            //console.log("STATUS HTTP REQUEST: "+responseCode)


            if (responseCode !== 200)
            {

                try
                {
                    var responseFromClient = JSON.parse(response)
                    console.log("Error response:",response)
                    return callback(responseFromClient,null);
                }

                catch(e)
                {
                    var errorResponse =
                        {
                            "message":"Internal error."
                        }
                    return callback(errorResponse,null);
                }

            }

            else if (callback)
            {
                callback(null, JSON.parse(response));
            }
        }
    }

    // perform http request
    if (method === "GET") {
        xhr.send();
    }
    else {
            xhr.setRequestHeader("Content-type", "application/json");
            xhr.setRequestHeader("Content-length", data.length);
             xhr.send(data);
    }
}

function updateAccessToken(token)
{
    accessToken = token;
}
