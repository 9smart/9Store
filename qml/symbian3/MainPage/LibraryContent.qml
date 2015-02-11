// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../../JavaScript/main.js" as Script
import "../BaseComponent"
import "../Delegate"
Flickable{
    width: screen.width;
    height: 455;
    contentHeight: 120+applicationlist.height+gamelist.height;
    clip: true;
    MyListItem{
        id:applicationbutton;
        height: 60;
        Text{
            anchors{
                verticalCenter: parent.verticalCenter;
                left: parent.left;
                leftMargin: 15;
            }
            text: qsTr("Applications");
            color: "#3c3c3c";
            font.pixelSize: 24;
        }
        Image{
            anchors{
                verticalCenter: parent.verticalCenter;
                right: parent.right;
                rightMargin: 15;
            }
            height: 25;
            width: 25;
            source: "../../pic/General/icon-m-toolbar-next.png";
        }
        onClicked: {
            categorymodel.clear();
            Script.getcategory("app");
            root.currentContent="CategoryContent.qml";
        }
        //Component.onCompleted: console.log("b:"+bottom)
    }
    Column{
        id:applicationlist;
        anchors.top: applicationbutton.bottom;
        width: screen.width;
        height: applicationrepeater.count*80;
        Repeater{
            id:applicationrepeater
            model: applicationmodel;
            delegate: ListComponent{}
        }
    }
    MyListItem{
        id:gamebutton;
        anchors.top: applicationlist.bottom;
        height: 60;
        Text{
            anchors{
                verticalCenter: parent.verticalCenter;
                left: parent.left;
                leftMargin: 15;
            }
            text: qsTr("Games");
            color: "#3c3c3c";
            font.pixelSize: 24;
        }
        Image{
            anchors{
                verticalCenter: parent.verticalCenter;
                right: parent.right;
                rightMargin: 15;
            }
            height: 25;
            width: 25;
            source: "../../pic/General/icon-m-toolbar-next.png";
        }
        onClicked: {
            categorymodel.clear();
            Script.getcategory("game");
            root.currentContent="CategoryContent.qml";
        }
    }
    Column{
        id:gamelist;
        anchors.top: gamebutton.bottom;
        width: screen.width;
        height: gamerepeater.count*80;
        Repeater{
            id:gamerepeater
            model: gamemodel;
            delegate: ListComponent{}
        }
    }
    NumberAnimation on opacity {
        from: 0;
        to:1;
        duration: 300;
    }
    NumberAnimation on x{
        from: 360;
        to:0;
        duration: 200;
    }
}
