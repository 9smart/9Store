// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../BaseComponent"
import "../../JavaScript/main.js" as Script
import "../../JavaScript/des.js" as Des
CommonDialog{
    id:root;
    platformInverted: true;
    titleText: qsTr("Review");
    buttonTexts: [qsTr("Send"),qsTr("Cancle")];
    content: Column{
        anchors.left: parent.left;
        anchors.right: parent.right;
        spacing: 12;
        RankStars{
            id:rankstars;
            anchors.left: parent.left;
            anchors.leftMargin: 18;
            size: 33;
            optional: true;
        }
        TextField{
            id:comments
            platformInverted: true;
            anchors{
                left: parent.left;
                right: parent.right;
                margins: 18;
            }
        }
    }
    onButtonClicked: {
        if(index===0) {
            Script.sendComment(appid,utility.base64(Des.des(app.uid+","+app.accesstoken+","+app.logintype)),comments.text,rankstars.ranknum)
        }
    }
}
