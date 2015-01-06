// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../../JavaScript/main.js" as Script
import "../BaseComponent"
import "../Delegate"
Column{
    MyListItem{
        height: 60;
        Text{
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: parent.left;
            anchors.leftMargin: 15;
            text: qsTr("Applications");
            color: "#3c3c3c";
            font.pixelSize: 24;
        }
        Image{
            anchors.verticalCenter: parent.verticalCenter;
            anchors.right: parent.right;
            anchors.rightMargin: 15;
            height: 25;
            width: 25;
            source: "../../pic/General/icon-m-toolbar-next.png";
        }
        onClicked: {
            categorymodel.clear();
            Script.getcategory("app");
            root.currentContent="CategoryContent.qml";
        }
    }
    ListView{
        width: screen.width;
        height: applicationmodel.count*80;
        interactive: false;
        model: applicationmodel;
        delegate: ListComponent{}
        onHeightChanged: console.log(height);
    }
    MyListItem{
        height: 60;
        Text{
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: parent.left;
            anchors.leftMargin: 15;
            text: qsTr("Games");
            color: "#3c3c3c";
            font.pixelSize: 24;
        }
        Image{
            anchors.verticalCenter: parent.verticalCenter;
            anchors.right: parent.right;
            anchors.rightMargin: 15;
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
    ListView{
        width: screen.width;
        height: gamemodel.count*80;
        interactive: false;
        model: gamemodel;
        delegate: ListComponent{}
    }
}
