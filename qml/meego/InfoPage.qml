import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import "../JavaScript/main.js" as Script
import "Main"
import "InfoPage"
MyPage{
    id:infopage;
    property string appid;
    property string icon;
    property string author;
    property string summary;
    property string version;
    property string category;
    property string size;
    property string ratingnum;
    property string scores;
    property int dlnum:-1;
    property bool firstStart: true;
    property string dlurl:"http://api.9smart.cn/app/"+appid+"?download=download";
    onVisibleChanged: if (visible && firstStart) {
                          firstStart = false
                          Script.getinfo(appid);
                      }
    tools: ToolBarLayout{
        ToolIcon{
            platformIconId: "toolbar-back";
            onClicked: pageStack.pop();
        }
        ToolIcon{
            platformIconId: "toolbar-edit";
            onClicked: userstate===0?pageStack.push(Qt.resolvedUrl("LoginPage.qml")):sendcommentdialog.open();
        }
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
    InfoPageHead{
        id:head;
    }
    Flickable{
        id:flick;
        flickableDirection: Flickable.VerticalFlick
        anchors.fill: parent;
        anchors.topMargin: head.height;
        contentHeight: infoColumn.height;
        Column{
            id:infoColumn;
            width: parent.width;
            MainInfo{
                id:maininfo;
            }
            ListItem{
                enabled: false;
                height: summ.height+24;
                Text{
                    id:summ;
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.left: parent.left;
                    anchors.right: parent.right;
                    anchors.leftMargin: 16;
                    anchors.rightMargin: 16;
                    font.pixelSize: 24;
                    wrapMode: Text.WrapAnywhere;
                    text: summary;
                    //Component.onCompleted: console.log(width+"  "+parent.width)
                }
            }
            ListItem{
                height: 480;
                //enabled: false;
                visible: screenshotmodel.count>0;
                Flickable{
                    id:screenshots;
                    anchors.left: parent.left;
                    anchors.right: parent.right;
                    height: parent.height;
                    flickableDirection: Flickable.HorizontalFlick;
                    contentWidth: 16+256*screenshotview.count;
                    Row{
                        anchors.left: parent.left;
                        anchors.top: parent.top;
                        anchors.margins: 20;
                        spacing: 16;
                        Repeater{
                            id:screenshotview;
                            model: screenshotmodel;
                            delegate: ScreenShotsDelegate{}
                        }
                    }
                }
            }
            ListItem{
                height: 80;
                Row{
                    anchors.verticalCenter: parent.verticalCenter;
                    Text{
                        font.pixelSize: 32;
                        text: qsTr("  Reviews")+" ("+ratingnum+") ";
                    }
                    RankStars{
                        size: 36;
                        ranknum: ratingnum==="0"?0:(scores/ratingnum).toFixed();
                    }
                }
                Image{
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.right: parent.right;
                    anchors.rightMargin: 12;
                    source: "../pic/icon-s-common-next.png";
                }
                onClicked: pageStack.push(Qt.resolvedUrl("CommentPage.qml"),{appid:appid,ratingnum:ratingnum,size:size,author:author,icon:icon,scores:scores,title:title})
            }
            ListItem{
                height: 80;
                Text{
                    font.pixelSize: 32;
                    text: "  "+author;
                    anchors.verticalCenter: parent.verticalCenter;
                }
                Image{
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.right: parent.right;
                    anchors.rightMargin: 12;
                    source: "../pic/icon-s-common-next.png";
                }
                onClicked: pageStack.push(Qt.resolvedUrl("SpecifiedAuthorAppPage.qml"),{title:author})
            }
            ListHeading{
                id: relatedAppsTitle;
                Text{
                    anchors.left: parent.left;
                    anchors.leftMargin: 12;
                    anchors.verticalCenter: parent.verticalCenter;
                    text: qsTr("Related APPs");
                    font.pixelSize: 24;
                }
            }
            Repeater{
                model: relatedlistmodel;
                delegate: ListDelegate{}
            }
            ListItem{
                height: 80;
                Text{
                    font.pixelSize: 32;
                    text: qsTr("  All related apps");
                    anchors.verticalCenter: parent.verticalCenter;
                }
                Image{
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.right: parent.right;
                    anchors.rightMargin: 12;
                    source: "../pic/icon-s-common-next.png";
                }
                onClicked: pageStack.push(Qt.resolvedUrl("RelatedAppsPage.qml"),{appid:appid,category:category,title:title})
            }
        }
    }
    Connections{
        target: signalCenter;
        onDlInfoSetted:{
            category=Script.category;
            summary=Script.summary;
            size=Script.size;
            Script.getrelatedlist("meego","1","3",appid,category);
        }
        onCommentSendSuccessful:{
            signalCenter.showMessage(qsTr("Send successfully"))
        }
        onCommentSendFailed:{
            signalCenter.showMessage(errorstring);
        }
    }
    Component.onCompleted:{
        Script.relatedlistmodel=relatedlistmodel;
        Script.screenshotmodel=screenshotmodel;
    }

}
