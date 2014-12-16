// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Image {
    property int highlightItem:-1;
    width: parent.width;
    anchors.bottom: parent.bottom;
    source: "../../pic/Toolbar_inverse.svg";
    Row{
        id:highlights;
        Repeater{
            id:repeater;
            model: 5;
            Image{
                source: "../../pic/ToolbarHighlight.svg"
                visible: index===highlightItem;
            }
        }
    }
    Image{
        id:back;
        source: "../../pic/Toolbar-Back_inverse.svg";
        anchors.verticalCenter: parent.verticalCenter;
        anchors.horizontalCenter: repeater.itemAt(0).horizontalCenter;
    }
    Image{
        id:home;
        source: "../../pic/Toolbar-Home_inverse.svg";
        anchors.verticalCenter: parent.verticalCenter;
        anchors.horizontalCenter: repeater.itemAt(1).horizontalCenter;
    }
    Image{
        id:topcharts;
        source: "../../pic/Toolbar-TopCharts_inverse.svg";
        anchors.verticalCenter: parent.verticalCenter;
        anchors.horizontalCenter: repeater.itemAt(2).horizontalCenter;
    }
    Image{
        id:search;
        source: "../../pic/Toolbar-Search_inverse.svg";
        anchors.verticalCenter: parent.verticalCenter;
        anchors.horizontalCenter: repeater.itemAt(3).horizontalCenter;
    }
    Image{
        id:personal;
        source: "../../pic/Toolbar-Personal_inverse.svg";
        anchors.verticalCenter: parent.verticalCenter;
        anchors.horizontalCenter: repeater.itemAt(4).horizontalCenter;
    }
    Image{
        id:shadow;
        anchors.bottom: parent.top;
        source: "../../pic/ToolbarShadow.png"
    }
}
