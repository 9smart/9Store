// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "../BaseComponent"
Rectangle{
    id: maininfo;
    width: screen.displayWidth;
    height: 120;
    color: "#f5f5f5";
    Image{
        id:bigicon;
        anchors{
            left: parent.left;
            top: parent.top;
            leftMargin: 20;
            topMargin: 13;
        }
        width: 107;
        height: 107;
        source: icon;
        smooth: true;
        Image{
            anchors.fill: parent;
            source: "../../pic/General/App_icon_Loading.svg";
            visible: parent.status==Image.Loading;
        }
        Image{
            anchors.fill: parent;
            source: "../../pic/General/App_icon_Error.svg";
            visible: parent.status==Image.Error;
        }
    }
    Column{
        anchors{
            bottom: parent.bottom;
            left: bigicon.right;
            leftMargin: 20;
        }
        RankStars{
            ranknum: ratingnum==="0"?0:(scores/ratingnum);
            size: 28;
        }
        Text{
            text: qsTr("By:")+author;
            font.pixelSize: 20;
            color: "gray";
        }
        Text{
            text: type+" > "+category;
            font.pixelSize: 20;
            color: "gray"
        }
        Text{
            text: "v"+version+" - "+size;
            font.pixelSize: 20;
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
