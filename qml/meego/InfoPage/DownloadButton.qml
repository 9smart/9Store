// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
Rectangle {
    width: screen.width;
    height: 93;
    color: "#f5f5f5";
    Text{
        anchors{
            verticalCenter: parent.verticalCenter;
            left: parent.left;
            leftMargin: 27;
        }
        font.bold: true;
        font.pixelSize: 28;
        color: "gray";
        text: qsTr("FREE");
    }
    Button{
        //platformInverted: true;
        platformStyle: ButtonStyle{
            inverted: false;
        }

        anchors{
            verticalCenter: parent.verticalCenter;
            right: parent.right;
            rightMargin: 7;
        }
        //checked: true;
        text: qsTr("Download");
    }
    Image{
        anchors.top: parent.bottom;
        source: "../../pic/General/HeadShadow.png";
        opacity: 0.75
    }
}
