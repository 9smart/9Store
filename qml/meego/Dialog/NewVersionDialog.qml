// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "../../JavaScript/main.js" as Script
QueryDialog{
    id: root;
    acceptButtonText: qsTr("Yes");
    rejectButtonText: qsTr("Cancle");
    content: Text{
        text: qsTr("Find new version, download now?");
        anchors.left: parent.left;
        anchors.leftMargin: 20;
    }
    onAccepted: {
        Script.getDownloadUrl("567bf5897632d31254955cd8", app.user.auth, "9Store", "http://apps-images.9smart.cn/565060f95f9ad8de5a4e0674/i/567bf5897632d31254955cd8", "symbian");
    }
}
