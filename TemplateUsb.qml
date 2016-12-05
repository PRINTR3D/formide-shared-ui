import QtQuick 2.0

import "formide/formide.js" as Formide
import "formide/formideUsb.js" as FormideUSB


Item {

    width:parent.width
    height:parent.height

    Component.onCompleted:
    {
        FormideUSB.copyFile(function(err,response){
            if(err)
            {
                console.log("Error USB: ",JSON.stringify(err));


                if(pagestack.depth>1)
                    pagestack.pop()
                main.pushPagestack("ErrorUsb.qml")
            }

            if(response)
            {
                if(pagestack.depth>1)
                    pagestack.pop();
                getFiles();

            }
        });
    }

}
