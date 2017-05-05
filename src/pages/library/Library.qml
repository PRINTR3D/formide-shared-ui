import QtQuick 2.0
import "../../utils"
import "../../../lib/formide/formideShared.js" as FormideShared

Item {

    id: mainLibrary
    height: parent.height
    width: parent.width

    FileList {

        id: list
        listModel: main.fileItems
        type: "library"

        onItemSelected: {
            FormideShared.fileIndexSelected = indexSelected
            expanded = true
            status = "expanded"
            expandedMenuSize = 216
        }

        function getImage(index) {
//            if(listModel[index].filetype==="text/gcode")
//            {
            return "../Images/icons/gcodeIcon.png"
//            }
//            if(listModel[index].filetype==="text/stl")
//            {
//                if(listModel[index].id)
//                {
//                    if(listModel[index].images[0])
//                    {
//                        var url = main.getImage(listModel[index].id, listModel[index].images[0] );
//                        return url;
//                    }
//                    else
//                    {
//                        console.log("listModel["+index+"].images[0] is UNDEFINED")
//                    }
//                }
//                else
//                {
//                    console.log("listModel["+index+"].id is UNDEFINED")
//                }
//            }
//            return "../Images/icons/noIcon.png"
        }

        LibraryItemExpanded {
            visible: list.status === "expanded"

            onFileClicked: {
                list.status = "list"
                list.expanded = !list.expanded
            }
            onPrintFile: {

                console.log("Printing file: " + list.listModel[fileIndexSelected].path)

                pagestack.pushPagestack(Qt.resolvedUrl("Printing.qml"))
                main.startPrintFromFileSystem(
                            list.listModel[fileIndexSelected].path,
                            function (err, response) {
                                if (err) {
                                    console.log("File could not be printed",
                                                JSON.stringify(err))
                                    pagestack.pushPagestack(
                                                Qt.resolvedUrl(
                                                    "PrintingError.qml"))
                                }
                                if (response) {
                                    console.log("Print file success",
                                                JSON.stringify(response))
                                    pagestack.popPagestack()
                                    main.viewStackActivePage = "Dashboard"
                                }
                            })
            }

            onDeleteFile: {

                main.removeFile(list.listModel[fileIndexSelected].path)
                list.status = "list"
                list.expanded = !list.expanded
            }
        }
    }
}
