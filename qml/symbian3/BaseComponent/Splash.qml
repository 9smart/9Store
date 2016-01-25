// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle{
    id:root;
    height: screen.height;
    width: screen.width;
    color: "#000000";
    Column{
        anchors{
            left: parent.left;
            leftMargin: 20;
            bottom: parent.bottom;
            bottomMargin: 96;
        }
        Text {
            text: "Welcome to";
            color: "#FFFFFF";
            font.pixelSize: 33;
        }
        Text{
            text: "9Store";
            color: "#1994FF";
            font.pixelSize: 33;
        }
    }

    Text{
        anchors.bottom: parent.bottom;
        anchors.left: parent.left;
        anchors.margins: 20;
        text: "9Smart";
        color: "#B4B4B4";
        font.pixelSize: 15;
    }
    BusyIndicator{
        anchors.bottom: parent.bottom;
        anchors.right: parent.right;
        anchors.margins: 12;
    }
    Timer{
        interval: 2700;
        running: true;
        repeat: false;
        onTriggered: {
            root.visible = false;
            statusBar.visible = true;
        }
    }
}
