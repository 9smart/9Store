// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    width: parent.width;
    height: 40;
    color:"#e6e6e6";
    Rectangle{
        anchors.right:parent.right;
        anchors.left: parent.left;
        height:3;
        gradient: Gradient{
            GradientStop{
                position: 0.0;
                color: "#a9a9a9";
            }
            GradientStop{
                position: 1.0;
                color: "#e6e6e6";
            }
        }
    }
    Rectangle{
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.bottom: parent.bottom;
        height: 1;
        color: "grey";
    }
}
