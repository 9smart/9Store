// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "../JavaScript/main.js" as Script
import "BaseComponent"
PageStackWindow{
    id: app;
    property string version:"0.5.1";
    property bool loading;

    property string downloadpath: settings.getDownloadPath();
    property string installdriver: settings.getInstallDriver();
    property bool autoInstall:settings.autoInstall;

    property alias user: user;

    platformInverted: true;
    User{
        id:user;
    }
    Corners{
        id:corners;
    }   
    InfoBanner{
        id: infoBanner;
    }
    LoadingIndicator{
        id:loadingind;
    }
    Splash{
        id:splash;
    }
    SignalCenter{
        id: signalCenter;
    }
    Timer{
        id:processingtimer;
        interval: 60000;
        onTriggered: signalCenter.loadFailed("erro");
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

    Component.onCompleted:{
        Script.setsignalcenter(signalCenter);
        Script.app = app;
        loadUserData(userdata.getUserData("UserData"));
        loadDownloadData(userdata.getUserData("DownloadData"));        
        pageStack.push(Qt.resolvedUrl("MainPage.qml"));
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
    function savaUserData(){
        console.log(here);
        var obj = {"_id": user._id, "auth": user.auth, "nickname": user.nickName, "avatar": user.avatar, "avatar_hd": user.avatar_hd};
        userdata.setUserData("UserData", JSON.stringify(obj));
        console.log("here" + JSON.stringify(obj))
    }

    function loadUserData(oritxt) {
        if(!oritxt) {
            return;
        }
        console.log(oritxt);
        var obj=JSON.parse(oritxt);
        user._id = obj._id;
        user.auth = obj.auth;
        user.nickName = obj.nickname;
        user.avatar = obj.avatar;
        user.avatar_hd = obj.avatar_hd;
        user.userState = true;
    }
}
