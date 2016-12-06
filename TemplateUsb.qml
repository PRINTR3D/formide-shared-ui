import QtQuick 2.0

import "formide/formide.js" as Formide


Item {

    width:parent.width
    height:parent.height

    Component.onCompleted:
    {

        console.log(" TESTING ALL DATABASE ENDPOINTS")


        Formide.database().getFiles();
        Formide.database().images();
        Formide.database().getPrintJobs();
        Formide.database().removeFile();
        Formide.database().removePrintJob();
        Formide.database().removeQueueItem();
        Formide.database().materials();
        Formide.database().sliceprofiles();
        Formide.database().getPrinters();

    }

}
