// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "../../JavaScript/main.js" as Script
CommonDialog
            {
             id:uiddia;
              platformInverted: true;
              titleText:qsTr("pleas input the authorname");
              buttonTexts:[qsTr("OK"),qsTr("Cancel")];
              content: TextField
                                {
                                 id:uid;
                                 anchors.verticalCenter: parent.verticalCenter;
                                 anchors.horizontalCenter:parent.horizontalCenter;
                                 width: parent.width - 16;
                                 placeholderText:qsTr("pleas input the authorname");
                                 text: upload_name;
                                }
              onButtonClicked:
                             {
                              uiddia.close();
                              if(index===0)
                                {
                                 upload_name=uid.text
                                  category="";
                                  type="";
                                  order="";
                                  searchname="";
                                 Script.getlist("belle",page.toString(),"15",category,type,upload_name,order,searchname,"appname,author,appid,icon,summary,version,scores,ratingnum");
                                }
                             }


            }

