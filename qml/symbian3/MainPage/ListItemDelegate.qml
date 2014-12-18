// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../Main"
Item{
    id:root;
    width: screen.width;
    height: 80;
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
            ranknum: 5
            size: 13;
        }
    }
}
