import QtQuick 1.0
import com.nokia.symbian 1.0
import QtWebKit 1.0
import "../JavaScript/main.js" as Script
import "Main"

MyPage {
    id:loginpage;
    title:qsTr("log in");
    property string weburl;
    tools: ToolBarLayout {
        ToolButton {
            iconSource: privateStyle.toolBarIconPath("toolbar-back");
            //platformInverted: true;
            onClicked: pageStack.pop();
        }
    }
    WebView {
        Rectangle {
            id: loadProgress;
            width: parent.width; height: 5;
            color: "White";
            visible: parent.progress != 1;
            Rectangle {
                width: parent.width * parent.parent.progress;
                height: parent.height;
                anchors.left: parent.left;
                color: "LightBlue";
            }
        }
        anchors.fill: parent;
        url: "http://www.9smart.cn/member/login";
        smooth: true;
        onLoadStarted: loadProgress.visible = true;
        onLoadFinished: {
            weburl = url;
            if(weburl.length>33&&weburl.substring(0,33)==="http://www.9smart.cn/member/login") {
                loadProgress.visible = false;
                console.log(html);
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
