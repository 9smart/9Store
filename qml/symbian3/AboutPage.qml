// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "BaseComponent"
MyPage{
    id:aboutpage;
    property string newversion;
    title: qsTr("About");
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
    Head{
        id:head;
        titleText: title;
    }
    Flickable{
        anchors{
            fill: parent;
            topMargin: head.height;
            bottomMargin: toolbar.height;
        }
        flickableDirection: Flickable.VerticalFlick
        contentHeight: column.height+15;
        clip: true;
        Column{
            id:column;
            anchors{
                verticalCenter: parent.verticalCenter;
                left: parent.left;
                right: parent.right;
                margins: 15;
            }
            spacing: 20;
            Text{
                anchors.left: parent.left;
                anchors.right: parent.right;
                wrapMode: Text.WrapAnywhere;
                text:qsTr("about*****************text") ;
            }
            Button{
                platformInverted: true;
                width: 300;
                anchors.horizontalCenter: parent.horizontalCenter;
                text: qsTr("Check for new version");
                onClicked: Script.getversion();
            }
        }
    }

}
