// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.stars.widgets 1.0
import "../BaseComponent"
Flickable{
    width: screen.displayWidth;
    Image{
        id:cover;
        width: parent.width;
        height: 227;
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
            anchors{
                left: parent.left;
                leftMargin: 20;
                bottom: parent.bottom;
                bottomMargin: -27;
            }
            width: 107;
            height: 107;
            smooth: true;
            source: app.avatar;
            maskSource: "../../pic/Personal/HeadPortrait_Mask_x2.bmp";
        }
        Column{
            anchors{
                left: avatar.right;
                leftMargin: 20;
                bottom: parent.bottom;
                bottomMargin: 13;
            }
            Text{
                font.pixelSize: 40;
                text: app.nickname;
            }
        }

    }
    Column{
        anchors.top: cover.bottom;
        anchors.topMargin: 40;
        width: screen.displayWidth;
        MyListHeading{
            text: qsTr("More");
        }
        MyListItem{
            Text{
                anchors{
                    verticalCenter: parent.verticalCenter;
                    left: parent.left;
                    leftMargin: 20;
                }
                text: qsTr("Download");
                color: "#3c3c3c";
                font.pixelSize: 32;
            }
            Image{
                anchors{
                    verticalCenter: parent.verticalCenter;
                    right: parent.right;
                    rightMargin: 20;
                }
                height: 33;
                width: 33;
                source: "../../pic/General/icon-m-toolbar-next.png";
            }
        }
        MyListHeading{
            text: qsTr("Settings");
        }
        MyListItem{
            Text{
                anchors{
                    verticalCenter: parent.verticalCenter;
                    left: parent.left;
                    leftMargin: 20;
                }
                text: qsTr("Installation preferences");
                color: "#3c3c3c";
                font.pixelSize: 32;
            }
            Image{
                anchors{
                    verticalCenter: parent.verticalCenter;
                    right: parent.right;
                    rightMargin: 20;
                }
                height: 33;
                width: 33;
                source: "../../pic/General/icon-m-toolbar-next.png";
            }
            onClicked: pageStack.push(Qt.resolvedUrl("../InstallSettingPage.qml"))
        }
        MyListItem{
            Text{
                anchors{
                    verticalCenter: parent.verticalCenter;
                    left: parent.left;
                    leftMargin: 20;
                }
                text: qsTr("About");
                color: "#3c3c3c";
                font.pixelSize: 32;
            }
            Image{
                anchors{
                    verticalCenter: parent.verticalCenter;
                    right: parent.right;
                    rightMargin: 20;
                }
                height: 33;
                width: 33;
                source: "../../pic/General/icon-m-toolbar-next.png";
            }
            onClicked: pageStack.push(Qt.resolvedUrl("../AboutPage.qml"))
        }
    }
    NumberAnimation on opacity {
        from: 0;
        to:1;
        duration: 300;
    }
}
