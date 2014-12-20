// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle{
    id:searchfiled;
    property alias text:searchtext.text;
    property alias deafaltText:deafalttext.text;
    width: parent.width;
    height: 45;
    color: "#fcfcfc";
    TextInput{
        id:searchtext;
        font.pixelSize: 21
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left;
        anchors.leftMargin: 12;
        anchors.right: parent.right;
    }
    Text{
        id:deafalttext;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left;
        anchors.leftMargin: 12;
        color: "lightgray";
        visible: !searchtext.focus;
        text: qsTr("Search for files...");
        font.pixelSize: 21
    }
    Rectangle{
        width: parent.width;
        height: 4;
        anchors.bottom: parent.bottom;
        gradient: Gradient{
            GradientStop{
                position: 1.0;
                color: "#eeeeee";
            }
            GradientStop{
                position: 0.0;
                color: "#fcfcfc";
            }
        }
    }
    Rectangle{
        id:topfocus;
        anchors{
            left:parent.left;
            right: parent.right;
            top:parent.top;
        }
        height: 1;
        visible: searchtext.focus;
        color: "#1080dd";
    }
    Rectangle{
        anchors{
            left: parent.left;
            right: parent.right;
            top:topfocus.bottom;
        }
        height: 1;
        visible: searchtext.focus;
        color: "#1080dd";
        opacity: 0.5;
    }
    Rectangle{
        id:bottomfocus;
        anchors{
            left:parent.left;
            right: parent.right;
            bottom:parent.bottom;
        }
        height: 1;
        visible: searchtext.focus;
        color: "#1080dd";
    }
    Rectangle{
        anchors{
            left: parent.left;
            right: parent.right;
            bottom: bottomfocus.top;
        }
        height: 1;
        visible: searchtext.focus;
        color: "#1080dd";
        opacity: 0.5;
    }
    Rectangle{
        anchors{
            top:parent.top;
            bottom: parent.bottom;
            left: parent.left;
        }
        width: 1;
        color: "#1080dd";
        opacity: 0.5;
        visible: searchtext.focus;
    }
    Rectangle{
        anchors{
            top:parent.top;
            bottom: parent.bottom;
            right: parent.right;
        }
        width: 1;
        color: "#1080dd";
        opacity: 0.5;
        visible: searchtext.focus;
    }
}
