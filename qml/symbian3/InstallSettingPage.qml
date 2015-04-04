import QtQuick 1.1
import com.nokia.symbian 1.1
import com.stars.widgets 1.0
import "../JavaScript/main.js" as Script
import "BaseComponent"
import "Dialog"
MyPage{
    id:downloadpage;
    title: qsTr("Installation preferences");
    ToolBar{
        id:toolbar;
        z:1;
        homeButtonVisible: false;
        topChartsButtonVisible: false;
        searchButtonVisible: false;
        personalButtonVisible: false;
        highlightItem: 0;
        onBackButtonClicked: pageStack.pop();
    }
    Head{
        id:head;
        titleText: title;
        z:1;
    }
    Column{
        id:scolumn;
        anchors{
            top: head.bottom;
            left: parent.left;
            right: parent.right;
            topMargin: 20;
        }
        CheckBox {
            id:autoinstall;
            anchors.leftMargin: 10;
            text: qsTr("Install autoly when download finish");
            platformInverted: true;
            checked: autoInstall;
            onClicked: {
                if(autoInstall){
                    autoInstall = false;
                }
                else autoInstall = true;
                settings.setAutoInstall(autoInstall);
            }
        }
        SelectionListItem{
            platformInverted: true;
            title: qsTr("Download save path");
            subTitle: downloadpath;
            onClicked:{
                fileDialog.inverseTheme = true//设置主题模式
                fileDialog.chooseMode = FilesDialog.IndividualChoice
                fileDialog.chooseType = FilesDialog.FolderType
                fileDialog.exec(downloadpath,FilesDialog.Dirs|FilesDialog.Drives)
                var file = fileDialog.firstSelection()
                if(file.filePath)
                    downloadpath =file.filePath;
                settings.setDownloadPath(downloadpath);
            }
        }
        SelectionListItem{
            platformInverted: true;
            title: qsTr("Installation driver");
            subTitle: installdriver;
            onClicked:{
                fileDialog.inverseTheme = true//设置主题模式
                fileDialog.chooseMode = FilesDialog.IndividualChoice
                fileDialog.chooseType = FilesDialog.FolderType
                fileDialog.exec(installdriver,FilesDialog.Drives)
                var file = fileDialog.firstSelection()
                if(file.filePath)
                    installdriver =file.filePath;
                settings.setInstallDriver(installdriver);
            }
        }
        Button{
            anchors.topMargin: 20;
            platformInverted: true;
            width: 300;
            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("Clear login data");
            onClicked: {
                userstate=0;
                if(userdata.clearUserData("LoginData"))
                    signalCenter.showMessage(qsTr("Clear successfully"));
            }
        }
    }
}
