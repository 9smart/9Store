import QtQuick 1.1
Rectangle{
    width: screen.displayWidth;
    //width: 360;
    height: 73;
    color: "#f5f5f5";
    Rectangle{
        anchors.bottom: parent.bottom;
        width: parent.width;
        height: 1;
        color: "#ffffff";
        opacity: 0.75;
    }
    Rectangle{
        anchors{
            bottom: parent.bottom;
            bottomMargin: 1;
            topMargin: 1;
        }
        width: parent.width;
        height: 1;
        color: "#000000";
        opacity: 0.1;
    }
    Text{
        anchors{
            verticalCenter: parent.verticalCenter;
            left: parent.left;
            leftMargin: 20;
        }
        font.pixelSize: 36;
        text: title;
    }
}
