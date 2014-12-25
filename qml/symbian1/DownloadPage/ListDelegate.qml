import QtQuick 1.0
import com.nokia.symbian 1.1

Component {
    id:delegate;
    Item {
        property bool currenturl;
        property bool fileexist;
        id:wrapper;
        width: 360;
        height: 90;
        Image {
            id:sicon;
            anchors.left: parent.left;
            anchors.leftMargin: 15;
            anchors.verticalCenter: parent.verticalCenter;
            height: 60;
            width: 60;
            smooth: true;
            source: model.icon;
        }
        Text {
            id:name;
            anchors.top: sicon.top;
            anchors.left: sicon.right;
            anchors.leftMargin: 15;
            text: model.name;
            font.pixelSize: 22;
            color: constant.fontColorNormal;
        }
        ProgressBar {
            id:progress;
            anchors.top: name.bottom;
            anchors.topMargin: 15;
            width: 195;
            anchors.left: name.left;
        }
        /*Button {
            platformInverted: true;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.right: parent.right;
            anchors.rightMargin: 15;
            iconSource:privateStyle.toolBarIconPath("toolbar-delete");
        }*/
        Rectangle {
            anchors.left: parent.left;
            anchors.right: parent.right;
            anchors.bottom: parent.bottom;
            color: "LightGrey";
            height: 2;
        }
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if(progress.value===1)
                    fileoperate.openFile(model.file);
            }
        }
        Timer {
            interval: 500;
            running: true;
            repeat: true;
            triggeredOnStart: true;
            onTriggered: {
                currenturl = qcurl.iscurrenturl(model.url);
                fileexist = qcurl.isfileexist(model.file);
                if(currenturl === true) {
                    progress.value = qcurl.getprogress();
                }
                if((currenturl === false) && (fileexist === false)) {
                    progress.value = 0;
                }
                if((currenturl === false) && (fileexist === true)) {
                    progress.value = 1;
                    running = false;
                }
            }
        }
    }
}
