//     _____ _      _____ _____ ______ _____
//    / ____| |    |_   _/ ____|  ____|  __ \
//   | (___ | |      | || |    | |__  | |__) |
//    \___ \| |      | || |    |  __| |  _  /
//    ____) | |____ _| || |____| |____| | \ \
//   |_____/|______|_____\_____|______|_|  \_\
//
//

.pragma library
// Includes
.import "Http.js" as HttpHelper
.import "formideShared.js" as Formide


/*************
 NATIVE IMPLEMENTATION
 ************/
// slice request


// TIP for implementation
/*
var modelfile= modelFileSelected
var sliceprofile = sliceProfiles[qualitySelected].id
var material = materials[materialSelected].id
var printer = uniquePrinter.id
*/

function slice(modelfiles, sliceprofile, materials, override, printer, callback) {

    var payload =
            {
            "files": [modelfiles],
            "sliceProfile": sliceprofile,
            "materials":[materials, materials],
            "printer":printer,
            "settings": override
            }

    //console.log("Sending slice request",JSON.stringify(payload))
    HttpHelper.doHttpRequest("POST", "/api/slicer/slice", JSON.stringify(payload) , function (err, response) {

        if(err)
        {
            if(callback)
                callback(err,null)

        }
       if(response)
       {
           if(callback)
               callback(null,response)
       }

    });

}
