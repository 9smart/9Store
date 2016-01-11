// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
Image {
    id:root;
    property alias backButtonVisible:back.visible;
    property alias homeButtonVisible:home.visible;
    property alias topChartsButtonVisible:topcharts.visible;
    property alias searchButtonVisible:search.visible;
    property alias personalButtonVisible:personal.visible;
    property alias personalSource:personal.source;
    property int highlightItem:1;
    signal backButtonClicked;
    signal homeButtonClicked;
    signal topchartsButtonClicked;
    signal searchButtonClicked;
    signal personalButtonClicked;
    width: parent.width;
    height: 80;
    anchors.bottom: parent.bottom;
    source: "../../pic/General/Toolbar.svg";
    Image{
        x:96;
        width: 96;
        height: 80;
        anchors.bottom: parent.bottom
        source: "../../pic/General/Toolbar_Highlight.svg"
        opacity: highlightItem===1?1:0;
    }
    Image{
        x:192;
        width: 96;
        height: 80;
        anchors.bottom: parent.bottom
        source: "../../pic/General/Toolbar_Highlight.svg"
        opacity: highlightItem===2?1:0;
    }
    Image{
        x:288;
        width: 96;
        height: 80;
        anchors.bottom: parent.bottom
        source: "../../pic/General/Toolbar_Highlight.svg"
        opacity: highlightItem===3?1:0;
    }
    Image{
        x:384;
        width: 96;
        height: 80;
        anchors.bottom: parent.bottom
        source: "../../pic/General/Toolbar_Highlight.svg"
        opacity: highlightItem===4?1:0;
    }
    Button{
        id:back;
        platformStyle: ButtonStyle{
            inverted: false;
        }

        width: height;
        height: 56;
        iconSource:  "../../pic/General/Toolbar_icon_Back_meego.svg";
        anchors.verticalCenter: parent.verticalCenter;
        x:20;
        onClicked: {
            root.backButtonClicked();
        }
        //Component.onCompleted: console.log(height);
    }
    Image{
        id:home;
        source: "../../pic/General/Toolbar_icon_Home.svg";
        anchors.verticalCenter: parent.verticalCenter;
        sourceSize: Qt.size(40, 40);
        x:124;
        MouseArea{
            id:homeMouseArea;
            anchors.fill: parent;
            anchors.margins: -10;
            onClicked: {
                root.homeButtonClicked();
                highlightItem=1;
            }
        }
        //Component.onCompleted: console.log(sourceSize.height);
    }
    Image{
        id:topcharts;
        source: "../../pic/General/Toolbar_icon_TopCharts.svg";
        anchors.verticalCenter: parent.verticalCenter;
        sourceSize: Qt.size(40, 40);
        x:220;
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
        source: "../../pic/General/Toolbar_icon_Search.svg";
        anchors.verticalCenter: parent.verticalCenter;
        sourceSize: Qt.size(40, 40);
        x:316;
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
        source: "../../pic/General/Toolbar_icon_Personal.svg";
        anchors.verticalCenter: parent.verticalCenter;
        sourceSize: Qt.size(40, 40);
        x:412;
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
        //signal clicked;
        anchors.bottom: parent.top;
        width: parent.width;
        source: "../../pic/General/Toolbar_Shadow.png"
    }
}
