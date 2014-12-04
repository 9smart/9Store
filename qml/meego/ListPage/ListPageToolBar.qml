// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
ToolBarLayout{
    ToolIcon{
        platformIconId: "toolbar-close";
        onClicked:{
            if(quitTimer.running){
                saveDownloadData();
                Qt.quit();
            }
            else{
                infoBanner.text=qsTr("Please click again to quit");
                infoBanner.show();
                quitTimer.start();
            }
        }
    }
    Button{
        width: 200;
        text: qsTr ("category");
        onClicked:{
            categorymenu.open();
        }
        enabled: type!="";
    }
    ToolIcon{
        platformIconId: "toolbar-view-menu"
        onClicked: mainmenu.open();
    }
    Timer{
        id: quitTimer;
        interval: 3000;
        running: false;
        repeat: false;
    }
}
