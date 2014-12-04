// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Row{
    id:root;
    property int ranknum: 5;
    property int size:32;
    property bool optional:  false;
    Repeater{
        model: 5;
        Text{
            text: "★";
            font.pixelSize: size;
            color: ranknum-1>=index?"lightblue":"gray";
            MouseArea{
                anchors.fill: parent;
                enabled: optional;
                onClicked: {
                    ranknum=index+1;
                }
            }
        }
    }
}
