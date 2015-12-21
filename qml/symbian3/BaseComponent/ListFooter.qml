// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item{
    property string text: "Next page";
    signal clicked;
    width: screen.width;
    height: 45;
    Text{
        id: footertext;
        anchors.centerIn: parent;
        text:app.loading?"Loading...":parent.text;
        color: app.loading?"lightgray":"black";
    }
    MouseArea{
        id:mousearea;
        anchors.fill: parent;
        onClicked: parent.clicked();
    }
}
