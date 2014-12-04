import QtQuick 1.0
import com.nokia.symbian 1.0
import com.nokia.extras 1.0
import "../JavaScript/main.js" as Script
import "Main"

PageStackWindow {
    id:app;
    property string version:"0.5.0";
    property bool loading;        
    property string downloadpath: settings.getDownloadPath();

    property int userstate:0;
    property string uid;
    property string accesstoken;
    property string nickname;
    property string avatar;
    property string gender;
    property string logintype;
    //platformInverted: true;

    Constant {
        id: constant;
    }
    ListPage{
        id: listpage;
    }
    InfoBanner{
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
        Script.system = "s60v5";
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
