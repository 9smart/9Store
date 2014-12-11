import QtQuick 1.0
import "Main"
import "DownloadPage"
import "../JavaScript/main.js" as Script
import com.nokia.symbian 1.1

MyPage {
    id:downloadpage;
    tools: ToolBarLayout {
        ToolButton {
            iconSource: privateStyle.toolBarIconPath("toolbar-back");
            onClicked: pageStack.pop();
            //platformInverted: true;
        }
        ToolButton {
            iconSource: privateStyle.toolBarIconPath("toolbar-delete");
            enabled: !emptyLabel.visible;
            //platformInverted: true;
            onClicked: {
                downloadmodel.clear();
                userdata.setUserData("DownloadData","{\"statuses\":[]}");
            }
        }
    }
    ListDelegate {
        id:dlistdele;
    }
    Head {
        id:head;
        z:1;
        Image {
            id:icon;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: parent.left;
            anchors.leftMargin: 15;
            height: 45;
            width: 45;
            source: "Resource/icon.svg";
        }
        Text {
            text: qsTr("Download list");
            font.pixelSize: 24;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: icon.right;
            anchors.rightMargin: 15;
        }
    }
    Text {
        id: emptyLabel;
        text: qsTr("The download list is empty");
        color: "Grey";
        anchors.centerIn: parent;
    }
    ListView {
        id:listview;
        anchors.top: head.bottom;
        anchors.topMargin: 5;
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.bottom: parent.bottom;
        model: downloadmodel;
        delegate:dlistdele;
    }
    Component.onCompleted:listview.count===0?emptyLabel.visible=true:emptyLabel.visible=false;
}
