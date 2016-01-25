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
            //platformInverted: true;
            width: 400;
        }
        Button{
            text: qsTr("Send");
            anchors.horizontalCenter: parent.horizontalCenter;
            onClicked: {
                Script.sendComment(user.auth, _id, "app", comments.text, rankstars.ranknum, app.deviceModel);
                close();
            }
        }
        /*Button{
            text: qsTr("Cancle");
            anchors.horizontalCenter: parent.horizontalCenter;
            onClicked: close();
        }*/
    }
    /*onButtonClicked: {
        if(index===0) {
            Script.sendComment(user.auth, _id, "app", comments.text, rankstars.ranknum, app.deviceModel);
        }
    }*/
}
