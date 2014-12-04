// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "../Main"
Row{
    ListItem{
        id: maininfo;
        enabled: false;
        width: parent.parent.width;
        height: bigicon.height + 32;
        Image{
            id:bigicon;
            anchors.left: parent.left;
            anchors.top: parent.top;
            anchors.margins: 12;
            width: 120;
            height: 120;
            source: icon;
            smooth: true;
        }
        Column{
            anchors.verticalCenter: bigicon.verticalCenter;
            anchors.left: bigicon.right;
            anchors.leftMargin: 16;
            spacing: 3;
            RankStars{
                ranknum: ratingnum==="0"?5:(scores/ratingnum).toFixed();
                size: 32;
            }
            Text{
                text: qsTr("By ")+author;
                font.pixelSize: 24;
                color: "gray";
            }
            Text{
                text: qsTr("version:")+version;
                font.pixelSize: 24;
                color: "gray"
            }
            Text{
                text: qsTr("size:")+ size;
                font.pixelSize: 24;
                color: "gray"
            }
        }

    }
    ListHeading{
        width: head.width;
        Text{
            anchors.left: parent.left;
            anchors.leftMargin: 20;
            text: qsTr("Reviews");
            color: "black"
        }
    }
}
