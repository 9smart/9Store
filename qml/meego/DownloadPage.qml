import QtQuick 1.1
import com.nokia.meego 1.1
import "BaseComponent"
import "Delegate"
import "Dialog"
import "../JavaScript/main.js" as Script
MyPage{
    id:downloadpage;
    title: qsTr("Download");
    ToolBar{
        id:toolbar;
        z:1;
        homeButtonVisible: false;
        topChartsButtonVisible: false;
        searchButtonVisible: false;
        //personalButtonVisible: false;
        personalSource: "../pic/Personal/icon-m-toolbar-delete.png";
        highlightItem: 0;
        onBackButtonClicked: pageStack.pop();
        onPersonalButtonClicked: {
            cleardownloaddialog.open();
        }
    }
    Head{
        id: head;
        titleText: title;
        z: 1;
    }
    Text{
        id: emptyLabel;
        text: qsTr("The download list is empty");
        color: "Grey";
        font.pixelSize: 36;
        anchors.centerIn: parent;
    }
    ListView{
        id:listview;
        anchors{
            top: head.bottom;
            left: parent.left;
            right: parent.right;
            bottom: toolbar.top;
        }
        clip: true;
        model: downloadmodel;
        delegate: DownloadComponent{}
    }
    ClearDownloadDialog{
        id: cleardownloaddialog;
    }

    Component.onCompleted:listview.count===0?emptyLabel.visible=true:emptyLabel.visible=false;
}
