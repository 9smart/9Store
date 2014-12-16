// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Rectangle{
    property alias titleText:headtext.text;
    width: parent.width;
    anchors.top: parent.top;
    height: 55;
    color: "#f6f6f6";
    Text{
        id:headtext;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left;
        anchors.leftMargin: 15;
    }
    Image{
        id:shadow;
        anchors.top: parent.bottom;
        source: "../../pic/HeadShadow.png"
    }
}
