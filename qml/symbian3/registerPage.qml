// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../JavaScript/main.js" as Script
import "BaseComponent"

MyPage{
    id:registerpage;
    title: qsTr("Register");
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
                source: "../pic/9-Symbian2.svg";
                smooth: true;
            }
            Text{
                anchors.verticalCenter: parent.verticalCenter;
                text: qsTr("Account");
                font.pixelSize: 30;
            }
        }
        Item{
            height: 20;
            width: parent.width;
        }
        Text{
            font.pixelSize: 24;
            text: qsTr("Creat a new account");
            color: "#3c3c3c";
        }
        Item{
            height: 15;
            width: parent.width;
        }
        Text{
            text: qsTr("9Smart ID");
            font.pixelSize: 14;
            color: "#777777";
        }
        TextField{
            id:username;
            placeholderText: qsTr("e-mail address");
            width: 330;
        }
        Item{
            height: 10;
            width: parent.width;
        }
        Text{
            text: qsTr("User name");
            font.pixelSize: 14;
            color: "#777777";
        }
        TextField{
            id:nickname;
            width: 330;
        }
        Item{
            height: 10;
            width: parent.width;
        }
        Text{
            text: qsTr("Password");
            font.pixelSize: 14;
            color: "#777777";
        }
        Row{
            spacing: 12;
            TextField{
                id:password;
                width: 280;
                echoMode: showpassword.checked? TextInput.Normal:TextInput.Password;
            }
            CheckBox{
                id: showpassword;
                platformInverted: true;
                //Component.onCompleted: console.log(width);
            }
        }
        Item{
            height: 10;
            width: parent.width;
        }
        Text{
            font.pixelSize: 14;
            color: "#777777";
            anchors.right: parent.right;
            text: qsTr("Show password");
        }
        Item{
            height: 30;
            width: parent.width;
        }
        Button{
            anchors.horizontalCenter: parent.horizontalCenter;
            platformInverted: true;
            text: qsTr("Continue");
            width: 265;
            onClicked: {
                if(Script.isEmail(username.text)){
                    Script.sendRegister(username.text, nickname.text, password.text);
                }
                else{
                    signalCenter.showMessage(qsTr("Please input the correct e-mail address"));
                }
            }
        }
        Item{
            height: 35;
            width: parent.width;
        }
        Text{
            anchors.horizontalCenter: parent.horizontalCenter;
            font.pixelSize: 14;
            color: "#777777";
            text: qsTr("Have an account?");
        }
        Text{
            anchors.horizontalCenter: parent.horizontalCenter;
            font.pixelSize: 14;
            color: "#1080dd";
            font.underline: true;
            text: qsTr("Click to login");
            MouseArea{
                anchors.fill: parent;
                onClicked: pageStack.pop();
            }
        }
    }
    Connections{
        target: app.user;
        onUserStateChanged:{
            if(app.user.userState === true){
                //mainPage.toolBar.personalButtonClicked();
                pageStack.pop();
            }
        }
    }
}
