// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../../JavaScript/main.js" as Script

SelectionDialog
               {
                id: typeSelect;
                platformInverted: true;
                titleText: "选择分类"
                model: ListModel
                                {
                                 ListElement
                                            {
                                            }
                                 ListElement
                                            {
                                            }
                                 ListElement
                                            {
                                            }
                                 function listModel_itemName(ind)
                                         {
                                          switch(ind)
                                                {
                                                 case 0: return qsTr( "All" );
                                                 case 1: return qsTr( "Applications" );
                                                 case 2: return qsTr( "Games" );
                                                 default: break;
                                                }
                                         }
                                }
                delegate: Component
                                   {
                                    MenuItem
                                            {
                                             text: typeSelect.model.listModel_itemName(index);
                                             platformInverted: true;
                                             onClicked:
                                                      {
                                                       selectedIndex = index;
                                                       accept();
                                                      }
                                            }
                                   }
                onAccepted:
                          {
                           switch(selectedIndex)
                                 {
                                  case 0:{
                                         listpage.type="";
                                         page=1;
                                         Script.getlist("belle",page.toString(),"15","",type,"",order,"","appname,author,appid,icon,summary,version,scores,ratingnum");
                                         close();
                                         break;
                                  }
                                  case 1:{
                                         listpage.type="app";
                                         Script.getcategory(type);
                                         page=1;
                                         Script.getlist("belle",page.toString(),"15","",type,"",order,"","appname,author,appid,icon,summary,version,scores,ratingnum");
                                         close();
                                         break;
                                  }
                                  case 2:{
                                         listpage.type="game";
                                         Script.getcategory(type);
                                         page=1;
                                         Script.getlist("belle",page.toString(),"15","",type,"",order,"","appname,author,appid,icon,summary,version,scores,ratingnum");
                                         close();
                                         break;
                                  }
                                  default: break;
                                 }
                          }
               }
