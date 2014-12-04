import QtQuick 1.0

Row {
    id: root;
    property int ranknum: 5;
    property int size:18;
    property bool optional:  false;
    Repeater {
        model: 5;
        Text {
            text: "★";
            font.pixelSize: size;
            color: ranknum - 1 >= index ? "lightblue" : "gray";
            MouseArea {
                anchors.fill: parent;
                enabled: optional;
                onClicked:
                    ranknum=index+1;
            }
        }
    }
}
