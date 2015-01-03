// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
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
        }
        /*Image{
            anchors.verticalCenter: parent.verticalCenter;
            anchors.right: parent.right;
            anchors.rightMargin: 15;
            source: ""
        }*/
    }
    ListView{
        width: screen.width;
        height: applicationmodel.count*80;
        interactive: false;
        model: applicationmodel;
        delegate: ListComponent{}
    }
    MyListItem{
        height: 60;
        Text{
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: parent.left;
            anchors.leftMargin: 15;
            text: qsTr("Games");
            color: "#3c3c3c";
        }
        /*Image{
            anchors.verticalCenter: parent.verticalCenter;
            anchors.right: parent.right;
            anchors.rightMargin: 15;
            source: ""
        }*/
    }
    ListView{
        width: screen.width;
        height: gamemodel.count*80;
        interactive: false;
        model: gamemodel;
        delegate: ListComponent{}
    }
}
