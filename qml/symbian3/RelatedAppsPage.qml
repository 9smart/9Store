// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../JavaScript/main.js" as Script
import "BaseComponent"
import "Delegate"
MyPage{
    id:relatedappspage;
    property string appid;
    property string category;
    property int page:1;
    property bool firstStart: true;
    onVisibleChanged: if (visible && firstStart) {
                          firstStart = false
                          Script.getrelatedlist("belle",page.toString(),"15",appid,category);
                      }
    title: qsTr("Related apps");
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
    ListView{
        id:listview;
        anchors.fill:parent;
        anchors.topMargin: head.height;
        clip:true;
        model: ListModel{ id:relatedlistmodel; }
        delegate:ListComponent{ id:listdelegate; }
        footer: ListFooter{}
    }
    Component.onCompleted:{
        Script.relatedlistmodel=relatedlistmodel;
    }
}
