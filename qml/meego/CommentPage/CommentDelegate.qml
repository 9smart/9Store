import QtQuick 1.1
import com.nokia.meego 1.1
import "../../JavaScript/main.js" as Script
import "../Main"
Component{
    ListItem{
        width: parent.parent.width;
        enabled: false;
        height: column.height+20;
        Column{
            id:column;
            spacing: 12;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left:parent.left;
            anchors.leftMargin: 20;
            Row{
                spacing: 8;
                RankStars{
                    ranknum: model.score;
                }
                Text{
                    text: qsTr("by ")+model.nickname;
                    anchors.verticalCenter: parent.verticalCenter;
                    font.pixelSize: 24;
                }
            }
            Row{
                spacing: 12;
                Image{
                    width: 52;
                    height: 52;
                    source: model.avatar;
                }
                Text{
                    width: 380;
                    text: model.message;
                    wrapMode: Text.WrapAnywhere;
                    font.pixelSize: 28;
                }
            }
            Text{
                color: "gray"
                text: Script.humanedate(model.dateline);
                font.pixelSize: 24;
            }
        }
    }
}
