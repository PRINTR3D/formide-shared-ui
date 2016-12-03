//            _    _ _______ _    _
//       /\  | |  | |__   __| |  | |
//      /  \ | |  | |  | |  | |__| |
//     / /\ \| |  | |  | |  |  __  |
//    / ____ | |__| |  | |  | |  | |
//   /_/    \_\____/   |_|  |_|  |_|
//
//

.pragma library
// Includes
.import "Http.js" as HttpHelper
.import "formide.js" as Formide

var accessToken = '';

// call http login
function login (username, password, callback) {
    // only request new access token when not set yet
    if (accessToken === '') {

        var credentials = {
            "email": username,
            "password": password
        }
        console.log("Requesting login")
        HttpHelper.doHttpRequest("POST", "/api/auth/login", JSON.stringify(credentials), function (err, response) {
            // set access token

            if(err)
                console.log("ERROR LOGIN: ",err);

            if(response)
            {
                accessToken = JSON.parse(response).access_token;
                HttpHelper.updateAccessToken(accessToken);
                console.log("recv bearer: "+accessToken)
                callback(true)
            }
        });
    }
}

// get access token
function getAccessToken() {
    return accessToken;
}
