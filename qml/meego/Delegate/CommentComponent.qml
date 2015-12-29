import QtQuick 1.1
import com.nokia.meego 1.1
import com.stars.widgets 1.0
import "../BaseComponent"
import "../../JavaScript/main.js" as Script
Component{
    Item{
        width: screen.displayWidth;
        height: column.height + 27;
        Column{
            id:column;
            spacing: 12;
            anchors{
                verticalCenter: parent.verticalCenter;
                left:parent.left;
                leftMargin: 20;
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
                    text: model.nickname;
                }
            }
            Row{
                spacing: 20;
                MyImage{
                    width: 47;
                    height: 47;
                    smooth: true;
                    source: model.avatar;
                    maskSource: "../../pic/Personal/HeadPortrait_Mask_x2.bmp";
                }
                Text{
                    width: 373;
                    font.pixelSize: 21;
                    text: model.message;
                    wrapMode: Text.WrapAnywhere;
                }
            }
            Text{
                anchors.right: parent.right;
                font.pixelSize: 17;
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
