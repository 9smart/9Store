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
                          Script.getlist("belle",page.toString(),"15","","","",order,"","");
    }
    width:parent.width;
    TopChartsButtons{
        id:topchartsbuttons;
        z:1;
        onNewestClicked: {
            order="";
            page=1;
            Script.getlist("belle",page.toString(),"15","","","",order,"","");
        }
        onMostPopClicked: {
            order="views";
            page=1;
            Script.getlist("belle",page.toString(),"15","","","",order,"","");
        }
        onMostDlClicked: {
            order="downloads";
            page=1;
            Script.getlist("belle",page.toString(),"15","","","",order,"","");
        }
    }
    ListView{
        id:mainview;
        width: screen.width;
        anchors.top: topchartsbuttons.bottom;
        anchors.bottom: parent.bottom;
        model: listmodel;
        delegate: ListItemDelegate{}
    }
}
