// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../BaseComponent"
MyListItem{
    id:root;
    width: screen.width;
    height: 80;
    Image{
        id:icon;
        sourceSize.height: 66;
        sourceSize.width: 66;
        height: sourceSize.height;
        width:sourceSize.width;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left;
        anchors.leftMargin: 9;
        source: model.icon;
    }
    Column{
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: icon.right;
        anchors.leftMargin: 9;
        spacing: 3;
        Text{
            text: model.appname;
            font.pixelSize: 18;
        }
        Text{
            text: model.author;
            font.pixelSize: 12;
            color: "gray";
        }
        RankStars{
            ranknum: model.ratingnum==="0"?0:(scores/ratingnum).toFixed();
            size: 13;
        }
    }
    onClicked:{
        pageStack.push(Qt.resolvedUrl("../InfoPage.qml"),{appid:model.appid,title:model.appname,icon:model.icon,summary:model.summary,version:model.version,author:model.author,ratingnum:model.ratingnum,scores:model.scores});
    }
}
