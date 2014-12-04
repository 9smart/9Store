import QtQuick 1.0
import com.nokia.symbian 1.0
import "../Main"
Row{
    ListItem{
        id: maininfo;
        //platformInverted: true;
        enabled: false;
        width: parent.parent.width;
        height: bigicon.height + 24;
        Image{
            id:bigicon;
            anchors.left: parent.left;
            anchors.top: parent.top;
            anchors.margins: 9;
            width: 108;
            height: 108;
            source: icon;
            smooth: true;
        }
        Column{
            anchors.verticalCenter: bigicon.verticalCenter;
            anchors.left: bigicon.right;
            anchors.leftMargin: 12;
            spacing: 2;
            RankStars{
                ranknum: ratingnum==="0"?5:(scores/ratingnum).toFixed();
                size: 21;
            }
            Text{
                text: qsTr("By ")+author;
                font.pixelSize: 18
                color: "gray";
            }
            Text{
                text: qsTr("version:")+version;
                font.pixelSize: 18;
                color: "gray"
            }
            Text{
                text: qsTr("size:")+ size;
                font.pixelSize: 18;
                color: "gray"
            }
        }

    }
    ListHeading{
        //platformInverted: true;
        ListItemText{
            anchors.fill: parent.paddingItem
            role: "Heading"
            text: qsTr("Reviews");
            color: "black"
        }
    }
}
