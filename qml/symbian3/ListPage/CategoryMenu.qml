// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../../JavaScript/main.js" as Script
ContextMenu
           {
            id:categorymenu;
            platformInverted: true;
            MenuLayout
                      {
                       Repeater
                               {
                                id:repeater;
                                model: categorymodel;
                                delegate: MenuItem
                                                  {
                                                   text:model.cate;
                                                   platformInverted:true;
                                                   onClicked:
                                                            {
                                                             categorymenu.close();
                                                             category=model.cate;
                                                             page=1;
                                                             Script.getlist("belle",page.toString(),"15",category,type,upload_name,order,searchname,"appname,author,appid,icon,summary,version,scores,ratingnum");
                                                            }
                                                  }
                               }
                      }

           }
