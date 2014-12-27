// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Item{
    id:root;
    property alias clicked:mousearea.clicked();
    width: screen.width;
    height: 80;
    Rectangle{
        anchors.fill: parent;
        color: "#1080dd";
        visible: mousearea.pressed;
    }

    Rectangle{
        anchors.top: parent.top;
        width: parent.width;
        height: 1;
        color: "#fdfdfd";
    }
    Rectangle{
        anchors.bottom: parent.bottom;
        width: parent.width;
        height: 1;
        color: "#dadada";
    }

    MouseArea{
        id:mousearea;
        anchors.fill: parent;
        onClicked:{
            pageStack.push(Qt.resolvedUrl("../InfoPage.qml"),{appid:model.appid,title:model.appname,icon:model.icon,summary:model.summary,version:model.version,author:model.author,ratingnum:model.ratingnum,scores:model.scores});
        }
    }
}
