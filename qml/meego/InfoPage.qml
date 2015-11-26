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
        onPersonalButtonClicked: sendcommentdialog.open();
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
                    height: 215;
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
                    source: "../pic/Details/Details_Mask.png";                  
                }      
                Image{
                    anchors.top: parent.top;
                    source: "../pic/Home/Poster_Shadow_01.png";
                }
                Image{
                    anchors.bottom: parent.bottom;
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
                    height: 27;
                    width: 27;
                    MouseArea{
                        anchors.fill: parent;
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
                            rotation:-120;
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
                            rotation:120;
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
                height: summ.height+30;
                enabled:false;
                Text{
                    id:summ;
                    anchors{
                        verticalCenter: parent.verticalCenter;
                        left: parent.left;
                        right: parent.right;
                        leftMargin: 12;
                        rightMargin: 12;
                    }
                    font.pixelSize: 15;
                    wrapMode: Text.WrapAnywhere;
                    text: summary;
                }
            }
            MyListItem{
                Row{
                    anchors{
                        verticalCenter: parent.verticalCenter;
                        left: parent.left;
                        leftMargin: 15;
                    }
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
                    anchors{
                        verticalCenter: parent.verticalCenter;
                        right: parent.right;
                        rightMargin: 15;
                    }
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
                    anchors{
                        left: parent.left;
                        leftMargin: 15;
                        verticalCenter: parent.verticalCenter;
                    }
                }
                Image{
                    anchors{
                        verticalCenter: parent.verticalCenter;
                        right: parent.right;
                        rightMargin: 15;
                    }
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
                    anchors{
                        left: parent.left;
                        leftMargin: 15;
                        verticalCenter: parent.verticalCenter;
                    }
                }
                Image{
                    anchors{
                        verticalCenter: parent.verticalCenter;
                        right: parent.right;
                        rightMargin: 15;
                    }
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
