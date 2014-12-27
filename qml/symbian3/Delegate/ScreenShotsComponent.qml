// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Component{
    Image{
        height:320;
        width:180;
        smooth:true;
        source:model.thumburl;
        Rectangle{
            anchors.fill: parent;
            color: "lightgray";
            visible: parent.status!=Image.Ready;
        }
    }
}
