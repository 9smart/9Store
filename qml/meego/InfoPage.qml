import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import "BaseComponent"
import "Delegate"
import "Dialog"
import "InfoPage"
import "../JavaScript/main.js" as Script
MyPage{
    id:infopage;
    property string _id;
    property string icon;
    property int score_num;
    property int scores;
    property string developer;
    property string type;
    property string category;
    property string version;
    property string size;
    property string summary;
    property string comment_num

    property string downloadUrl;
    property bool firstStart: true;

    property alias screenShotsModel: screenshotmodel;
    property alias relatedAppsModel: relatedlistmodel;
    property alias specifiedAuthorModel: specifiedauthormodel;

    onVisibleChanged: if (visible && firstStart) {
                          firstStart = false
                          Script.getinfo(_id);
                      }
    onCategoryChanged: if (category != ""){
                           Script.getrelatedlist("MeeGo", category, "", "2");
                       }
    ToolBar{
        id:toolbar;
        z:1;
        homeButtonVisible: false;
        topChartsButtonVisible: false;
        searchButtonVisible: false;
        personalButtonVisible: true;
        personalSource: "../pic/Details/edit.svg";
        highlightItem: 0;
        onBackButtonClicked: pageStack.pop();
        onPersonalButtonClicked: {
            if(user.userState){
                sendcommentdialog.open();
            }
            else{
                signalCenter.showMessage(qsTr("Please login"));
            }
        }
    }
    ListModel{
        id:screenshotmodel;
    }
    ListModel{
        id:relatedlistmodel;
    }
    ListModel{
        id: specifiedauthormodel;
    }
    SendCommentDialog{
        id:sendcommentdialog;
    }
    Flickable{
        id:flick;
        flickableDirection: Flickable.VerticalFlick
        anchors.fill: parent;
        anchors.bottomMargin: toolbar.height;
        contentHeight: infoColumn.height;
        Column{
            id:infoColumn;
            InfoPageHead{
                id:infopagehead;
            }
            MainInfo{
                id:maininfo;
            }
            DownloadButton{
                id:downloadbutton1;
            }
            MyListItem{
                id:screenshot;
                //height: 120;
                enabled:false;
                visible: screenshotmodel.count!=0;
                state: "close";
                Flickable{
                    id:screenshotview;
                    anchors{
                        left: parent.left;
                        top: parent.top;
                        leftMargin: 20;
                        right: parent.right;
                    }
                    height: 287;
                    contentWidth: screenshotmodel.count*173;
                    flickableDirection: Flickable.HorizontalFlick;
                    Row{
                        spacing: 13;
                        Repeater{
                            model: screenshotmodel;
                            delegate: ScreenShotsComponent{}
                        }
                    }
                }
                Image{
                    id:screenshotmask
                    anchors.bottom: parent.bottom;
                    width: parent.width;
                    source: "../pic/Details/Details_Mask.png";
                }
                Image{
                    anchors.top: parent.top;
                    width: parent.width;
                    source: "../pic/Home/Poster_Shadow_01.png";
                }
                Image{
                    anchors.bottom: parent.bottom;
                    width: parent.width;
                    source: "../pic/Home/Poster_Shadow_03.png";
                }
                Image{
                    id:morebutton;
                    anchors{
                        horizontalCenter: parent.horizontalCenter;
                        bottom: parent.bottom;
                        bottomMargin: 20;
                    }
                    source: "../pic/General/icon-m-toolbar-next.png";
                    //rotation: 90;
                    //height: 27;
                    //width: 27;
                    sourceSize: Qt.size(27, 27);
                    MouseArea{
                        anchors.fill: parent;
                        anchors.margins: -10;
                        onClicked: screenshot.state=="close"?screenshot.state="open":screenshot.state="close";
                    }
                }
                states: [
                    State{
                        name: "open";
                        PropertyChanges {
                            target: screenshot;
                            height:380;
                        }
                        PropertyChanges{
                            target: screenshotmask;
                            visible:false;
                        }
                        PropertyChanges{
                            target: screenshotview;
                            anchors.topMargin: 27;
                        }
                        PropertyChanges{
                            target: morebutton;
                            rotation:-90;
                        }
                    },
                    State{
                        name:"close";
                        PropertyChanges {
                            target: screenshot;
                            height:160;
                        }
                        PropertyChanges{
                            target: screenshotmask;
                            visible:true;
                        }
                        PropertyChanges{
                            target: screenshotview;
                            anchors.topMargin: 20;
                        }
                        PropertyChanges{
                            target: morebutton;
                            rotation:90;
                        }
                    }

                ]
                transitions: [
                    Transition{
                        from: "close";
                        to:"open";
                        reversible: true;
                        PropertyAnimation{
                            target: screenshot;
                            property: "height";
                            duration: 250;
                        }
                        PropertyAnimation{
                            target: screenshotview;
                            property: "anchors.topMargin";
                            duration: 250;
                        }
                        PropertyAnimation{
                            target: morebutton;
                            property: "rotation";
                            duration: 250;
                        }
                    }
                ]
            }
            MyListItem{
                height: summ.height + 40;
                enabled:false;
                Text{
                    id:summ;
                    anchors{
                        verticalCenter: parent.verticalCenter;
                        left: parent.left;
                        right: parent.right;
                        leftMargin: 16;
                        rightMargin: 16;
                    }
                    font.pixelSize: 20;
                    wrapMode: Text.WrapAnywhere;
                    text: summary;
                }
            }
            MyListItem{
                Row{
                    anchors{
                        verticalCenter: parent.verticalCenter;
                        left: parent.left;
                        leftMargin: 20;
                    }
                    Text{
                        font.pixelSize: 28;
                        text: qsTr("Reviews")+" ("+comment_num+") ";
                    }
                    RankStars{
                        size: 21;
                        anchors.verticalCenter: parent.verticalCenter;
                        ranknum: score_num === "0"? 0 : (scores / score_num);
                    }
                }
                Image{
                    anchors{
                        verticalCenter: parent.verticalCenter;
                        right: parent.right;
                        rightMargin: 15;
                    }
                    //width: 20;
                    //height: 20;
                    sourceSize: Qt.size(27, 27);
                    smooth: true;
                    source: "../pic/General/icon-m-toolbar-next.png";
                }
                onClicked: pageStack.push(Qt.resolvedUrl("CommentPage.qml"),{_id:_id, score_num:score_num, size:size, developer:developer, type:type, category:category, icon:icon, scores:scores, title:title});
            }
            MyListItem{
                Text{
                    font.pixelSize: 32;
                    text: developer;
                    anchors{
                        left: parent.left;
                        leftMargin: 20;
                        verticalCenter: parent.verticalCenter;
                    }
                }
                Image{
                    anchors{
                        verticalCenter: parent.verticalCenter;
                        right: parent.right;
                        rightMargin: 20;
                    }
                    //width: 20;
                    //height: 20;
                    sourceSize: Qt.size(27, 27);
                    smooth: true;
                    source: "../pic/General/icon-m-toolbar-next.png";
                }
                onClicked: pageStack.push(Qt.resolvedUrl("SpecifiedAuthorAppPage.qml"),{title: developer, specifiedAuthorModel:specifiedAuthorModel})
            }
            MyListHeading{
                id: relatedAppsTitle;
                text: qsTr("Related APPs");
            }
            Repeater{
                model: relatedlistmodel;
                delegate: ListComponent{}
            }
            MyListItem{
                Text{
                    font.pixelSize: 32;
                    text: qsTr("All related apps");
                    anchors{
                        left: parent.left;
                        leftMargin: 20;
                        verticalCenter: parent.verticalCenter;
                    }
                }
                Image{
                    anchors{
                        verticalCenter: parent.verticalCenter;
                        right: parent.right;
                        rightMargin: 15;
                    }
                    //width: 20;
                    //height: 20;
                    sourceSize: Qt.size(27, 27);
                    smooth: true;
                    source: "../pic/General/icon-m-toolbar-next.png";
                }
                onClicked: pageStack.push(Qt.resolvedUrl("RelatedAppsPage.qml"),{category:category,title:title,relatedlistmodel:relatedlistmodel});
            }
        }
    }
    DownloadButton{
        id:downloadbutton2;
        visible: flick.contentY > 193;
    }
    PathView{
        id: screenshotgallary;
        //width: screen.displayWidth;
        width: 480;
        //height: screen.displayHeight;
        height: 854;
        y: -36;
        z: 2;
        model: screenshotmodel;
        clip: true;
        preferredHighlightBegin: 0.5;
        preferredHighlightEnd: 0.5;
        state: "close";
        delegate: ScreenShotsGalleryComponent{}
        path: Path{
            startX: -screenshotgallary.width*screenshotgallary.count/2+screenshotgallary.width/2;
            startY: screenshotgallary.height/2;
            PathLine{
                x:screenshotgallary.width*screenshotgallary.count/2+screenshotgallary.width/2;
                y:screenshotgallary.height/2;
            }
        }
        states: [
            State{
                name: "close";
                PropertyChanges{
                    target: screenshotgallary;
                    visible: false;
                    scale: 0.5;
                    opacity: 0;
                }
            },
            State{
                name: "open";
                PropertyChanges{
                    target: screenshotgallary;
                    visible: true;
                    scale: 1;
                    opacity: 1;
                }
            }
        ]
        transitions: [
            Transition {
                from: "close"
                to: "open"
                reversible: true;
                PropertyAnimation{
                    target: screenshotgallary;
                    properties: "scale";
                    duration: 200;
                }
                PropertyAnimation{
                    target: screenshotgallary;
                    properties: "opacity";
                    duration: 200;
                }
            }
        ]
        //onStateChanged: console.log("change")
    }
    Connections{
        target: signalCenter;
        onCommentSendSuccessful:{
            signalCenter.showMessage(qsTr("Send successfully"))
        }
        onCommentSendFailed:{
            signalCenter.showMessage(errorstring);
        }
    }
    Component.onCompleted:{
        Script.infoPage = infopage
    }
}
