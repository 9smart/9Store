/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.4

import "pages"
import "pages/components"
import "js/login.js" as UserData
import "js/main.js" as Script
import "js/download.js" as Down
ApplicationWindow
{
    id:window
    property string version:"0.5.1";
    property bool loading;
    property int userstate:0;
    property string uid;
    property string accesstoken;
    property string nickname;
    property string avatar;
    property string gender;
    property string logintype;
    property string os_type:"sailfish"
    property var downList: [];
    property var testPy;
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    Component.onCompleted:{
            Script.setsignalcenter(signalCenter);
            UserData.initialize();
            Down.initialize();
            UserData.getValue();
            //loadLoginData(accesstoken);
         pageStack.push(Qt.resolvedUrl("pages/WelcomePage.qml"));
        }

    //检查用户登录状态
    function checkStatus(userstate){
        if(userstate === 0){
            toLoginPage();
        }
    }

    //跳到登录页面
    function toLoginPage(){
         pageStack.push(Qt.resolvedUrl("pages/UserCenter.qml"));
    }

    function loadLoginData(oritxt) {
        //console.log("oritxt:"+oritxt);
            if(!oritxt) {
                console.log("->UserCenter")
               toLoginPage();
            }
            var obj=JSON.parse(oritxt);
            uid=obj.uid;
            accesstoken=obj.accesstoken;
            nickname=obj.nickname;
            avatar=obj.avatar2;
            gender=obj.gender;
            logintype=obj.logintype;
            userstate=1;
            //pageStack.push(Qt.resolvedUrl("pages/HotList.qml"));
            pageStack.push(Qt.resolvedUrl("pages/WelcomePage.qml"));
        }

    //status:0未安装，1已安装，2已卸载
    function updateDownloadList(appid,appname,downPath,icon,status){
        Down.updateDown(appid,appname,downPath,icon,status);
    }

    Connections{
            target: signalCenter;
            onLoadStarted:{
                window.loading=true;
                //loadingind.open();
                processingtimer.restart();
            }
            onLoadFinished:{
                window.loading=false;
                //loadingind.close();
                processingtimer.stop();
            }
            onLoadFailed:{
                window.loading=false;
                //loadingind.close();
                processingtimer.stop();
                signalCenter.showMessage(errorstring);
            }
        }
    Signalcenter{
           id: signalCenter;
       }

    InfoBanner { id: infoBanner; }



    Timer{
        id:processingtimer;
        interval: 60000;
        onTriggered: signalCenter.loadFailed(qsTr("error"));
    }

    function downloadRpms(downurl,downloadname){
        var flag = false;
        function call(){
            downloadstat = py.downloadRpm(downloadname,downurl)
        }
    }


    Python { // this component represents the python object and can be called from anywhere in the application. pretty much anything that is defined in this (top) file can be called by any other page
        id: py // the id that can be then called

        Component.onCompleted: { // this action is triggered when the loading of this component is finished
            addImportPath(Qt.resolvedUrl('./py')); // adds import path to the directory of the Python script
            py.importModule('mypy', function () { // imports the Python module
//                py.call('mypy.test',[],function(result){
//                    testPy = result
//                })
            });
        }

        //注册安装方法
        function installRpm(rpmPath){
            console.log("Path:"+rpmPath)
            call('mypy.install',[rpmPath],function(result){
                return result
            })
        }
        //注册获取已经安装的程序
        function getInstalledApps(){
            console.log("get installed apps")
            call('mypy.getInstalledApps',[],function(result){
                console.log("Apps:",result)


            })
        }

        //注册检查是否需要更新方法
        function checkInstalled(appname){
            console.log("check is installed ",appname)
            call('mypy.checkInstalled',[appname],function(result){
                return result
            })
        }

        //注册下载文件方法
        function downloadRpm(downname,downurl){
            console.log("starting download...")
            call('mypy.downloadRpm',[downname,downurl],function(result){
                return result
            })
        }

        onError: signalCenter.showMessage(traceback)

        //定义消息规则
        //0,开始下载
        //1,下载完成，开始安装
        //2,安装完成
        //3,升级成功
        //4,卸载完成
        onReceived: {
            console.log('Event: ' + data);
            var sendMsg="";
            switch(data.toString()){
            case "0":
                sendMsg=qsTr("Begin download")
                break;
            case "1":
                sendMsg=qsTr("Downloaded,Installing")
                break;
            case "2":
                sendMsg=qsTr("Installed")
                break;
            case "3":
                sendMsg=qsTr("Updated")
                break;
            case "4":
                sendMsg=qsTr("Removed")
            default:
                sendMsg=qsTr("Unknown")
            }

            signalCenter.showMessage(sendMsg)
        }
    }
}




