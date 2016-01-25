// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1

Rectangle{
    id:root;
    //height: screen.displayHeight;
    height: 854;
    //width: screen.displayWidth;
    width: 480;
    color: "#000000";
    Column{
        anchors{
            left: parent.left;
            leftMargin: 27;
            bottom: parent.bottom;
            bottomMargin: 133;
        }
        Text {
            text: "Welcome to";
            color: "#FFFFFF";
            font.pixelSize: 36;
        }
        Text{
            text: "9Store";
            color: "#1994FF";
            font.pixelSize: 36;
        }
    }

    Text{
        anchors.bottom: parent.bottom;
        anchors.left: parent.left;
        anchors.margins: 27;
        text: "9Smart";
        color: "#B4B4B4";
    }
    BusyIndicator{
        anchors.bottom: parent.bottom;
        anchors.right: parent.right;
        anchors.margins: 16;
    }
    Timer{
        interval: 2700;
        running: true;
        repeat: false;
        onTriggered: {
            root.visible = false;
            //statusbar.visible = true;
        }
    }
}
