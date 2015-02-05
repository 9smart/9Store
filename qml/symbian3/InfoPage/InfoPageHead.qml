import QtQuick 1.1
Rectangle{
    width: screen.width;
    //width: 360;
    height: 55;
    color: "#f5f5f5";
    Rectangle{
        anchors.bottom: parent.bottom;
        width: parent.width;
        height: 1;
        color: "#ffffff";
        opacity: 0.75;
    }
    Rectangle{
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 1;
        anchors.topMargin: 1;
        width: parent.width;
        height: 1;
        color: "#000000";
        opacity: 0.1;
    }
    Text{
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left;
        anchors.leftMargin: 15;
        font.pixelSize: 27;
        text: title;
    }
}
