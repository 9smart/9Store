// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Image{
    property alias titleText:headtext.text;
    property alias shadowOpacity:shadow.opacity;
    anchors.top: parent.top;
    Text{
        id:headtext;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left;
        anchors.leftMargin: 15;
        font.pixelSize: 28;
    }
    Image{
        id:shadow;
        anchors.top: parent.bottom;
        source: "../../pic/General/HeadShadow.png";
        opacity: 0.75;
    }
}
