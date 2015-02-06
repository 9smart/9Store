import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "BaseComponent"
import "Delegate"
import "Dialog"
import "InfoPage"
import "../JavaScript/main.js" as Script
MyPage{
    id:infopage;
    property string appid;
    property string icon;
    property string author;
    property string summary;
    property string version;
    property string type;
    property string category;
    property string size;
    property string ratingnum;
    property string scores;
    property int dlnum:-1;
    property string dlurl:"http://api.9smart.cn/app/"+appid+"?download=download";
    property bool firstStart: true;
    onVisibleChanged: if (visible && firstStart) {
                          firstStart = false
                          Script.getinfo(appid);
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
        onPersonalButtonClicked: fileoperate.openFile(1,"a");
    }
    ListModel{
        id:screenshotmodel;
    }
    ListModel{
        id:relatedlistmodel;
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
                height: 120;
                enabled:false;
                visible: screenshotmodel.count!=0;
                state: "close";
                Flickable{
                    id:screenshotview;
                    anchors.left: parent.left;
                    anchors.top: parent.top;
                    anchors.leftMargin: 15;
                    anchors.topMargin: 15;
                    flickableDirection: Flickable.HorizontalFlick;
                    Row{
                        spacing: 10;
                        Repeater{
                            model: screenshotmodel;
                            delegate: ScreenShotsComponent{}
                        }
                    }
                }
                Image{
                    id:screenshotmask
                    anchors.bottom: parent.bottom;
                    source: "../pic/Details/Details_Mask.png";                  
                }
                Image{
                    id:morebutton;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.bottom: parent.bottom;
                    anchors.bottomMargin: 20;
                    source: "../pic/General/icon-m-toolbar-next.png";
                    rotation: 90;
                    height: 20;
                    width: 20;
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: parent.state=="close"?parent.state="open":parent.state="close";
                    }
                }
                Image{
                    anchors.top: parent.top;
                    source: "../pic/Home/Poster_Shadow_01.png";
                }
                Image{
                    anchors.bottom: parent.bottom;
                    source: "../pic/Home/Poster_Shadow_03.png";
                }
                states: [
                    State{
                        name: "open";
                        PropertyChanges {
                            target: parent.parent;
                            height:285;
                        }
                        PropertyChanges{
                            target: screenshotmask;
                            opacity:0;
                        }
                        PropertyChanges{
                            target: screenshotview;
                            anchors.topMargin: 20;
                        }
                        PropertyChanges{
                            target: morebutton;
                            rotation:-90;
                        }
                    },
                    State{
                        name:"close";
                        PropertyChanges {
                            target: parent.parent;
                            height:120;
                        }
                        PropertyChanges{
                            target: screenshotmask;
                            opacity:1;
                        }
                        PropertyChanges{
                            target: screenshotview;
                            anchors.topMargin: 15;
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
                            target: parent.parent;
                            property: "height";
                            duration: 500;
                        }
                        PropertyAnimation{
                            target: screenshotmask;
                            property: "opacity";
                            duration: 500;
                        }
                        PropertyAnimation{
                            target: screenshotview;
                            property: "anchors.topMargin";
                            duration: 500;
                        }
                        PropertyAnimation{
                            target: morebutton;
                            property: "rotation";
                            duration: 500;
                        }
                    }
                ]
            }
            MyListItem{
                height: summ.height+30;
                enabled:false;
                Text{
                    id:summ;
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.left: parent.left;
                    anchors.right: parent.right;
                    anchors.leftMargin: 12;
                    anchors.rightMargin: 12;
                    font.pixelSize: 15;
                    wrapMode: Text.WrapAnywhere;
                    text: summary;
                }
            }
            MyListItem{
                Row{
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.left: parent.left;
                    anchors.leftMargin: 15;
                    Text{
                        font.pixelSize: 21;
                        text: qsTr("Reviews")+" ("+ratingnum+") ";
                    }
                    RankStars{
                        size: 21;
                        anchors.verticalCenter: parent.verticalCenter;
                        ranknum: ratingnum==="0"?0:(scores/ratingnum);
                    }
                }
                Image{
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.right: parent.right;
                    anchors.rightMargin: 15;
                    width: 20;
                    height: 20;
                    smooth: true;
                    source: "../pic/General/icon-m-toolbar-next.png";
                }
                onClicked: pageStack.push(Qt.resolvedUrl("CommentPage.qml"),{appid:appid,ratingnum:ratingnum,size:size,author:author,type:type,category:category,icon:icon,scores:scores,title:title})
            }
            MyListItem{
                Text{
                    font.pixelSize: 24;
                    text: author;
                    anchors.left: parent.left;
                    anchors.leftMargin: 15;
                    anchors.verticalCenter: parent.verticalCenter;
                }
                Image{
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.right: parent.right;
                    anchors.rightMargin: 15;
                    width: 20;
                    height: 20;
                    smooth: true;
                    source: "../pic/General/icon-m-toolbar-next.png";
                }
                onClicked: pageStack.push(Qt.resolvedUrl("SpecifiedAuthorAppPage.qml"),{title:author})
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
                    font.pixelSize: 24;
                    text: qsTr("All related apps");
                    anchors.left: parent.left;
                    anchors.leftMargin: 15;
                    anchors.verticalCenter: parent.verticalCenter;
                }
                Image{
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.right: parent.right;
                    anchors.rightMargin: 15;
                    width: 20;
                    height: 20;
                    smooth: true;
                    source: "../pic/General/icon-m-toolbar-next.png";
                }
                onClicked: pageStack.push(Qt.resolvedUrl("RelatedAppsPage.qml"),{appid:appid,category:category,title:title})
            }
        }
    }
    DownloadButton{
        id:downloadbutton2;
        visible: flick.contentY>145;
    }
    Connections{
        target: signalCenter;
        onDlInfoSetted:{
            type=Script.type;
            category=Script.category;
            summary=Script.summary;
            size=Script.size;
            Script.getrelatedlist("belle","1","3",appid,category);
        }
        onCommentSendSuccessful:{
            signalCenter.showMessage(qsTr("Send successfully"))
        }
        onCommentSendFailed:{
            signalCenter.showMessage(errorstring);
        }
    }
    Component.onCompleted:{
        Script.screenshotmodel=screenshotmodel;
        Script.relatedlistmodel=relatedlistmodel;
    }
}
