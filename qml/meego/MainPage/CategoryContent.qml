// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../BaseComponent"
import "../../JavaScript/main.js" as Script
ListView{
    width: screen.displayWidth;
    height: 607;
    contentHeight:categorymodel.count * 80;
    clip: true;
    model: categorymodel;
    delegate: MyListItem{
        height: 80;
        Text{
            anchors{
                verticalCenter: parent.verticalCenter;
                left: parent.left;
                leftMargin: 20;
            }
            text: model.category;
            color: "#3c3c3c";
            font.pixelSize: 32;
        }
        Image{
            anchors{
                verticalCenter: parent.verticalCenter;
                right: parent.right;
                rightMargin: 20;
            }
            height: 33;
            width: 33;
            source: "../../pic/General/icon-m-toolbar-next.png";
        }
        onClicked: {
            root.category=model.category;
            listmodel.clear();
            Script.getlist("belle","1","15",root.category,"","","","","appname,author,appid,icon,summary,version,scores,ratingnum");
            root.currentContent="ListContent.qml";
        }
    }
    NumberAnimation on x{
        from: 480;
        to:0;
        duration: 200;
    }
}
