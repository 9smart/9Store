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
    property string _id;
    property string icon;
    property string score_num;
    property string scores;
    property string developer;
    property string type;
    property string category;
    property string version;
    property string size;
    property string summary;
    property string comment_num

    //property int dlnum:-1;
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
                           Script.getrelatedlist("Symbian%5e3", category, "", "2");
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
                enabled: false;
                visible: screenshotmodel.count != 0;
                state: "close";
                Flickable{
                    id:screenshotview;
                    anchors{
                        left: parent.left;
                        top: parent.top;
                        leftMargin: 15;
                        right: parent.right;
                    }
                    height: 215;
                    contentWidth: screenshotmodel.count * 130;
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
                    id: screenshotmask
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
                    id: morebutton;
                    anchors{
                        horizontalCenter: parent.horizontalCenter;
                        bottom: parent.bottom;
                        bottomMargin: 15;
                    }
                    source: "../pic/General/icon-m-toolbar-next.png";
                    height: 20;
                    width: 20;
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: screenshot.state=="close"? screenshot.state="open" : screenshot.state="close";
                    }
                }
                states: [
                    State{
                        name: "open";
                        PropertyChanges {
                            target: screenshot;
                            height:285;
                        }
                        PropertyChanges{
                            target: screenshotmask;
                            visible:false;
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
                            target: screenshot;
                            height:120;
                        }
                        PropertyChanges{
                            target: screenshotmask;
                            visible:true;
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
                height: summ.height + 30;
                enabled: false;
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
                        text: qsTr("Reviews")+" ("+ comment_num +") ";
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
                    width: 20;
                    height: 20;
                    smooth: true;
                    source: "../pic/General/icon-m-toolbar-next.png";
                }
                onClicked: pageStack.push(Qt.resolvedUrl("CommentPage.qml"),{_id:_id, score_num:score_num, size:size, developer:developer, type:type, category:category, icon:icon, scores:scores, title:title})
            }
            MyListItem{
                Text{
                    font.pixelSize: 24;
                    text: developer;
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
                onClicked: pageStack.push(Qt.resolvedUrl("SpecifiedAuthorAppPage.qml"),{title:developer, specifiedAuthorModel:specifiedAuthorModel})
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
                onClicked: pageStack.push(Qt.resolvedUrl("RelatedAppsPage.qml"),{category:category,title:title,relatedlistmodel:relatedlistmodel})
            }
        }
    }
    DownloadButton{
        id:downloadbutton2;
        visible: flick.contentY > 145;
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
