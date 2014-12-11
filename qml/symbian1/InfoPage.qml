import QtQuick 1.0
import "Main"
import "InfoPage"
import "../JavaScript/main.js" as Script
import com.nokia.symbian 1.1
import com.nokia.extras 1.1

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
    property string dlurl:"http://api.9smart.cn/app/"+appid+"?download=download";
    property bool firstStart: true;
    onVisibleChanged: if (visible && firstStart) {
                          firstStart = false
                          Script.getinfo(appid);
                      }
    tools: ToolBarLayout{
        ToolButton{
            //platformInverted: true;
            iconSource: privateStyle.toolBarIconPath("toolbar-back");
            onClicked: pageStack.pop();
        }
        ToolButton{
            //platformInverted:true;
            iconSource: "Resource/edit.svg";
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
            MainInfo{
                id:maininfo;
            }
            ListItem{
                //platformInverted: true;
                enabled: false;
                height: summ.height+18;
                Text{
                    id:summ;
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.left: parent.left;
                    anchors.right: parent.right;
                    anchors.leftMargin: 12;
                    anchors.rightMargin: 12;
                    font.pixelSize: 18;
                    wrapMode: Text.WrapAnywhere;
                    text: summary;
                    color: "White";
                }
            }
            ListItem{
                height: 360;
                enabled: false;
                visible: screenshotmodel.count>0;
                Flickable{
                    id:screenshots;
                    anchors.left: parent.left;
                    anchors.right: parent.right;
                    height: parent.height;
                    flickableDirection: Flickable.HorizontalFlick;
                    contentWidth: 12+192*screenshotview.count;
                    Row{
                        anchors.left: parent.left;
                        anchors.top: parent.top;
                        anchors.margins: 15;
                        spacing: 12;
                        Repeater{
                            id:screenshotview;
                            model: screenshotmodel;
                            delegate: ScreenShotsDelegate{}
                        }
                    }
                }
            }
            ListItem{
                //platformInverted: true;
                height: 60;
                Row{
                    anchors.verticalCenter: parent.verticalCenter;
                    ListItemText{
                        //platformInverted: true;
                        font.pixelSize: 24;
                        text: qsTr("  Reviews")+" ("+ratingnum+") ";
                        }
                    RankStars{
                        size: 24;
                        ranknum: ratingnum==="0"?5:(scores/ratingnum).toFixed();
                    }
                }
                Image{
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.right: parent.right;
                    anchors.rightMargin: 9
                    source: "Resource/right_arrow.png";
                }
                onClicked: pageStack.push(Qt.resolvedUrl("CommentPage.qml"),{appid:appid,ratingnum:ratingnum,size:size,author:author,icon:icon,scores:scores,title:title})
            }
            ListItem{
                //platformInverted: true;
                height: 60;
                ListItemText{
                    //platformInverted: true;
                    font.pixelSize: 24;
                    text: "  "+author;
                    anchors.verticalCenter: parent.verticalCenter;
                }
                Image{
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.right: parent.right;
                    anchors.rightMargin: 9
                    source: "Resource/right_arrow.png";
                }
                onClicked: pageStack.push(Qt.resolvedUrl("SpecifiedAuthorAppPage.qml"),{title:author})
            }
            ListHeading{
                id: relatedAppsTitle;
                //platformInverted: true;
                ListItemText{
                    anchors.fill: parent.paddingItem
                    role: "Heading"
                    text: qsTr("Related APPs");
                    color: "White";
                }
            }
            Repeater{
                model: relatedlistmodel;
                delegate: RelatedAppsDelegate{}
            }
            ListItem{
                //platformInverted: true;
                height: 60;
                ListItemText{
                    //platformInverted: true;
                    font.pixelSize: 24;
                    text: qsTr("  All related apps");
                    anchors.verticalCenter: parent.verticalCenter;
                }
                Image{
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.right: parent.right;
                    anchors.rightMargin: 9
                    source: "Resource/right_arrow.png";
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
            Script.getrelatedlist("s60v5","1","3",appid,category);
        }
        onCommentSendSuccessful:{
            signalCenter.showMessage(qsTr("Send successfully"))
        }
    }
    Component.onCompleted:{
        Script.screenshotmodel=screenshotmodel;
        Script.relatedlistmodel=relatedlistmodel;
    }
}
