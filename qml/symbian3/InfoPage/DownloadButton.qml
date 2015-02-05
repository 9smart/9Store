// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
Rectangle {
    width: screen.width;
    height: 70;
    color: "#f5f5f5";
    Text{
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left;
        anchors.leftMargin: 20;
        font.bold: true;
        font.pixelSize: 21;
        color: "gray";
        text: qsTr("FREE");
    }
    Button{
        platformInverted: true;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.right: parent.right;
        anchors.rightMargin: 5;
        //checked: true;
        text: qsTr("Download");
    }
    Image{
        anchors.top: parent.bottom;
        source: "../../pic/General/HeadShadow.png";
        opacity: 0.75
    }
}
