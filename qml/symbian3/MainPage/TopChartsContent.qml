// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../../JavaScript/main.js" as Script
import "../BaseComponent"
import "../Delegate"
Item{
    id:root;
    property string order:"";
    property int page:1;
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
        delegate: ListComponent{}
        footer: ListFooter{
            onClicked: {
                page++;
                Script.getlist("belle",page.toString(),"15","","","",order,"","appname,author,appid,icon,summary,version,scores,ratingnum");
            }
        }
    }
    Component.onCompleted: {
        if(listmodel.count===0)
            Script.getlist("belle",page.toString(),"15","","","",order,"","appname,author,appid,icon,summary,version,scores,ratingnum");
    }
    NumberAnimation on opacity {
        from: 0;
        to:1;
        duration: 300;
    }
}
