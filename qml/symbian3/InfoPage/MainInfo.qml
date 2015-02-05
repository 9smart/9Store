// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../BaseComponent"
Rectangle{
    id: maininfo;
    width: screen.width;
    height: 90;
    color: "#f5f5f5";
    Image{
        id:bigicon;
        anchors.left: parent.left;
        anchors.top: parent.top;
        anchors.leftMargin: 15;
        anchors.topMargin: 10;
        width: 80;
        height: 80;
        source: icon;
        smooth: true;
    }
    Column{
        anchors.bottom: parent.bottom;
        anchors.left: bigicon.right;
        anchors.leftMargin: 15;
        RankStars{
            ranknum: ratingnum==="0"?0:(scores/ratingnum);
            size: 21;
        }
        Text{
            text: qsTr("By:")+author;
            font.pixelSize: 14;
            color: "gray";
        }
        Text{
            text: type+" > "+category;
            font.pixelSize: 14;
            color: "gray"
        }
        Text{
            text: "v"+version+" - "+size;
            font.pixelSize: 14;
            color: "gray"
        }
    }
    /*ToolButton{
        id:dlbutton;
        anchors.top: bigicon.bottom;
        anchors.right: parent.right;
        anchors.rightMargin: 15;
        text: qsTr("download");
        platformInverted: true;
        checkable:dlnum===-1?true:false;
        onClicked:{
            if(dlnum===-1) {
                if(fileoperate.dirExist(downloadpath)){
                    var file=downloadpath+"["+appid+"]"+title+".sis";
                    downloadmodel.append({"icon":icon,"name":title,"url":dlurl,"file":file});
                    qcurl.appenddl(dlurl,file);
                    signalCenter.showMessage(qsTr("Download appended!"));
                }
                else signalCenter.showMessage(qsTr("Please select an existent path for the download"));
            }
        }
    }*/
}
