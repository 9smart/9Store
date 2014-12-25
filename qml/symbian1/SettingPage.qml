import QtQuick 1.0
import "Main"
import "SettingPage"
import "../JavaScript/main.js" as Script
import com.nokia.symbian 1.1

MyPage {
    id:downloadpage;
    property string newversion;
    tools: ToolBarLayout {
        ToolButton {
            iconSource: privateStyle.toolBarIconPath("toolbar-back");
            onClicked: pageStack.pop();
            platformInverted: true;
        }
    }
    AboutDialog {
        id:aboutdia;
    }
    Head {
        id:head;
        z:1;
        Image {
            id:icon;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: parent.left;
            anchors.leftMargin: 15;
            height: 45;
            width: 45;
            smooth: true;
            source: "Resource/icon.svg";
        }
        Text {
            text: qsTr("Settings");
            font.pixelSize: 24;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: icon.right;
            anchors.rightMargin: 15;
        }
    }
    Column {
        id:scolumn;
        anchors.top: head.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right;
        spacing: 20;
        SelectionListItem {
            platformInverted: true;
            title: qsTr("Download save path");
            subTitle: downloadpath;
            onClicked: {
                downloadpath=(fileoperate.selectFolder()||settings.getDownloadPath());
                settings.setDownloadPath(downloadpath);
            }
        }
        Button {
            platformInverted: true;
            width: 280;
            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("Check for new version");
            onClicked: Script.getversion();
        }
        Button {
            platformInverted: true;
            width:280;
            anchors.horizontalCenter: parent.horizontalCenter;
            text: qsTr("About");
            onClicked: aboutdia.open();
        }
    }
    QueryDialog {
        id:verquerydia;
        platformInverted: true;
        titleText: qsTr("New version has been found")
        message: qsTr("Whether to download the new version?");
        acceptButtonText: qsTr("Yes");
        rejectButtonText: qsTr("No");
        onAccepted: {
            var file=downloadpath+"105.sis";
            downloadmodel.append({"icon":"http://yayabo-s1.stor.sinaapp.com/png/201410/14128173469x5.thumb.png","name":"久店","url":"http://api.9smart.cn/app/105?download=download","file":file});
            qcurl.appenddl("http://api.9smart.cn/app/105?download=download",file);
            signalCenter.showMessage(qsTr("Download appended!"));
        }
    }
    Connections {
        target: signalCenter;
        onVersionGeted: {
            newversion=Script.version;
            if(Script.isnew(version,newversion)) {
                signalCenter.showMessage(qsTr("This version is the newest version!"));
            }
            else
                verquerydia.open();
        }
    }
}
