// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../BaseComponent"
MyListItem{
    id:root;
    width: screen.width;
    height: 80;
    Image{
        id:icon;
        sourceSize.height: 60;
        sourceSize.width: 60;
        height: sourceSize.height;
        width:sourceSize.width;
        anchors{
            verticalCenter: parent.verticalCenter;
            left: parent.left;
            leftMargin: 12;
        }
        source: model.icon;
        Image{
            anchors.fill: parent;
            source: "../../pic/General/App_icon_Loading.svg";
            visible: parent.status==Image.Loading;
        }
        Image{
            anchors.fill: parent;
            source: "../../pic/General/App_icon_Error.svg";
            visible: parent.status==Image.Error;
        }
    }
    Column{
        anchors{
            verticalCenter: parent.verticalCenter;
            left: icon.right;
            leftMargin: 9;
        }
        spacing: 3;
        Text{
            text: model.appname;
            font.pixelSize: 19;
            color: "#3c3c3c";
        }
        Text{
            text: model.author;
            font.pixelSize: 13;
            color: "#787878";
        }
        RankStars{
            ranknum: model.ratingnum==="0"?0:(scores/ratingnum);
            size: 15;
        }
    }
    onClicked:{
        pageStack.push(Qt.resolvedUrl("../InfoPage.qml"),{appid:model.appid,title:model.appname,icon:model.icon,summary:model.summary,version:model.version,author:model.author,ratingnum:model.ratingnum,scores:model.scores});
    }
}
