import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
import QtWebKit.experimental 1.0
import "../js/login.js" as Script
import "components"
Page{
    id:loginpage;
        property string weburl;
    PageHeader{
        title:qsTr("log in");
    }
    SilicaWebView{
        Text{
            height: 100;
            width: 100;
            text: parent.progress;
            anchors.top: parent.top;
            anchors.bottom:parent.bottom;
        }
        anchors.fill: parent;
        preferredHeight: parent.height;
        preferredWidth: parent.width;
        url:"http://www.9smart.cn/member/login";
        smooth: true;
        onLoadFinished:{
            weburl=url;
            if(weburl.length>33&&weburl.substring(0,33)==="http://www.9smart.cn/member/login"){
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
