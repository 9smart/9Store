// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.stars.widgets 1.0
import "../BaseComponent"
Flickable{
    width: screen.width;
    Image{
        id:cover;
        width: screen.width;
        height: 170;
        source: "../../pic/Personal/Personal_Background.png";
        Image{
            anchors.top: parent.top;
            source: "../../pic/Home/Poster_Shadow_01.png";
        }
        Image{
            anchors.bottom: parent.bottom;
            source: "../../pic/Home/Poster_Shadow_03.png";
        }
        Image{
            source: "../../pic/Personal/DEV.svg";
            visible: false;
        }
        MyImage{
            id:avatar;
            anchors.left: parent.left;
            anchors.leftMargin: 15;
            anchors.bottom: parent.bottom;
            anchors.bottomMargin: -20;
            width: 80;
            height: 80;
            smooth: true;
            source: app.avatar;
            maskSource: "../../pic/Personal/HeadPortrait_Mask_x2.bmp";
        }
        Column{
            anchors.left: avatar.right;
            anchors.leftMargin: 15;
            anchors.bottom: parent.bottom;
            anchors.bottomMargin: 10;
            Text{
                font.pixelSize: 30;
                text: app.nickname;
            }
        }

    }
    Column{
        anchors.top: cover.bottom;
        anchors.topMargin: 30;
        width: screen.width;
        MyListHeading{
            text: qsTr("More");
        }
        MyListItem{
            Text{
                anchors.verticalCenter: parent.verticalCenter;
                anchors.left: parent.left;
                anchors.leftMargin: 15;
                text: qsTr("Download");
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
        }
        MyListHeading{
            text: qsTr("Settings");
        }
        MyListItem{
            Text{
                anchors.verticalCenter: parent.verticalCenter;
                anchors.left: parent.left;
                anchors.leftMargin: 15;
                text: qsTr("Installation preferences");
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
        }
    }
    NumberAnimation on opacity {
        from: 0;
        to:1;
        duration: 300;
    }
}
