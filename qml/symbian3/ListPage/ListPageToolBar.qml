// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
ToolBarLayout
             {
              ToolButton
                        {
                         platformInverted: true;
                         iconSource: "toolbar-back";
                         onClicked:
                                  {
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
                        }
              ToolButton
                        {
                         text:qsTr("category");
                         onClicked:categorymenu.open();
                         enabled: type!=="";
                         platformInverted: true;
                        }
              ToolButton
                        {
                         platformInverted:true;
                         iconSource: "toolbar-menu";
                         onClicked: mainmenu.open();
                        }
              Timer
                   {
                    id: quitTimer;
                    interval: 3000;
                    running: false;
                    repeat: false;
                   }
             }
