// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "../Main"
ListItem{
    id: maininfo;
    enabled: false;
    width: parent.parent.width;
    height: bigicon.height + 32 + dlbutton.height;
    Image{
        id:bigicon;
        anchors.left: parent.left;
        anchors.top: parent.top;
        anchors.margins: 12;
        width: 100;
        height: 100;
        source: icon;
        smooth: true;
    }
    Column{
        anchors.verticalCenter: bigicon.verticalCenter;
        anchors.left: bigicon.right;
        anchors.leftMargin: 12;
        //spacing: 2;
        RankStars{
            ranknum: ratingnum==="0"?0:(scores/ratingnum).toFixed();
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
    ToolButton{
        id:dlbutton;
        anchors.top: bigicon.bottom;
        anchors.topMargin: 12;
        anchors.right: parent.right;
        anchors.rightMargin: 20;
        text: qsTr("download");
        enabled: dlnum===-1?true:false;
        onClicked:{
            if(dlnum===-1) {
                if(fileoperate.dirExist(downloadpath)){
                    var file=downloadpath+"["+appid+"]"+title+".deb";
                    downloadmodel.append({"icon":icon,"name":title,"url":dlurl,"file":file});
                    qcurl.appenddl(dlurl,file);
                    signalCenter.showMessage(qsTr("Download appended!"));
                }
                else signalCenter.showMessage(qsTr("Please select an existent path for the download"));
            }
        }
    }
}
