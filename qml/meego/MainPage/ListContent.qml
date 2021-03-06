// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../../JavaScript/main.js" as Script
import "../BaseComponent"
import "../Delegate"
ListView{
    property int page:1;
    width: screen.displayWidth;
    height: 607;
    contentHeight: listmodel.count * 107;
    model: listmodel;
    clip: true;
    delegate: ListComponent{}
    footer: ListFooter{
        onClicked: {
            page++;
            Script.getlist("belle",page.toString(),"15",root.category,"","","",searchfiled.text,"appname,author,appid,icon,summary,version,scores,ratingnum");
        }
    }
    NumberAnimation on x{
        from: 360;
        to:0;
        duration: 200;
    }
}
