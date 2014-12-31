// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle{
    id:root;
    height: screen.height;
    width: screen.width;
    color: "#000000";
    Text{

    }

    BusyIndicator{
        anchors.bottom: parent.bottom;
        anchors.right: parent.right;
        anchors.margins: 15;
    }
    Timer{
        interval: 3000;
        running: true;
        repeat: false;
        onTriggered: root.visible=false;
    }
}
