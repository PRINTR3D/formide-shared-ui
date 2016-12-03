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
.import "formide.js" as Formide


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

function slice(modelfiles, sliceprofile, materials, printer/*, settings*/, callback) {

    var payload =
            {
            "files": [modelfiles],
            "sliceProfile": sliceprofile,
            "materials":[materials, materials],
            "printer":printer,
            "settings": {
                  "brim": {
                      "use": false
                  },
                  "raft": {
                      "use": false
                  },
                  "bed": {
                      "use": true,
                      "temperature":45,
                      "firstLayersTemperature":45
                  },
                  "support": {
                      "use": false
                  },
                  "skirt": {
                      "use": true,
                      "extruder": 0
                  },
                  "fan": {
                      "use": true,
                      "speed": 100
                  },
                  "override": {
                  },
                  "files": [
                      {
                          "id": 1,
                          "extruder": 0,
                          "position": {
                              "x": 0,
                              "y": 0,
                              "z": 0
                          },
                          "rotation": {
                              "x": 0,
                              "y": 0,
                              "z": 0
                          },
                          "scale": {
                              "x": 1,
                              "y": 1,
                              "z": 1
                          }
                      }
                  ]
              }
            }

    //console.log("Sending slice request",JSON.stringify(payload))
    HttpHelper.doHttpRequest("POST", "/api/slicer/slice", JSON.stringify(payload) , function (err, response) {

        if(err)
        {
            console.log("Error Slicer",err);
            Formide.slicerError=err.message

            if(callback)
                callback(err,null)

            // TIP for callback implementation
            /*
            if(pagestack.depth>1)
                pagestack.pop()
            pagestack.push(Qt.resolvedUrl("ErrorSlicer.qml"));
            */

        }
       if(response)
       {
           // Tip for implementation:
           // Slicer response gives back print job ID: response.printJob.id

           if(callback)
               callback(null,response)
       }

    });

}
