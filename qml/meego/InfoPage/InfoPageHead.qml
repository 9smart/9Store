import QtQuick 1.1
import "../Main"
Head{
    id:head;
    z:1;
    Image{
        id:sicon;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left;
        anchors.leftMargin: 16;
        height: 45;
        width: 45;
        source: icon;
    }
    Text{
        text: title;
        font.pixelSize: 32;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: sicon.right;
        anchors.leftMargin: 16;
    }
}
