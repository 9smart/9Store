// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "../Main"
Head{
    id:head;
    color: "DarkGrey";
    z:1;
    Image{
        id:icon;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left;
        anchors.leftMargin: 20;
        height: 45;
        width: 45;
        source: "../../pic/9-MeeGo.png";
    }
    Text{
        text: qsTr("9smart");
        font.pixelSize: 32;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: icon.right;
        anchors.rightMargin: 20;
    }
    Text{
        anchors.verticalCenter: parent.verticalCenter;
        anchors.right: typemenukey.left;
        text:{
            if(type==="app") {
                return qsTr("app");
            }
            if(type==="game") {
                return qsTr("game");
            }
            else return qsTr("all");
        }
        font.pixelSize: 32;
    }
    ToolIcon{
        id:typemenukey;
        iconId: "toolbar-down";
        anchors.right: parent.right;
        anchors.verticalCenter: parent.verticalCenter
        onClicked:typeSelect.open();
    }
}
