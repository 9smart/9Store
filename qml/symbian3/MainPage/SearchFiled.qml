// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Image{
    id:searchfiled;
    property alias text:searchtext.text;
    property alias deafaltText:deafalttext.text;
    signal clicked;
    width: parent.width;
    height: 45;
    source: "../../pic/Library/Search_Input_Background.svg"
    TextInput{
        id:searchtext;
        font.pixelSize: 21
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left;
        anchors.leftMargin: 12;
        anchors.right:searchbutton.left;
    }
    Image{
        id:searchbutton
        anchors.verticalCenter: parent.verticalCenter;
        anchors.right: parent.right;
        anchors.rightMargin: 10;
        source: "../../pic/Library/Search_Input_Search.svg"
        MouseArea{
            anchors.fill: parent;
            onClicked: searchfiled.clicked();
        }
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
    Image{
        id:shadow;
        anchors.top: parent.top;
        source: "../../pic/General/HeadShadow.png"
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
