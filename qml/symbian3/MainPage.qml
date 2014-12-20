// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "main"
import "MainPage"
import "../JavaScript/main.js" as Script
MyPage{
    id:mainpage;
    title: qsTr("Home");
    Head{
        id:head;
        titleText: title;
        z:1;
    }
    ToolBar{
        id:toolbar;
        z:1;
        onBackButtonClicked: {
            if(quitTimer.running)
              {
               saveDownloadData();
               Qt.quit();
              }
            else
                {
                 infoBanner.text=qsTr("Please click again to quit");
                 infoBanner.open();
                 quitTimer.start();
                }
        }
        onHomeButtonClicked: {
            content.source="MainPage/HomeContent.qml";
            title=qsTr("Home");
        }
        onTopchartsButtonClicked: {
            content.source="MainPage/TopChartsContent.qml";
            title=qsTr("Top");
        }
        onSearchButtonClicked: {
            content.source="MainPage/SearchContent.qml";
            title=qsTr("Library");
        }
        Timer
             {
              id: quitTimer;
              interval: 3000;
              running: false;
              repeat: false;
             }
    }
    Loader{
        id:content;
        anchors.top: head.bottom;
        anchors.bottom: toolbar.top;
        width: parent.width;
        source: "MainPage/HomeContent.qml";
    }
    ListModel{
        id:covermodel;
    }
    ListModel{
        id:listmodel;
    }
    Component.onCompleted: {
        Script.covermodel=covermodel;
        Script.listmodel=listmodel;
    }
}
