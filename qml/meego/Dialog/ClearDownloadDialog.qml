// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "../../JavaScript/main.js" as Script
QueryDialog{
    id: root;
    acceptButtonText: qsTr("Yes");
    rejectButtonText: qsTr("Cancle");
    content: Text{
        text: qsTr("Clear all the task?");
        anchors.left: parent.left;
        anchors.leftMargin: 20;
    }

    onAccepted: {
        downloadmodel.clear();
    }
}
