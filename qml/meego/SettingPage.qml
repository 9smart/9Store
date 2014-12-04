import QtQuick 1.1
import "Main"
import "SettingPage"
import "../JavaScript/main.js" as Script
import com.nokia.meego 1.1
import com.stars.widgets 1.0
MyPage{
    id:downloadpage;
    property string newversion;
    tools: ToolBarLayout{
        ToolIcon{
            platformIconId: "toolbar-back";
            onClicked: pageStack.pop();
        }
    }
    AboutDialog{
        id:aboutdia;
    }
    SettingPageHead{
        id:head
    }
    Column{
        id:scolumn;
        anchors.top: head.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right;
        spacing: 27;
        SettingsItem{
            title: qsTr("Download save path");
            subtitle: downloadpath;
            //onClicked:folderselecter.open();
            onClicked: {
                fileDialog.inverseTheme = false//设置主题模式
                fileDialog.chooseMode = FilesDialog.IndividualChoice
                fileDialog.chooseType = FilesDialog.AllType
                if(fileDialog.exec(downloadpath, "", FilesDialog.Dirs|FilesDialog.Drives,
                                   FilesDialog.Name)){
                    console.log("here1")
                    var file = fileDialog.firstSelection()
                    downloadpath =file.filePath;
                    settings.setDownloadPath(downloadpath);
                }
            }
        }
        Button{
            anchors.horizontalCenter: parent.horizontalCenter;
            width: 400;
            text: qsTr("Clear login data");
            onClicked: {
                userstate=0;
                if(userdata.clearUserData("LoginData"))
                    signalCenter.showMessage(qsTr("Clear successfully"));
            }
        }
        Button{
            anchors.horizontalCenter: parent.horizontalCenter;
            width: 400;
            text: qsTr("Check for new version");
            onClicked: Script.getversion();
        }
        Button{
            anchors.horizontalCenter: parent.horizontalCenter;
            width: 400;
            text: qsTr("About");
            onClicked: aboutdia.open();
        }
    }
    QueryDialog
    {
        id:verquerydia;
        titleText: qsTr("New version has been found")
        message: qsTr("Whether to download the new version?");
        acceptButtonText: qsTr("Yes");
        rejectButtonText: qsTr("No");
        onAccepted:{
            var file=downloadpath+"[213]"+qsTr("9Stroe")+".deb";
            downloadmodel.append({"icon":"http://yayabo-s1.stor.sinaapp.com/png/201410/14128173469x5.thumb.png","name":"久店","url":"http://api.9smart.cn/app/213?download=download","file":file});
            qcurl.appenddl("http://api.9smart.cn/app/105?download=download",file);
            signalCenter.showMessage(qsTr("Download appended!"));
        }
    }
    Connections{
        target: signalCenter;
        onVersionGeted:{
            newversion=Script.version;
            if(Script.isnew(version,newversion)){
                signalCenter.showMessage(qsTr("This version is the new newest version"));
            }
            else verquerydia.open()
        }
    }
}
