// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import "Main"
import "../JavaScript/main.js" as Script
PageStackWindow{
    id:app;
    property string version:"0.5.1";
    property bool loading;
    property string downloadpath: settings.getDownloadPath();

    property int userstate:0;
    property string uid;
    property string accesstoken;
    property string nickname;
    property string avatar;
    property string gender;
    property string logintype;
    style: PageStackWindowStyle{}
    ListPage{
        id: listpage;
    }
    InfoBanner{
        topMargin: 40;
        id: infoBanner;
    }
    LoadingIndicator{
        id:loadingind;
    }
    SignalCenter{
        id: signalCenter;
    }
    Timer{
        id:processingtimer;
        interval: 60000;
        onTriggered: signalcenter.loadFailed("erro");
    }
    ListModel{
        id:downloadmodel;
    }
    Connections{
        target: signalCenter;
        onLoadStarted:{
            app.loading=true;
            loadingind.open();
            processingtimer.restart();
        }
        onLoadFinished:{
            app.loading=false;
            loadingind.close();
            processingtimer.stop();
        }
        onLoadFailed:{
            app.loading=false;
            loadingind.close();
            processingtimer.stop();
            signalCenter.showMessage(errorstring);
        }
    }
    /*Loader
                      {
                       id:launchloader;
                       anchors.fill: parent;
                       source: "Component/Launcher.qml";
                      }
                Connections
                           {
                            target: launchloader.item;
                            onNChanged:launchloader.item.n===6?launchloader.source="":"";
                           }*/
    Component.onCompleted:{
        Script.setsignalcenter(signalCenter);
        loadLoginData(userdata.getUserData("LoginData"));
        loadDownloadData(userdata.getUserData("DownloadData"));
        pageStack.push(listpage);
    }
    function saveDownloadData() {
        var arry=[];
        for(var i=0;i<downloadmodel.count;i++) {
            arry.push(downloadmodel.get(i));
        }
        var obj={"statuses": arry}
        userdata.setUserData("DownloadData",JSON.stringify(obj));
    }
    function loadDownloadData(oritxt) {
        if(!oritxt)
            oritxt="{\"statuses\":[]}";
        var obj=JSON.parse(oritxt);
        downloadmodel.clear();
        for(var i in obj.statuses) {
            downloadmodel.append(obj.statuses[i]);
        }
    }
    function loadLoginData(oritxt) {
        if(!oritxt) {
            return;
        }
        var obj=JSON.parse(oritxt);
        uid=obj.uid;
        accesstoken=obj.accesstoken;
        nickname=obj.nickname;
        avatar=obj.avatar;
        gender=obj.gender;
        logintype=obj.logintype;
        userstate=1;
    }
}
