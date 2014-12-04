import QtQuick 1.1
import com.nokia.meego 1.1
import "../JavaScript/main.js" as Script
import "Main"
import "DownloadPage"
MyPage{
    id:downloadpage;
    tools: ToolBarLayout{
        ToolIcon{
            platformIconId: "toolbar-back";
            onClicked: pageStack.pop();
        }
        ToolIcon{
            platformIconId: "toolbar-delete";
            enabled: !emptyLabel.visible;
            onClicked: downloadmodel.clear();
        }
    }

    Head{
        id:head;
        z:1;
        Image{
            id:icon;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: parent.left;
            anchors.leftMargin: 15;
            height: 45;
            width: 45;
            source: "../pic/9-MeeGo.png"
        }
        Text{
            text: qsTr("Download list");
            font.pixelSize: 32;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: icon.right;
            anchors.rightMargin: 15;
        }
    }
    Text{
        id: emptyLabel;
        text: qsTr("The download list is empty");
        color: "Grey";
        anchors.centerIn: parent;
        font.pixelSize: 30;
    }
    ListView{
        id:listview;
        anchors.top: head.bottom;
        anchors.topMargin: 5;
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.bottom: parent.bottom;
        model: downloadmodel;
        delegate:DownloadListDelegate{id:dlistdele}
    }
    Component.onCompleted:listview.count===0?emptyLabel.visible=true:emptyLabel.visible=false;
}
