import QtQuick 1.1
import com.nokia.symbian 1.1
import "../../JavaScript/main.js" as Script
import "../Main"
Component{
    ListItem{
        platformInverted: true;
        width: commentpage.width;
        enabled: false;
        height: column.height+21;
        Column{
            id:column;
            spacing: 9;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left:parent.left;
            anchors.leftMargin: 15;
            Row{
                spacing: 6;
                RankStars{
                    ranknum: model.score;
                }
                ListItemText{
                    platformInverted: true;
                    role: "Head";
                    text: qsTr("by ")+model.nickname;
                }
            }
            Row{
                spacing: 9;
                Image{
                    width: 36;
                    height: 36;
                    source: model.avatar;
                }
                Text{
                    width: 285;
                    text: model.message;
                    wrapMode: Text.WrapAnywhere;
                }
            }
            ListItemText{
                platformInverted: true;
                role: "Subtitle";
                text: Script.humanedate(model.dateline);
            }
        }
    }
}
