// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
Component{
    id:delegate;
    Item{
        property bool currenturl;
        property bool fileexist;
        id:wrapper;
        width: 480;
        height: 120;
        Image{
            id:sicon;
            anchors.left: parent.left;
            anchors.leftMargin: 20;
            anchors.verticalCenter: parent.verticalCenter;
            height: 80;
            width: 80;
            smooth: true;
            source: model.icon;
        }
        Text{
            id:name;
            anchors.top: sicon.top;
            anchors.left: sicon.right;
            anchors.leftMargin: 20;
            text: model.name;
            font.pixelSize: 29;
        }
        ProgressBar{
            id:progress;
            anchors.top: name.bottom;
            anchors.topMargin: 20;
            width: 260;
            anchors.left: name.left;
        }
        Rectangle{
            anchors.left: parent.left;
            anchors.right: parent.right;
            anchors.bottom: parent.bottom;
            color: "lightgray";
            height: 2;
        }
        MouseArea{
            anchors.fill: parent;
            onClicked:{
                if(progress.value===1){
                    console.log(model.url)
                    fileoperate.openFile(1,model.file)
                    signalCenter.showMessage(qsTr("This pakage will be installed at background"))
                    if(model.url==="http://api.9smart.cn/app/213?download=download")
                        Qt.quit();
                }
            }
        }
        Timer{
            interval: 500;
            running: true;
            repeat: true;
            triggeredOnStart: true;
            onTriggered:{
                currenturl=qcurl.iscurrenturl(model.url);
                fileexist=qcurl.isfileexist(model.file);
                if(currenturl===true) {
                    progress.value=qcurl.getprogress();
                }
                if((currenturl===false)&&(fileexist===false)) {
                    progress.value=0;
                }
                if((currenturl===false)&&(fileexist===true)) {
                    progress.value=1;
                    running=false;
                }
            }
        }
    }
}
