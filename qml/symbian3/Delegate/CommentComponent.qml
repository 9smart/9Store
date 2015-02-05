import QtQuick 1.1
import com.nokia.symbian 1.1
import com.stars.widgets 1.0
import "../BaseComponent"
import "../../JavaScript/main.js" as Script
Component{
    Item{
        width: screen.width;
        height: column.height+20;
        Column{
            id:column;
            spacing: 9;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left:parent.left;
            anchors.leftMargin: 15;
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
                    text: model.nickname;
                }
            }
            Row{
                spacing: 15;
                MyImage{
                    width: 35;
                    height: 35;
                    smooth: true;
                    source: model.avatar;
                    maskSource: "../../pic/Personal/HeadPortrait_Mask_x2.bmp";
                }
                Text{
                    width: 280;
                    font.pixelSize: 16;
                    text: model.message;
                    wrapMode: Text.WrapAnywhere;
                }
            }
            Text{
                anchors.right: parent.right;
                font.pixelSize: 13;
                color: "#787878";
                text: Script.humanedate(model.dateline);
            }
        }
        Rectangle{
            anchors.bottom: parent.bottom;
            width: screen.width;
            height: 1;
            color: "#000000";
            opacity:0.1;
        }
    }
}
