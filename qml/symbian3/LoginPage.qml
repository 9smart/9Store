// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import QtWebKit 1.0
import "../JavaScript/main.js" as Script
import "BaseComponent"
MyPage{
    id:loginpage;
    title:qsTr("log in");
    property MyPage mainPage;
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
    Column{
        anchors{
            top: parent.top;
            topMargin: 20;
            horizontalCenter: parent.horizontalCenter;
        }
        width: parent.width - 30;
        Row{
            spacing: 15;
            Image{
                height: 50;
                width: 50;
                source: "../pic/9-Symbian.svg";
                smooth: true;
            }
            Text{
                anchors.verticalCenter: parent.verticalCenter;
                text: qsTr("Account");
            }
        }
        Item{
            height: 20;
        }
        Text{
            font.pixelSize: 30;
            text: qsTr("Login to your account");
        }
        Item{
            height: 15;
        }
        Text{
            text: qsTr("9Smart ID");
            font.pixelSize: 18;
        }
        TextField{
            id:username;
            width: 300;
        }
        Item{
            height: 10;
        }
        Text{
            text: qsTr("Password");
            font.pixelSize: 18;
        }
        TextField{
            id:password;
            width: 300;
        }
        Item{
            height: 10;
        }
        Text{
            font.pixelSize: 20;
            text: qsTr("Forgot your password?")
        }
        Item{
            height: 30;
        }
        Button{
            anchors.horizontalCenter: parent.horizontalCenter;
            platformInverted: true;
            text: qsTr("Log in");
            onClicked: {
                Script.logIn(username.text, password.text);
            }
        }
    }
    Connections{
        target: app.user;
        onUserStateChanged:{
            if(app.user.userState === true){
                mainPage.toolBar.personalButtonClicked();
                pageStack.pop();
            }
        }
    }
}
