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
    content: TextArea{
        id:comments
        anchors{
            top: parent.top;
            left: parent.left;
            right: parent.right;
            margins: 18;
        }
    }

    /*onButtonClicked: {
        if(index === 0)
            Script.sendReply(user.auth, cid, comments.text, app.deviceModel);
    }*/
    function openDialog(cid, target){
        root.cid = cid;
        root.target = target;
        open();
    }
}
