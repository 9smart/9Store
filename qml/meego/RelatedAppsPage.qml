// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "../JavaScript/main.js" as Script
import "Main"
import "RelatedAppsPage"
MyPage{
    id:relatedappspage;
    property string appid;
    property string category;
    property int page:1;
    property bool firstStart: true;
    onVisibleChanged: if (visible && firstStart) {
                          firstStart = false
                          Script.getrelatedlist("meego",page.toString(),"15",appid,category);
                      }
    title: qsTr("Related apps");
    tools: ToolBarLayout{
        ToolIcon{
            platformIconId: "toolbar-back";
            onClicked: pageStack.pop();
        }
    }
    Head{
        id:head;
        color: "DarkGrey";
        z:1;
        Image{
            id:icon;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: parent.left;
            anchors.leftMargin: 16;
            height: 56;
            width: 56;
            smooth: true;
            source: "../pic/9-Symbian.svg";
        }
        Text{
            text: title+qsTr("  Related apps");
            font.pixelSize: 32;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: icon.right;
            anchors.leftMargin: 1;
        }
    }
    ListView{
        id:listview;
        anchors.fill:parent;
        anchors.topMargin: head.height;
        model: ListModel{ id:relatedlistmodel; }
        delegate:ListDelegate{ id:listdelegate; }
        footer: ListFooter{}
    }
    Component.onCompleted:{
        Script.relatedlistmodel=relatedlistmodel;
    }
}
