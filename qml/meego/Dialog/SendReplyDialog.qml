// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "../BaseComponent"
import "../../JavaScript/main.js" as Script
import "../../JavaScript/des.js" as Des
Dialog{
    id:root;
    property string cid;
    property string target;
    //titleText: qsTr("Reply to ") + target;
    //buttonTexts: [qsTr("Send"),qsTr("Cancle")];
    content: Column{
        anchors.horizontalCenter: parent.horizontalCenter;
        spacing: 24;
        RankStars{
            id:rankstars;
            anchors.left: parent.left;
            size: 44;
            optional: true;
        }
        TextArea{
            id:comments
            text: "@" + target + ": ";
            width: 400;
        }
        Button{
            text: qsTr("Send");
            anchors.horizontalCenter: parent.horizontalCenter;
            onClicked: {
                Script.sendReply(user.auth, cid, comments.text, app.deviceModel);
                close();
            }
        }
    }
    function openDialog(cid, target){
        root.cid = cid;
        root.target = target;
        open();
    }
}
