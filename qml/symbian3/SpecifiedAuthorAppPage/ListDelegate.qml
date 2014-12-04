// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../../JavaScript/main.js" as Script
import "../Main"
Component{
    id:delegate;
    ListItem{
        id:wrapper;
        platformInverted: true;
        property int dlnum:-1;
        width: 360;
        height: 84;
        Image{
            id:icon;
            anchors.left: parent.left;
            anchors.leftMargin: 9;
            anchors.verticalCenter: parent.verticalCenter;
            height: 75;
            width: 75;
            source: model.icon;
            smooth: true;
            Rectangle{
                anchors.fill: parent;
                color: "gray";
                visible: parent.status!=Image.Ready;
            }
        }
        Column{
            spacing:2;
            anchors.left: icon.right;
            anchors.top: parent.top;
            anchors.margins: 9;
            ListItemText{
                platformInverted: true;
                text: model.appname;
                role: "Title";
                smooth: true;
                font.pixelSize: 21;
            }
            ListItemText{
                id: authorLabel;
                platformInverted: true;
                text: model.author;
                role: "Subtitle";
                color: "gray";
            }
            RankStars{
                size: 17;
                ranknum: model.ratingnum==="0"?0:(scores/ratingnum).toFixed();
            }
        }
        Button{
            id: downloadBtn;
            platformInverted: true;
            width: height;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.right: parent.right; anchors.rightMargin: 15;
            iconSource: "../../pic/down.svg";
            z:1;
            enabled:{
                if(wrapper.dlnum===-1)
                    return true;
                else
                    return false;
            }
            onClicked:{
                if(fileoperate.dirExist(downloadpath)){
                    var file=downloadpath+appid+".sis";
                    downloadmodel.append({"icon":model.icon,"name":model.appname,"url":"http://api.9smart.cn/app/"+model.appid+"?download=download","file":file});
                    qcurl.appenddl("http://api.9smart.cn/app/"+model.appid+"?download=download",file);
                    signalCenter.showMessage(qsTr("Download appended!"));
                    dlnum=1;
                }
                else signalCenter.showMessage(qsTr("Please select an existent path for the download"));
            }
        }                
        onClicked:{
            pageStack.push(Qt.resolvedUrl("../InfoPage.qml"),{appid:model.appid,title:model.appname,icon:model.icon,summary:model.summary,version:model.version,author:model.author,ratingnum:model.ratingnum,scores:model.scores});
        }

    }
}
