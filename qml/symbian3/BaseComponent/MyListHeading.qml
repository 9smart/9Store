// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    property alias text:headingtext.text;
    //width: screen.width;
    width: 360;
    height: 25;
    color: "#B4B4B4";
    Rectangle{
        anchors.bottom: parent.bottom;
        width: parent.width;
        height: 1;
        color: "#000000";
        opacity: 0.1;
    }
    Text{
        id:headingtext;
        anchors.left: parent.left;
        anchors.leftMargin: 15;
        anchors.verticalCenter: parent.verticalCenter;
        font.pixelSize: 24;
        color: "#3c3c3c";
    }
}
