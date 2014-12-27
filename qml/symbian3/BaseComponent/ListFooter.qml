// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item{
    signal clicked;
    width: screen.width;
    height: 45;
    Text{
        anchors.centerIn: parent;
        text:app.loading?"Loading...":"Next page";
        color: app.loading?"lightgray":"black";
    }
    MouseArea{
        id:mousearea;
        anchors.fill: parent;
        onClicked: parent.clicked();
    }
}
