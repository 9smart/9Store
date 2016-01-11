import QtQuick 1.1
import com.nokia.meego 1.1
import com.stars.widgets 1.0
import "../BaseComponent"
import "../../JavaScript/main.js" as Script
Item{
    id: root;
    property string nickname: model.author.nickname;
    width: screen.displayWidth;
    height: column.height + 13 + replyscolumn.height;
    Column{
        id:column;
        spacing: 12;
        anchors{
            top: parent.top;
            topMargin: 13;
            left: parent.left;
            leftMargin: 20;
            right: parent.right;
            rightMargin: 20;
        }
        Row{
            spacing: 7;
            RankStars{
                anchors.verticalCenter: parent.verticalCenter;
                size: 19;
                ranknum: model.score;
            }
            Text{
                font.pixelSize: 19;
                text: "by";
            }
            Text{
                font.pixelSize: 19;
                color: "#1080dd";
                text: model.author.nickname;
            }
        }
        Row{
            spacing: 20;
            MyImage{
                width: 47;
                height: 47;
                smooth: true;
                source: model.author.avatar;
                maskSource: "../../pic/Personal/HeadPortrait_Mask_x2.bmp";
            }
            Text{
                width: 373;
                font.pixelSize: 21;
                text: model.content;
                wrapMode: Text.WrapAnywhere;
            }
        }
        Text{
            anchors.right: parent.right;
            font.pixelSize: 17;
            color: "#787878";
            text: model.model + " | " + Script.humanedate(model.dateline);
        }
        Rectangle{
            anchors.left: parent.left;
            anchors.leftMargin: -20;
            width: screen.displayWidth;
            height: 1;
            color: replyscolumn.height===0?Qt.rgba(0,0,0,0.1):Qt.rgba(1,1,1,1)
            Image{
                anchors.top: parent.top;
                width: parent.width;
                source: "../../pic/General/HeadShadow.png";
                opacity: 0.75;
                z:1;
                visible: replyscolumn.height!==0
            }
        }
    }
    MouseArea{
        anchors.fill: column;
        onClicked: {
            /*if(user.userState){
                //console.log(model.id)
                sendreplydialog.openDialog(model.id, model.author.nickname);

            }
            else{
                signalCenter.showMessage(qsTr("Please login"));
            }*/
        }
    }
    Column{
        id: replyscolumn;
        anchors.top: column.bottom;
        Repeater{
            id: reperter;
            model: {
                try{
                    return commentmodel.get(index).replys;
                }
                catch(e){
                    return 0;
                }
            }

            Item{
                width: screen.displayWidth;
                height: replycolumn.height + 13;
                //color: "#010101";
                Column{
                    id:replycolumn;
                    spacing: 12;
                    anchors{
                        top: parent.top;
                        topMargin: 13;
                        left: parent.left;
                        leftMargin: 20;
                        right: parent.right;
                        rightMargin: 20;
                    }
                    Row{
                        spacing: 7;
                        Text{
                            font.pixelSize: 19;
                            color: "#1080dd";
                            text: model.author.nickname;
                        }
                        Text{
                            font.pixelSize: 19;
                            text: "reply to";
                        }
                        Text{
                            font.pixelSize: 19;
                            color: "#1080dd";
                            text: nickname;
                        }
                    }
                    Row{
                        spacing: 20;
                        MyImage{
                            width: 47;
                            height: 47;
                            smooth: true;
                            source: model.author.avatar;
                            maskSource: "../../pic/Personal/HeadPortrait_Mask_x2.bmp";
                        }
                        Text{
                            width: 373;
                            font.pixelSize: 21;
                            text: model.content;
                            wrapMode: Text.WrapAnywhere;
                        }
                    }
                    Text{
                        anchors.right: parent.right;
                        font.pixelSize: 17;
                        color: "#787878";
                        text: model.model + " | " + Script.humanedate(model.dateline);
                    }
                    Rectangle{
                        anchors.left: parent.left;
                        anchors.leftMargin: -20;
                        width: screen.displayWidth;
                        height: 1;
                        color: "#000000";
                        opacity:0.1;
                    }
                }
            }
        }
        ListFooter{
            text: qsTr("More");
            /*visible: {
                //model.replys.count > 2;
                try{
                    if(commentmodel.get(index).replys.count > 2)
                        return true;
                    else return false;
                }
                catch(e){
                    return false;
                }
            }*/
            visible: false;
            onClicked: {

            }
        }
        Item{
            height: 1;
            width: screen.displayWidth;
            visible: reperter.count > 0;
            Image{
                rotation: 180;
                anchors.bottom: parent.bottom;
                width: parent.width;
                source: "../../pic/General/HeadShadow.png";
                opacity: 0.75;
                z:1;
            }
        }
    }
}

