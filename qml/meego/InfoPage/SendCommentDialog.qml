// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "../Main"
import "../../JavaScript/main.js" as Script
import "../../JavaScript/des.js" as Des
Dialog{
    id:root;
    title: Text{
        text:qsTr("pleas input the comment");
        color:"white";
        font.pixelSize: 30;
        anchors.horizontalCenter:parent.horizontalCenter;
    }
    content: Column{
        id:content;
        anchors.left: parent.left;
        anchors.right: parent.right;
        height: 200;
        spacing: 12;
        RankStars{
            id:rankstars;
            anchors.left: parent.left;
            anchors.leftMargin: 18;
            size: 48;
            optional: true;
        }
        TextField{
            id:comments
            anchors.left: parent.left;
            anchors.right: parent.right;
            //anchors.margins: 18;
        }
    }
    buttons: ButtonRow{
        width:300;
        anchors.horizontalCenter:parent.horizontalCenter;
        Button{
            text: qsTr("Send");
            onClicked:{
                Script.sendComment(appid,utility.base64(Des.des(app.uid+","+app.accesstoken+","+app.logintype)),comments.text,rankstars.ranknum);
                root.close();
            }
        }
        Button{
            text: qsTr("Cancel");
            onClicked: root.close();
        }
    }
}
