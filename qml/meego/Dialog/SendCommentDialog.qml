// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import "../BaseComponent"
import "../../JavaScript/main.js" as Script
import "../../JavaScript/des.js" as Des

Dialog{
    id:root;
    //titleText: qsTr("Review");
    //buttonTexts: [qsTr("Send"),qsTr("Cancle")];
    content: Column{
        anchors.left: parent.left;
        anchors.right: parent.right;
        spacing: 16;
        RankStars{
            id:rankstars;
            anchors.left: parent.left;
            anchors.leftMargin: 24;
            size: 44;
            optional: true;
        }
        TextField{
            id:comments
            //platformInverted: true;
            anchors{
                left: parent.left;
                right: parent.right;
                margins: 24;
            }
        }
    }
    /*onButtonClicked: {
        if(index===0) {
            Script.sendComment(user.auth, _id, "app", comments.text, rankstars.ranknum, app.deviceModel);
        }
    }*/
}
