import QtQuick 1.1
import com.nokia.meego 1.1
import com.stars.widgets 1.0
import "../JavaScript/main.js" as Script
import "BaseComponent"
import "Dialog"
MyPage{
    id: installsettingpage;
    property alias newVersionDialog: newversiondialog;
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
            topMargin: 27;
        }
        CheckBox {
            id:autoinstall;
            anchors.left: parent.left;
            anchors.leftMargin: 13;
            text: qsTr("Install autoly when download finish");
            //platformInverted: true;
            checked: settings.autoInstall;
            onClicked: {
                if(settings.autoInstall){
                    settings.autoInstall = false;
                }
                else settings.autoInstall = true;
            }
        }
        Item{
            height: 8;
            width: 1
        }

        CheckBox{
            id: silenceInstall;
            anchors.left: parent.left;
            anchors.leftMargin: 13;
            text: qsTr("Install background");
            //platformInverted: true;
            checked: settings.silenceInstall;
            onClicked: {
                if(settings.silenceInstall){
                    settings.silenceInstall = false;
                }
                else settings.silenceInstall = true;
            }
        }
        SettingsItem{
            //platformInverted: true;
            title: qsTr("Download save path");
            subTitle: settings.downloadPath;
            onClicked:{
                fileDialog.inverseTheme = true//设置主题模式
                fileDialog.chooseMode = FilesDialog.IndividualChoice
                fileDialog.chooseType = FilesDialog.FolderType
                fileDialog.exec(settings.downloadPath, FilesDialog.Dirs|FilesDialog.Drives)
                var file = fileDialog.firstSelection()
                if(file)
                    settings.downloadPath =file.filePath;
            }
        }
        /*SettingsItem{
            //platformInverted: true;
            title: qsTr("Installation driver");
            subTitle: settings.installDriver;
            onClicked:{
                fileDialog.inverseTheme = true//设置主题模式
                fileDialog.chooseMode = FilesDialog.IndividualChoice
                fileDialog.chooseType = FilesDialog.DriveType
                fileDialog.canOpenSystemDrive = false;
                fileDialog.exec(settings.installDriver, FilesDialog.Drives)
                var file = fileDialog.firstSelection()
                if(file)
                    settings.installDriver =file.filePath;
            }
        }*/
        Item{
            height: 27;
            width: 1;
        }
        Button{
            //anchors.topMargin: 20;
            //platformInverted: true;
            width: 400;
            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("Check new version");
            onClicked: {
                Script.getversion("Meego", "9store");
            }
        }
    }
    NewVersionDialog{
            id: newversiondialog;
        }

        Component.onCompleted: {
            Script.installSettingPage = installsettingpage;
        }
}
