// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../../JavaScript/main.js" as Script
import "../BaseComponent"
import "../Delegate"
Item{
    id:root;
    property string order: "";
    width: screen.width;
    TopChartsButtons{
        id:topchartsbuttons;
        z:1;
        onNewestClicked: {
            order="";
            Script.listPage = "";
            Script.getlist("Symbian%5e3", "", "", Script.listPage,"12",order);
        }
        onMostPopClicked: {
            order="comment_num";
            Script.listPage = "";
            Script.getlist("Symbian%5e3", "", "", Script.listPage,"12",order);
        }
        onMostDlClicked: {
            order="download_num";
            Script.listPage = "";
            Script.getlist("Symbian%5e3", "", "", Script.listPage,"12",order);
        }
    }
    ListView{
        id:mainview;
        width: screen.width;
        anchors.top: topchartsbuttons.bottom;
        anchors.bottom: parent.bottom;
        model: listmodel;
        clip: true;
        delegate: ListComponent{}
        footer: ListFooter{
            visible: listmodel.count > 0;
            onClicked: {
                //page = Script.page;
                if(Script.listPage !== "NULL"){
                    Script.getlist("Symbian%5e3", "", "", Script.listPage,"12",order);
                }
                else{
                    signalCenter.showMessage(qsTr("No next page aviliable..."))
                }
            }
        }
    }
    Component.onCompleted: {
        if(listmodel.count===0){
            Script.listPage = "";
            Script.getlist("Symbian%5e3", "", "", Script.listPage,"12",order);
        }
    }
    NumberAnimation on opacity {
        from: 0;
        to:1;
        duration: 300;
    }
}
