// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Row{
    id:root;
    property int highlightItem:1;
    signal newestClicked;
    signal mostPopClicked;
    signal mostDlClicked;
    Rectangle{
        width: 118;
        height: 45;
        color: highlightItem==1?"#dadada":"#ececec";
        Text{
            anchors.centerIn: parent;
            text: qsTr("Newest");
            font.pixelSize: 21
        }
        MouseArea{
            anchors.fill: parent;
            onClicked: {
                root.highlightItem=1;
                root.newestClicked();
            }
        }
    }
    Rectangle{
        width: 3;
        height: 45;
        color: "#dbdbdb";
    }
    Rectangle{
        width: 118;
        height: 45;
        color: highlightItem==2?"#dadada":"#ececec";
        Text{
            anchors.centerIn: parent;
            text: qsTr("Most pop");
            font.pixelSize: 21
        }
        MouseArea{
            anchors.fill: parent;
            onClicked: {
                root.highlightItem=2;
                root.mostPopClicked();
            }
        }
    }
    Rectangle{
        width: 3;
        height: 45;
        color: "#dbdbdb";
    }
    Rectangle{
        width: 118;
        height: 45;
        color: highlightItem==3?"#dadada":"#ececec";
        Text{
            anchors.centerIn: parent;
            text: qsTr("Most dl");
            font.pixelSize: 21
        }
        MouseArea{
            anchors.fill: parent;
            onClicked: {
                root.highlightItem=3;
                root.mostDlClicked();
            }
        }
    }
}
