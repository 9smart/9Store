// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    property alias text:headingtext.text;
    width: screen.width;
    height: 25;
    color: "#B4B4B4";
    opacity: 0.5;
    Rectangle{
        anchors.bottom: parent.bottom;
        width: parent.width;
        height: 1;
        color: "#000000";
        opacity: 0.1;
    }
    Text{
        id:headingtext;
        anchors{
            left: parent.left;
            leftMargin: 15;
            verticalCenter: parent.verticalCenter;
            //verticalCenterOffset: -1;
        }
        font.pixelSize: 17;
        //color: "#3c3c3c";
        color: "#000000";
    }
}
