// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../../JavaScript/main.js" as Script
import "../BaseComponent"
import "../Delegate"
ListView{
    width: screen.width;
    height: 455;
    contentHeight: listmodel.count * 80;
    model: listmodel;
    clip: true;
    delegate: ListComponent{}
    footer: ListFooter{
        onClicked: {
            page = Script.page;
            if(page !== "NULL"){
                Script.getlist("Symbian%5e3", root.category, "", page,"12","");
            }
            else{
                signalCenter.showMessage(qsTr("No next page aviliable..."))
            }
        }

    }
    NumberAnimation on x{
        from: 360;
        to:0;
        duration: 200;
    }
}
