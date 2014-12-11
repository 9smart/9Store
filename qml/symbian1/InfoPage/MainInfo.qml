import QtQuick 1.0
import com.nokia.symbian 1.1
import "../Main"

ListItem {
    id: maininfo;
    //platformInverted: true;
    enabled: false;
    width: parent.parent.width;
    height: bigicon.height + 24 + dlbutton.height;
    Image {
        id:bigicon;
        anchors.left: parent.left;
        anchors.top: parent.top;
        anchors.margins: 9;
        width: 108;
        height: 108;
        source: icon;
        smooth: true;
    }
    Column {
        anchors.verticalCenter: bigicon.verticalCenter;
        anchors.left: bigicon.right;
        anchors.leftMargin: 12;
        spacing: 2;
        RankStars {
            ranknum: ratingnum==="0"?5:(scores/ratingnum).toFixed();
            size: 21;
        }
        Text {
            text: qsTr("By ")+author;
            font.pixelSize: 18
            color: "gray";
        }
        Text {
            text: qsTr("version:")+version;
            font.pixelSize: 18;
            color: "gray"
        }
        Text {
            text: qsTr("size:")+ size;
            font.pixelSize: 18;
            color: "gray"
        }
    }
    ToolButton {
        id:dlbutton;
        anchors.top: bigicon.bottom;
        anchors.right: parent.right;
        anchors.rightMargin: 15;
        text: qsTr("download");
        //platformInverted: true;
        checkable:dlnum===-1?true:false;
        onClicked: {
            if(dlnum===-1) {
                if(fileoperate.dirExist(downloadpath)){
                    var file=downloadpath+"["+appid+"]"+title+".sis";
                    downloadmodel.append({"icon":icon,"name":title,"url":dlurl,"file":file});
                    qcurl.appenddl(dlurl,file);
                    signalCenter.showMessage(qsTr("Download appended!"));
                }
                else
                    signalCenter.showMessage(qsTr("Please select an existent path for the download"));
            }
        }
    }
}
