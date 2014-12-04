// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
MenuLayout{
    MenuItem{
        text: qsTr("Search");
        onClicked: pageStack.push(Qt.resolvedUrl("../SearchPage.qml"));
    }
    MenuItem{
        text: qsTr("search by the author");
        onClicked: uiddia.open();
    }
    MenuItem{
        text: qsTr("settings");
        onClicked:pageStack.push(Qt.resolvedUrl("../SettingPage.qml"));
    }
    MenuItem{
        text: qsTr("Download Page");
        onClicked:{
            pageStack.push(Qt.resolvedUrl("../DownloadPage.qml"));
        }
    }
}
