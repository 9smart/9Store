// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../../JavaScript/main.js" as Script
Item{
    id:root;
    property string order:"";
    property int page:1;
    property bool firstStart:true;
    onVisibleChanged: if(visible&&firstStart){
                          firstStart=false;
                          console.log("here");
                          Script.getlist("belle",page.toString(),"15","","","",order,"","appname,author,appid,icon,summary,version,scores,ratingnum");
    }
    width:screen.width;
    TopChartsButtons{
        id:topchartsbuttons;
        z:1;
        onNewestClicked: {
            order="";
            page=1;
            Script.getlist("belle",page.toString(),"15","","","",order,"","appname,author,appid,icon,summary,version,scores,ratingnum");
        }
        onMostPopClicked: {
            order="views";
            page=1;
            Script.getlist("belle",page.toString(),"15","","","",order,"","appname,author,appid,icon,summary,version,scores,ratingnum");
        }
        onMostDlClicked: {
            order="downloads";
            page=1;
            Script.getlist("belle",page.toString(),"15","","","",order,"","appname,author,appid,icon,summary,version,scores,ratingnum");
        }
    }
    ListView{
        id:mainview;
        width: screen.width;
        anchors.top: topchartsbuttons.bottom;
        anchors.bottom: parent.bottom;
        model: listmodel;
        clip: true;
        delegate: ListItemDelegate{}
        footer: Item{
            width: screen.width;
            height: 45;
            Text{
                anchors.centerIn: parent;
                text:app.loading?"Loading...":"Next page";
                color: app.loading?"lightgray":"black";
            }
            MouseArea{
                anchors.fill: parent;
                onClicked: {
                    page++;
                    Script.getlist("belle",page.toString(),"15","","","",order,"","appname,author,appid,icon,summary,version,scores,ratingnum");
                }
            }
        }
    }
}
