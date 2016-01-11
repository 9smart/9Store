// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
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
            topMargin: 27;
            horizontalCenter: parent.horizontalCenter;
        }
        width: parent.width - 40;
        Row{
            spacing: 20;
            Image{
                //height: 67;
                //width: 67;
                sourceSize: Qt.size(67, 67);
                source: "../pic/9-MeeGo.png";
                smooth: true;
            }
            Text{
                anchors.verticalCenter: parent.verticalCenter;
                text: qsTr("Account");
                font.pixelSize: 40;
            }
        }
        Item{
            height: 27;
            width: parent.width;
        }
        Text{
            font.pixelSize: 32;
            text: qsTr("Login to your account");
            color: "#3c3c3c";
        }
        Item{
            height: 20;
            width: parent.width;
        }
        Text{
            text: qsTr("9Smart ID");
            font.pixelSize: 19;
            color: "#777777";
        }
        TextField{
            id:username;
            width: 440;
        }
        Item{
            height: 13;
            width: parent.width;
        }
        Text{
            text: qsTr("Password");
            font.pixelSize: 19;
            color: "#777777";
        }
        TextField{
            id:password;
            width: 440;
            echoMode: TextInput.Password;
        }
        Item{
            height: 13;
            width: parent.width;
        }
        Text{
            font.pixelSize: 19;
            color: "#1080dd";
            font.underline: true;
            //text: qsTr("Forgot your password?");
        }
        Item{
            height: 40;
            width: parent.width;
        }
        Button{
            anchors.horizontalCenter: parent.horizontalCenter;
            //platformInverted: true;
            text: qsTr("Log in");
            width: 353;
            onClicked: {
                Script.logIn(username.text, password.text);
            }
        }
        Item{
            height: 47;
            width: parent.width;
        }
        Text{
            anchors.horizontalCenter: parent.horizontalCenter;
            font.pixelSize: 19;
            color: "#777777";
            text: qsTr("Don't have an account yet?");
        }
        Text{
            anchors.horizontalCenter: parent.horizontalCenter;
            font.pixelSize: 19;
            color: "#1080dd";
            font.underline: true;
            text: qsTr("Get one here");
            MouseArea{
                anchors.fill: parent;
                anchors.margins: -10;
                onClicked: pageStack.push(Qt.resolvedUrl("RegisterPage.qml"));
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
