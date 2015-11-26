// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "BaseComponent"
import "MainPage"
import "../JavaScript/main.js" as Script
MyPage{
    id:mainpage;
    property string currentContent:"Home";
    title: qsTr("Home");
    Head{
        id:head;
        titleText: title;
        z:1;
    }
    ToolBar{
        id:toolbar;
        z:2;
        onBackButtonClicked: {
            if(currentContent==="Search"){
                if(content.item.currentContent==="CategoryContent.qml"){
                    content.item.currentContent="LibraryContent.qml";
                }
                else if(content.item.currentContent==="ListContent.qml"){
                    content.item.currentContent="CategoryContent.qml";
                }
                else if(quitTimer.running){
                    saveDownloadData();
                    Qt.quit();
                }
                else{
                    infoBanner.text=qsTr("Please click again to quit");
                    infoBanner.open();
                    quitTimer.start();
                }
            }
            else if(quitTimer.running){
                saveDownloadData();
                Qt.quit();
            }
            else {
                infoBanner.text=qsTr("Please click again to quit");
                infoBanner.open();
                quitTimer.start();
            }
        }
        onHomeButtonClicked: {
            content.z=0;
            content.source="MainPage/HomeContent.qml";
            title=qsTr("Home");
            currentContent="Home";
        }
        onTopchartsButtonClicked: {
            content.z=0;
            content.source="MainPage/TopChartsContent.qml";
            title=qsTr("Top");
            currentContent="Top";
        }
        onSearchButtonClicked: {
            content.z=1;
            content.source="MainPage/SearchContent.qml";
            title=qsTr("Library");
            currentContent="Search";
        }
        onPersonalButtonClicked: {
            if(userstate!==0){
                content.z=0;
                content.source="MainPage/PersonalContent.qml";
                title=qsTr("My Stuff");
                currentContent="Personal";
            }
            else pageStack.push(Qt.resolvedUrl("LoginPage.qml"))
        }
        Timer{
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
        id:featuredmodel;
    }
    ListModel{
        id:listmodel;
    }
    Component.onCompleted: {
        Script.covermodel=covermodel;
        Script.featuredmodel=featuredmodel;
        Script.listmodel=listmodel;
    }
}
