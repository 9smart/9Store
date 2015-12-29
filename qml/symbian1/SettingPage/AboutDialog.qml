import QtQuick 1.0
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "../Main"
import "../../JavaScript/main.js" as Script

CommonDialog {
    id:aboutdia;
    platformInverted: true;
    titleText: qsTr("About");
    buttonTexts: [qsTr("OK")];
    content: Flickable {
        anchors.left: parent.left;
        anchors.right: parent.right;
        //width:300;
        height:400;
        flickableDirection: Flickable.VerticalFlick;
        contentHeight: abouttext.height + 24;
        Text {
            id: abouttext;
            height: paintedHeight;
            anchors.right: parent.right;
            anchors.left: parent.left;
            anchors.top: parent.top;
            anchors.margins: 12;
            wrapMode: Text.WrapAnywhere;
            font.pixelSize: 15;// color: "White";
            text: qsTr("***About Texts***");
        }
    }
}
