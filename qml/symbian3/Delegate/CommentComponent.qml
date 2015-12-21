import QtQuick 1.1
import com.nokia.symbian 1.1
import com.stars.widgets 1.0
import "../BaseComponent"
import "../../JavaScript/main.js" as Script
Item{
    id: root;
    property string nickname: model.author.nickname;
    width: screen.width;
    height: column.height + 10 + replyscolumn.height;
    Column{
        id:column;
        spacing: 9;
        anchors{
            top: parent.top;
            topMargin: 10;
            left: parent.left;
            leftMargin: 15;
            right: parent.right;
            rightMargin: 15;
        }
        Row{
            spacing: 5;
            RankStars{
                anchors.verticalCenter: parent.verticalCenter;
                size: 14;
                ranknum: model.score;
            }
            Text{
                font.pixelSize: 14;
                text: "by";
            }
            Text{
                font.pixelSize: 14;
                color: "#1080dd";
                text: model.author.nickname;
            }
        }
        Row{
            spacing: 15;
            MyImage{
                width: 35;
                height: 35;
                smooth: true;
                source: model.author.avatar;
                maskSource: "../../pic/Personal/HeadPortrait_Mask_x2.bmp";
            }
            Text{
                width: 280;
                font.pixelSize: 16;
                text: model.content;
                wrapMode: Text.WrapAnywhere;
            }
        }
        Text{
            anchors.right: parent.right;
            font.pixelSize: 13;
            color: "#787878";
            text: model.model + " | " + Script.humanedate(model.dateline);
        }
        Rectangle{
            anchors.left: parent.left;
            anchors.leftMargin: -15;
            width: screen.width;
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
                width: screen.width;
                height: replycolumn.height + 10;
                //color: "#010101";
                Column{
                    id:replycolumn;
                    spacing: 9;
                    anchors{
                        top: parent.top;
                        topMargin: 10;
                        left: parent.left;
                        leftMargin: 15;
                        right: parent.right;
                        rightMargin: 15;
                    }
                    Row{
                        spacing: 5;
                        Text{
                            font.pixelSize: 14;
                            color: "#1080dd";
                            text: model.author.nickname;
                        }
                        Text{
                            font.pixelSize: 14;
                            text: "reply to";
                        }
                        Text{
                            font.pixelSize: 14;
                            color: "#1080dd";
                            text: nickname;
                        }
                    }
                    Row{
                        spacing: 15;
                        MyImage{
                            width: 35;
                            height: 35;
                            smooth: true;
                            source: model.author.avatar;
                            maskSource: "../../pic/Personal/HeadPortrait_Mask_x2.bmp";
                        }
                        Text{
                            width: 280;
                            font.pixelSize: 16;
                            text: model.content;
                            wrapMode: Text.WrapAnywhere;
                        }
                    }
                    Text{
                        anchors.right: parent.right;
                        font.pixelSize: 13;
                        color: "#787878";
                        text: model.model + " | " + Script.humanedate(model.dateline);
                    }
                    Rectangle{
                        anchors.left: parent.left;
                        anchors.leftMargin: -15;
                        width: screen.width;
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
            width: screen.width;
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

