import QtQuick 1.0
import "../Main"

Head {
    id:head;
    z:1;
    Image {
        id:sicon;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left;
        anchors.leftMargin: 12;
        height: 36;
        width: 36;
        source: icon;
    }
    Text {
        text: title;
        font.pixelSize: 24;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: sicon.right;
        anchors.leftMargin: 12;
    }
}
