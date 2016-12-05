//            _    _ _______ _    _
//       /\  | |  | |__   __| |  | |
//      /  \ | |  | |  | |  | |__| |
//     / /\ \| |  | |  | |  |  __  |
//    / ____ | |__| |  | |  | |  | |
//   /_/    \_\____/   |_|  |_|  |_|
//
//

.pragma library
.import "Http.js" as HttpHelper
// Includes


var accesstoken='';

function auth()
{

    return{
        // call http login
        login:function (username, password, callback) {
            // only request new access token when not set yet
            if (accesstoken === '') {

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
                        accesstoken = JSON.parse(response).access_token;
                        HttpHelper.updateAccessToken(accessToken);
                        console.log("recv bearer: "+accessToken)
                        callback(true)
                    }
                });
            }
        },

        // get access token
        getAccessToken: function() {
            return accesstoken;
        }
    }
}
