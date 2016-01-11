import QtQuick 1.1
QtObject
        {
         id:signalcenter;
         signal loadStarted;
         signal loadFinished;
         signal loadFailed(string errorstring);


         signal dlUrlGeted;
         signal dlInfoSetted;
         signal fileHashGeted;
         signal versionGeted;
         signal commentSendSuccessful;
         signal commentSendFailed(string errorstring);
         function showMessage(msg)
                 {
                  if (msg||false)
                    {
                     infoBanner.text = msg;
                     //infoBanner.open();
                      infoBanner.show();
                    }
                 }
        }
