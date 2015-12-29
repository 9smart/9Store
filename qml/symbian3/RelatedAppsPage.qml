// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../JavaScript/main.js" as Script
import "BaseComponent"
import "Delegate"
MyPage{
    id:relatedappspage;
    property string category;
    property bool firstStart: true;
    property ListModel relatedlistmodel;
    onVisibleChanged: if (visible && firstStart) {
                          firstStart = false;
                          Script.infoListPage = "";
                          Script.getrelatedlist("Symbian%5e3", category, Script.infoListPage, "12");
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
        anchors.bottomMargin: toolbar.height;
        clip:true;
        model: relatedlistmodel;
        delegate:ListComponent{ id:listdelegate; }
        footer: ListFooter{
            id: listfooter;
            onClicked: {
                if(Script.infoListPage !== "NULL"){
                    Script.getrelatedlist("Symbian%5e3", category, Script.infoListPage, "12");
                }
                else{
                    signalCenter.showMessage(qsTr("No next page aviliable..."))
                }
            }
        }
    }
}
