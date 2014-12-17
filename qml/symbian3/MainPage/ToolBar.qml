// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
Image {
    id:root;
    property int highlightItem:-1;
    signal backButtonClicked;
    signal homeButtonClicked;
    signal topchartsButtonClicked;
    signal searchButtonClicked;
    signal personalButtonClicked;
    width: parent.width;
    anchors.bottom: parent.bottom;
    source: "../../pic/Toolbar_inverse.svg";
    Image{
        x:72;
        width: 72;
        height: 58;
        anchors.bottom: parent.bottom
        source: "../../pic/ToolbarHighlight.svg"
        opacity: highlightItem===1?1:0;
    }
    Image{
        x:144;
        width: 72;
        height: 58;
        anchors.bottom: parent.bottom
        source: "../../pic/ToolbarHighlight.svg"
        opacity: highlightItem===2?1:0;
    }
    Image{
        x:216;
        width: 72;
        height: 58;
        anchors.bottom: parent.bottom
        source: "../../pic/ToolbarHighlight.svg"
        opacity: highlightItem===3?1:0;
    }
    Image{
        x:288;
        width: 72;
        height: 58;
        anchors.bottom: parent.bottom
        source: "../../pic/ToolbarHighlight.svg"
        opacity: highlightItem===4?1:0;
    }
    ToolButton{
        id:back;
        iconSource:  "../../pic/Toolbar-Back_inverse.svg";
        anchors.verticalCenter: parent.verticalCenter;
        x:8;
        onClicked: {
            root.backButtonClicked();
        }
    }
    Image{
        id:home;
        source: "../../pic/Toolbar-Home_inverse.svg";
        anchors.verticalCenter: parent.verticalCenter;
        x:93;
        MouseArea{
            id:homeMouseArea;
            anchors.fill: parent;
            anchors.margins: -10;
            onClicked: {
                root.homeButtonClicked();
                highlightItem=1;
            }
        }
    }
    Image{
        id:topcharts;
        source: "../../pic/Toolbar-TopCharts_inverse.svg";
        anchors.verticalCenter: parent.verticalCenter;
        x:165;
        MouseArea{
            id:topchartsMouseArea;
            anchors.fill: parent;
            anchors.margins: -10;
            onClicked: {
                root.topchartsButtonClicked();
                highlightItem=2;
            }
        }
    }
    Image{
        id:search;
        source: "../../pic/Toolbar-Search_inverse.svg";
        anchors.verticalCenter: parent.verticalCenter;
        x:237;
        MouseArea{
            id:searchMouseArea;
            anchors.fill: parent;
            anchors.margins: -10;
            onClicked: {
                root.searchButtonClicked();
                highlightItem=3;
            }
        }
    }
    Image{
        id:personal;
        source: "../../pic/Toolbar-Personal_inverse.svg";
        anchors.verticalCenter: parent.verticalCenter;
        x:309;
        MouseArea{
            id:personalMouseArea;
            anchors.fill: parent;
            anchors.margins: -10;
            onClicked: {
                root.personalButtonClicked();
                highlightItem=4;
            }
        }
    }
    Image{
        id:shadow;
        signal clicked;
        anchors.bottom: parent.top;
        source: "../../pic/ToolbarShadow.png"        
    }
}
