// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../BaseComponent"
MyListItem{
    id:root;
    //width: screen.displayWidth;
    width: 480;
    height: 107;
    Image{
        id:icon;
        sourceSize.height: 80;
        sourceSize.width: 80;
        height: sourceSize.height;
        width:sourceSize.width;
        anchors{
            verticalCenter: parent.verticalCenter;
            left: parent.left;
            leftMargin: 16;
        }
        source: "http://apps-images.9smart.cn/" + model.uploader.uid + "/i/" + model._id;
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
            leftMargin: 12;
        }
        spacing: 4;
        Text{
            text: model.appname;
            font.pixelSize: 25;
            color: "#3c3c3c";
        }
        Text{
            text: model.developer;
            font.pixelSize: 17;
            color: "#787878";
        }
        RankStars{
            ranknum: model.score_num === "0"?0:(model.scores/model.score_num);
            size: 20;
        }
    }
    onClicked:{
        pageStack.push(Qt.resolvedUrl("../InfoPage.qml"),
                               {_id:model._id, title:model.appname, icon:icon.source, score_num:((model.score_num)?model.score_num:0), scores:((model.scores)?model.scores:0), developer:model.developer});
    }
}
