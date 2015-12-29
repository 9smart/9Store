import QtQuick 1.0
import com.nokia.symbian 1.1
import "../JavaScript/main.js" as Script
import "Main"
import "SearchPage"

MyPage{
    id:searchpage;
    property string key;
    property int page:1;
    property bool firstStart: true;
    onVisibleChanged: if (visible && firstStart) {
                          firstStart = false
                      }
    title: qsTr("Search");
    tools: ToolBarLayout{
        ToolButton{
            iconSource: privateStyle.toolBarIconPath("toolbar-back");
            platformInverted: true;
            onClicked: pageStack.pop();
        }
    }
    Head {
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
            text: qsTr("Search");
            font.pixelSize: 24;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: icon.right;
            anchors.leftMargin: 9;
        }
    }
    Rectangle{
        id:searchitem;
        anchors.left: parent.left;
        anchors.right: parent.right;
        height: searchtext.height+12;
        anchors.top: head.bottom;
        color: "White";
        z:1;
        TextField{
            id:searchtext;
            placeholderText: qsTr("Please input the key")
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.verticalCenter: parent.verticalCenter;
            width: 330;
            z:1;
            platformRightMargin: searchbutton.width + platformStyle.paddingMedium;
            ToolButton {
                id:searchbutton;
                anchors{
                    top:parent.top;
                    right: parent.right;
                }
                smooth: true;
                iconSource: privateStyle.toolBarIconPath("toolbar-search");
                height: parent.height;
                width: parent.height;
                MouseArea{
                    anchors.fill: parent;
                    onClicked:{
                        if (searchtext.text != "") {
                            page = 1;
                            Script.getlist("s60v5",page.toString(),"15","","","","",searchtext.text,"appname,author,appid,icon,summary,version,scores,ratingnum");
                        }
                    }
                }
            }
        }
    }
    ListView{
        id:listview;
        anchors.top: searchitem.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.bottom: parent.bottom;
        model: ListModel{ id:listmodel; }
        delegate:ListDelegate{ id:listpagedele; }
        footer: ListFooter{}
    }
    Component.onCompleted:{
        Script.listmodel=listmodel;
    }
}
