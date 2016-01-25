// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "../../JavaScript/main.js" as Script
QueryDialog{
    id: root;
    acceptButtonText: qsTr("Yes");
    rejectButtonText: qsTr("Cancle");
    content: Text{
        text: qsTr("Are you sure you want to log out?");
        color: "white";
        font.pixelSize: 36;
        anchors.horizontalCenter: parent.horizontalCenter;
    }

    onAccepted: {
        user.clear();
        Script.savaUserData();
    }
}
