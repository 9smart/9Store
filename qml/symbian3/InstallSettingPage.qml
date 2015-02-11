import QtQuick 1.1
import com.nokia.symbian 1.1
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
        }
        spacing: 20;
        CheckBox {
            text: qsTr("Install autoly when download finish");
            platformInverted: true;
            //checked: 00;
            //onClicked: 00;
        }
        SelectionListItem{
            platformInverted: true;
            title: qsTr("Download save path");
            subTitle: downloadpath;
            onClicked:{
                downloadpath=(fileoperate.selectFolder()||settings.getDownloadPath());
                settings.setDownloadPath(downloadpath);
            }
        }
        SelectionListItem{
            platformInverted: true;
            title: qsTr("Installation path");
            subTitle: "E://";
            /*onClicked:{
                downloadpath=(fileoperate.selectFolder()||settings.getDownloadPath());
                settings.setDownloadPath(downloadpath);
            }*/
        }
        Button{
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
