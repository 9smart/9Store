// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../Main"
Head{
    id:head;
    z:1;
    Image{
        id:icon;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left;
        anchors.leftMargin: 20;
        height: 60;
        width: 60;
        smooth: true;
        source: "../../pic/9-MeeGo.png"
    }
    Text{
        text: qsTr("Settings");
        font.pixelSize: 32;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: icon.right;
        anchors.rightMargin: 20;
    }
}
