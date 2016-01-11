// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "../../JavaScript/main.js" as Script
QueryDialog{
    id: root;
    property string id;
    property string name;
    property string icon;
    property int index;
    acceptButtonText: qsTr("Yes");
    rejectButtonText: qsTr("Cancle");
    content: Text{
        text: qsTr("Download again?");
        anchors.left: parent.left;
        anchors.leftMargin: 20;
    }
    onAccepted: {
        Script.getDownloadUrl(id, app.user.auth, name, icon, "symbian");
        downloadmodel.remove(index);
    }
    function openDia(id, name, icon, index){
        root.id = id;
        root.name = name;
        root.icon = icon;
        root.index = index;
        open();
    }
}
