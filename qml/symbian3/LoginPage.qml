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
        anchors.centerIn: parent;
        spacing: 20;
        TextField{
            id:username;
            width: 300;
        }
        TextField{
            id:password;
            width: 300;
            echoMode: TextInput.Password;
        }
        Button{
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
