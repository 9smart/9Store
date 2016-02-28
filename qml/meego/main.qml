// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import QtMobility.systeminfo 1.1
import "../JavaScript/main.js" as Script
import "../JavaScript/deviceModel.js" as Device
import "BaseComponent"
import "Delegate"
PageStackWindow{
    id:app;
    property string version:"1.1.0";
    property bool loading;

    property string deviceModel: Device.deviceModel(deviceinfo.productName);

    property alias user: user;
    property alias downloadModel: downloadmodel;

    DeviceInfo{
        id: deviceinfo;
        Component.onCompleted: console.log(productName)
    }

    User{
        id:user;
    }
    InfoBanner{
        id: infoBanner;
        z: 1011;
    }
    StatusBar{
        id: statusbar;
        //Component.onCompleted: console.log(statusbar.z)
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
    Timer{
        id: noticetimer;
        interval: 300000;
        triggeredOnStart: true;
        repeat: true;
        //running: true;
        running: false;
        onTriggered: {
            if(user.userState){
                Script.noticeListPage = "";
                Script.getNotices(user.auth, Script.noticeListPage, "12");
            }
        }
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
    FirstOpenSplash{
        id: firestopensplash;
    }

    Component.onCompleted:{
        Script.initialize(signalCenter, utility, userdata, settings, downloader);
        Script.application = app;

        console.log(settings.versionCode)
        if(settings.versionCode < 3){
            splash.visible = false;
            firestopensplash.open();
            userdata.clearUserData("UserData");         //1.1.0
            settings.versionCode = 2;
            settings.saveSettings();
        }

        Script.loadUserInfo(userdata.getUserData("UserData"));


        loadDownloadData(userdata.getUserData("DownloadData"));
        pageStack.push(Qt.resolvedUrl("MainPage.qml"));

        //app.showStatusBar = false
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

}
