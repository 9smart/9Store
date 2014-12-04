// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
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
            text: qsTr("Search");
            font.pixelSize: 32;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: icon.right;
            anchors.leftMargin: 12;
        }
    }
    Rectangle{
        id:searchitem;
        anchors.left: parent.left;
        anchors.right: parent.right;
        height: searchtext.height+16;
        anchors.top: head.bottom;
        color: "#F1F1F1";
        z:1;
        TextField{
            id:searchtext;
            placeholderText: qsTr("Please input the key")
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.verticalCenter: parent.verticalCenter;
            width: 440;
            z:1;
            ToolIcon{
                id:searchbutton;
                anchors{
                    top:parent.top;
                    right: parent.right;
                }
                smooth: true;
                iconId:"toolbar-search";
                height: parent.height;
                width: parent.height;
                onClicked:{
                    page=1;
                    Script.getlist("meego",page.toString(),"15","","","","",searchtext.text,"appname,author,appid,icon,summary,version,scores,ratingnum");
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
