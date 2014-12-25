import QtQuick 1.0
import com.nokia.symbian 1.1
import "../Main"

Head {
    id:head;
    color: "DarkGrey";
    z:1;
    Image {
        id:icon;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left;
        anchors.leftMargin: 12;
        height: 42;
        width: 42;
        smooth: true;
        source: "../Resource/icon.svg";
    }
    Text {
        text: qsTr("9smart");
        font.pixelSize: 24;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: icon.right;
        anchors.leftMargin: 9;
    }
    Text {
        anchors.verticalCenter: parent.verticalCenter;
        anchors.right: typemenukey.left;
        text: {
            if(type==="app") {
                return qsTr("app");
            }
            if(type==="game") {
                return qsTr("game");
            } else
                return qsTr("all");
        }
        font.pixelSize: 24;
    }
    ToolButton {
        id:typemenukey;
        platformInverted: true;
        iconSource: "../Resource/selector.svg";
        anchors.right: parent.right;
        anchors.verticalCenter: parent.verticalCenter
        onClicked:typeSelect.open();
    }
}
