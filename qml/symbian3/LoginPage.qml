// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import QtWebKit 1.0
import "../JavaScript/main.js" as Script
import "BaseComponent"
MyPage
      {
       id:loginpage;
       title:qsTr("log in");
       property string weburl;
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
       WebView
              {
               Text
                   {
                    height: 100;
                    width: 100;
                    text: parent.progress;
                    anchors.top: parent.top;
                    anchors.bottom:parent.bottom;
                    opacity: 0.5;
                   }
               anchors.fill: parent;               
               preferredHeight: parent.height;
               preferredWidth: parent.width;
               url:"http://www.9smart.cn/member/login";
               smooth: true;
               onLoadFinished:
                             {
                              weburl=url;
                              if(weburl.length>33&&weburl.substring(0,33)==="http://www.9smart.cn/member/login")
                                {
                                 var obj=JSON.parse(title);
                                 uid=obj.uid;
                                 accesstoken=obj.accesstoken;
                                 nickname=obj.nickname;
                                 avatar=obj.avatar;
                                 gender=obj.gender;
                                 logintype=obj.logintype;
                                 userstate=1;
                                 userdata.setUserData("LoginData",title);
                                 signalCenter.showMessage(qsTr("Login success!"));
                                 pageStack.pop();
                                }
                             }
              }
      }
