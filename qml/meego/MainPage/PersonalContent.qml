// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.stars.widgets 1.0
import "../BaseComponent"
import "../Dialog"
Flickable{
    //width: screen.displayWidth;
    width: 480;
    flickableDirection: Flickable.VerticalFlick;
    contentHeight: cover.height + maincolumn.height + 40;
    clip: true;
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
            visible: app.user.group === "开发者";
            sourceSize: Qt.size(67, 67);
            //Component.onCompleted: console.log(height + " " + width)
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
            source: app.user.avatar;
            maskSource: "../../pic/Personal/HeadPortrait_Mask_x2.bmp";
            MyImage{
                anchors.fill: parent;
                source: "../../pic/Details/App_Datail_Loading.svg";
                maskSource: "../../pic/Personal/HeadPortrait_Mask_x2.bmp";
                visible: parent.status == Image.Loading;
            }
            MyImage{
                anchors.fill: parent;
                source: "../../pic/Personal/defalt.png";
                maskSource: "../../pic/Personal/HeadPortrait_Mask_x2.bmp";
                smooth: true;
                visible: parent.status == Image.Error;
            }
        }
        Column{
            anchors{
                left: avatar.right;
                leftMargin: 20;
                bottom: parent.bottom;
                bottomMargin: 13;
            }
            Row{
                spacing: 7;
                Text{
                    font.pixelSize: 40;
                    text: app.user.nickName;
                    color: "#3c3c3c";
                }
                Text{
                    font.pixelSize: 20;
                    anchors.bottom: parent.bottom;
                    anchors.bottomMargin: 6;
                    color: "#787878";
                    text: app.user.group;
                }
            }
        }

    }
    Column{
        id: maincolumn;
        anchors.top: cover.bottom;
        anchors.topMargin: 40;
        //width: screen.displayWidth;
        width: 480;
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
            onClicked: {
                pageStack.push(Qt.resolvedUrl("../DownloadPage.qml"));
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
        MyListItem{
            Text{
                anchors{
                    verticalCenter: parent.verticalCenter;
                    left: parent.left;
                    leftMargin: 15;
                }
                text: qsTr("Log out");
                color: "#3c3c3c";
                font.pixelSize: 32;
            }
            onClicked: {
                logoutconfirmdialog.open();
            }
        }
    }
    LogOutConfirmDialog{
        id: logoutconfirmdialog;
        onAccepted: {
            mainpage.toolBar.homeButtonClicked()
        }
    }

    NumberAnimation on opacity {
        from: 0;
        to:1;
        duration: 300;
    }
}
