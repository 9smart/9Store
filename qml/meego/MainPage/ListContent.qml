// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../../JavaScript/main.js" as Script
import "../BaseComponent"
import "../Delegate"
ListView{
    width: screen.displayWidth;
    height: 607;
    contentHeight: listmodel.count * 107;
    model: listmodel;
    clip: true;
    delegate: ListComponent{}
    footer: ListFooter{
        onClicked: {
            if(Script.listPage !== "NULL"){
                Script.getlist("MeeGo", root.category, "", Script.listPage,"12","");
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
