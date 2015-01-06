// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../BaseComponent"
import "../../JavaScript/main.js" as Script
ListView{
    width: screen.width;
    height: 455;
    contentHeight:categorymodel.count*60;
    clip: true;
    model: categorymodel;
    delegate: MyListItem{
        height: 60;
        Text{
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: parent.left;
            anchors.leftMargin: 15;
            text: model.category;
            color: "#3c3c3c";
            font.pixelSize: 24;
        }
        Image{
            anchors.verticalCenter: parent.verticalCenter;
            anchors.right: parent.right;
            anchors.rightMargin: 15;
            height: 25;
            width: 25;
            source: "../../pic/General/icon-m-toolbar-next.png";
        }
        onClicked: {
            root.category=model.category;
            listmodel.clear();
            Script.getlist("belle","1","15",root.category,"","","","","appname,author,appid,icon,summary,version,scores,ratingnum");
            root.currentContent="ListContent.qml";
        }
    }
}
