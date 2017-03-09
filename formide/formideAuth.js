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
.import "formideShared.js" as Formide
// Includes


var accesstoken="";

function auth()
{

    return{
        // call http login

        accesstoken:accesstoken,
        login:function (username, password, callback) {
            // only request new access token when not set yet
            if (accesstoken === '') {

                var credentials = {
                    "username": username,
                    "password": password
                }
                console.log("Requesting login")
                HttpHelper.doHttpRequest("POST", "/api/auth/login", JSON.stringify(credentials), function (err, response) {
                    // set access token

                    if(err)
                        console.log("Error login: ",JSON.stringify(err));

                    if(response)
                    {
                        accesstoken = response.token;
                        Formide.accessToken=accesstoken;
                        HttpHelper.updateAccessToken(accesstoken);
                        console.log("recv bearer: "+accesstoken)
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
