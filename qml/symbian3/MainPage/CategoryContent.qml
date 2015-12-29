// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../BaseComponent"
import "../../JavaScript/main.js" as Script
ListView{
    width: screen.width;
    height: 455;
    contentHeight: categorymodel.count * 60;
    clip: true;
    model: categorymodel;
    delegate: MyListItem{
        height: 60;
        Text{
            anchors{
                verticalCenter: parent.verticalCenter;
                left: parent.left;
                leftMargin: 15;
            }
            text: model.category;
            color: "#3c3c3c";
            font.pixelSize: 24;
        }
        Image{
            anchors{
                verticalCenter: parent.verticalCenter;
                right: parent.right;
                rightMargin: 15;
            }
            height: 25;
            width: 25;
            source: "../../pic/General/icon-m-toolbar-next.png";
        }
        onClicked: {
            root.category=model.category;
            listmodel.clear();
            Script.listPage = "";
            Script.getlist("Symbian%5e3", root.category, "", Script.listPage,"12","");
            root.currentContent="ListContent.qml";
        }       
    }

    NumberAnimation on x{
        from: 360;
        to:0;
        duration: 200;
    }
}
