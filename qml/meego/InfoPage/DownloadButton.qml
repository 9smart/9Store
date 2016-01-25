// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "../../JavaScript/main.js" as Script
Rectangle {
    //width: screen.displayWidth;
    width: 480;
    height: 93;
    color: "#f5f5f5";
    Text{
        anchors{
            verticalCenter: parent.verticalCenter;
            left: parent.left;
            leftMargin: 27;
        }
        font.bold: true;
        font.pixelSize: 28;
        color: "gray";
        text: qsTr("FREE");
    }
    Button{
        //platformInverted: true;
        platformStyle: ButtonStyle{
            inverted: false;
        }

        anchors{
            verticalCenter: parent.verticalCenter;
            right: parent.right;
            rightMargin: 7;
        }
        //checked: true;
        width: 200;
        text: qsTr("Download");
        onClicked: {
            if(user.userState){
                //Script.getDownloadUrl(_id, user.auth, title, icon, "symbian");
                Script.getDownloadUrl(_id, user.auth, title, icon);
            }
            else{
                signalCenter.showMessage(qsTr("Please login"));
            }
        }
    }
    Image{
        anchors.top: parent.bottom;
        source: "../../pic/General/HeadShadow.png";
        width: parent.width;
        opacity: 0.75
    }
}
