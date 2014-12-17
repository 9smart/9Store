// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "main"
import "MainPage"
MyPage{
    id:mainpage;
    Head{
        id:head;
        titleText: qsTr("Home");
    }
    ToolBar{
        id:toolbar;
        onBackButtonClicked: {
            if(quitTimer.running)
              {
               saveDownloadData();
               Qt.quit();
              }
            else
                {
                 infoBanner.text=qsTr("Please click again to quit");
                 infoBanner.open();
                 quitTimer.start();
                }
        }
        Timer
             {
              id: quitTimer;
              interval: 3000;
              running: false;
              repeat: false;
             }
    }
}
