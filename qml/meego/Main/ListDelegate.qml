// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "../../JavaScript/main.js" as Script
Component{
    id:delegate;
    ListItem{
        id:wrapper;
        property int dlnum:-1;
        width: 480;
        height: 112;
        Image{
            id:icon;
            anchors.left: parent.left;
            anchors.leftMargin: 12;
            anchors.verticalCenter: parent.verticalCenter;
            height: 80;
            width: 80;
            source: model.icon;
            smooth: true;
            Rectangle{
                anchors.fill: parent;
                color: "lightgray";
                visible: parent.status!=Image.Ready;
            }
        }
        Column{
            //spacing:4;
            anchors.left: icon.right;
            anchors.top: parent.top;
            anchors.margins: 12;
            Text{
                text: model.appname;
                smooth: true;
                font.pixelSize: 28;
            }
            Text{
                id: authorLabel;
                text: model.author;
                color: "gray";
                font.pixelSize: 24;
            }
            RankStars{
                size: 24;
                ranknum: model.ratingnum==="0"?0:(scores/ratingnum).toFixed();
            }
        }
        Button{
            id: downloadBtn;
            width: height;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.right: parent.right;
            anchors.rightMargin: 20;
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
                    var file=downloadpath+"["+appid+"]"+title+".deb";
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
