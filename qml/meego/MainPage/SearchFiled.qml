// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Image{
    id:searchfiled;
    property alias text:searchtext.text;
    property alias deafaltText:deafalttext.text;
    signal clicked;
    width: parent.displayWidth;
    height: 60;
    source: "../../pic/Library/Search_Input_Background.svg"
    TextInput{
        id:searchtext;
        font.pixelSize: 28
        anchors{
            verticalCenter: parent.verticalCenter;
            left: parent.left;
            leftMargin: 16;
            right:searchbutton.left;
        }
    }
    Image{
        id:searchbutton;
        anchors{
            verticalCenter: parent.verticalCenter;
            right: parent.right;
            rightMargin: 13;
        }
        source: "../../pic/Library/Search_Input_Search.svg"
        MouseArea{
            anchors.fill: parent;
            onClicked: searchfiled.clicked();
        }
    }
    Text{
        id:deafalttext;
        anchors{
            verticalCenter: parent.verticalCenter;
            left: parent.left;
            leftMargin: 16;
        }
        color: "lightgray";
        visible: !searchtext.focus;
        text: qsTr("Search for files...");
        font.pixelSize: 28
    }
    Image{
        id:shadow;
        anchors.top: parent.top;
        width: parent.width;
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
