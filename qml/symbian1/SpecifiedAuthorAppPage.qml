import QtQuick 1.0
import com.nokia.symbian 1.1
import "../JavaScript/main.js" as Script
import "Main"
import "SpecifiedAuthorAppPage"

MyPage {
    id:relatedappspage;
    property int page:1;
    property bool firstStart: true;
    onVisibleChanged: if (visible && firstStart) {
                          firstStart = false
                          Script.getlist("s60v5",page.toString(),"15","","",title,"","","appname,author,appid,icon,summary,version,scores,ratingnum");
                      }
    title: qsTr("Related apps");
    tools: ToolBarLayout{
        ToolButton{
            iconSource: privateStyle.toolBarIconPath("toolbar-back");
            //platformInverted: true;
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
            anchors.leftMargin: 12;
            height: 42;
            width: 42;
            smooth: true;
            source: "Resource/icon.svg";
        }
        Text{
            text: title;
            font.pixelSize: 24;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: icon.right;
            anchors.leftMargin: 9;
        }
    }
    ListView{
        id:listview;
        anchors.fill:parent;
        anchors.topMargin: head.height;
        model: ListModel{ id:listmodel; }
        delegate:ListDelegate{ id:listdelegate; }
        footer: ListFooter{}
    }
    Component.onCompleted:{
        Script.listmodel=listmodel;
    }
}
