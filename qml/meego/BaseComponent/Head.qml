// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Image{
    property alias titleText:headtext.text;
    property alias shadowOpacity:shadow.opacity;
    anchors.top: parent.top;
    height: 72;
    width: parent.width;
    source: "../../pic/General/Headerbar.svg";
    Text{
        id:headtext;
        anchors{
            verticalCenter: parent.verticalCenter;
            left: parent.left;
            leftMargin: 20;
        }
        font.pixelSize: 37;
    }
    Image{
        id:shadow;
        anchors.top: parent.bottom;
        width: parent.width;
        source: "../../pic/General/HeadShadow.png";
        opacity: 0.75;
    }
}
