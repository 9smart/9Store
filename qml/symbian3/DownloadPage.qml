import QtQuick 1.1
import com.nokia.symbian 1.1
import "BaseComponent"
import "Delegate"
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
        personalButtonVisible: false;
        highlightItem: 0;
        onBackButtonClicked: pageStack.pop();
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
        anchors.centerIn: parent;
    }
    ListView{
        id:downloadview;
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
    Component.onCompleted:downloadview.count===0?emptyLabel.visible=true:emptyLabel.visible=false;
}
