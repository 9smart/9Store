// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Rectangle{
    id:root;
    signal clicked;
    property bool highlight:false;
    property alias enabled:mousearea.enabled;
    //width: screen.displayWidth;
    width: 480;
    height: 80;
    color: "#f5f5f5";    
    Rectangle{
        anchors.top: parent.top;
        width: parent.width;
        height: 1;
        color: "#ffffff";
        opacity: 0.75;
    }
    Rectangle{
        anchors.bottom: parent.bottom;
        width: parent.width;
        height: 1;
        color: "#000000";
        opacity: 0.1;
    }
    Rectangle{
        anchors.fill: parent;
        color: "#787878";
        opacity: 0.2;
        visible: mousearea.pressed;
    }
    Rectangle{
        anchors.left: parent.left;
        height: parent.height;
        width: 5;
        color: "#1080dd";
        visible: highlight;
    }
    Image{
        anchors.top: parent.bottom;
        source: "../../pic/General/HeadShadow.png";
        opacity: 0.1;
    }

    MouseArea{
        id:mousearea;
        anchors.fill: parent;
        onClicked: root.clicked();
    }
}
