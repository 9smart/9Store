import QtQuick 1.0
import com.nokia.symbian 1.0

ToolBarLayout {
    ToolButton {
        //platformInverted: true;
        iconSource: privateStyle.toolBarIconPath("toolbar-back");
        onClicked: {
            console.log(iconSource);
            if(quitTimer.running) {
                saveDownloadData();
                Qt.quit();
            } else {
                infoBanner.text=qsTr("Please click again to quit");
                infoBanner.open();
                quitTimer.start();
            }
        }
    }
    ToolButton {
        text:qsTr("category");
        onClicked:categorymenu.open();
        enabled: type!=="";
        //platformInverted: true;
    }
    ToolButton {
        //platformInverted:true;
        iconSource: privateStyle.toolBarIconPath("toolbar-menu");
        onClicked: mainmenu.open();
    }
    Timer {
        id: quitTimer;
        interval: 3000;
        running: false;
        repeat: false;
    }
}
