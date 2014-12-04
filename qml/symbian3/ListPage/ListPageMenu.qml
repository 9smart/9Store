// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
MenuLayout{
    MenuItem{
        platformInverted:true;
        text: qsTr("search");
        onClicked: pageStack.push(Qt.resolvedUrl("../SearchPage.qml"))
    }
    MenuItem{
        platformInverted:true;
        text: qsTr("search by the author");
        onClicked: uiddia.open();
    }
    MenuItem{
        platformInverted:true;
        text: qsTr("Settings");
        onClicked: pageStack.push(Qt.resolvedUrl("../SettingPage.qml"));
    }
    MenuItem{
        platformInverted:true;
        text: qsTr("Download Page");
        onClicked:{
            pageStack.push(Qt.resolvedUrl("../DownloadPage.qml"));
        }
    }
}
