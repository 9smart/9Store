// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Image {
    id: root;
    height: 170;
    width: parent.width;
    source: model.thumb;
    Rectangle{
        anchors.fill: parent;
        color: "lightgray";
        visible: parent.status == Image.Ready?false:true;
    }
}
