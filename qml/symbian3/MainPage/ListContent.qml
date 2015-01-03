// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../BaseComponent"
import "../Delegate"
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
