// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Image{
    //height: screen.displayHeight;
    height: 854;
    //width: screen.displayWidth;
    width: 480;
    smooth: true;
    source: model.url;
    Image{
        anchors.fill: parent;
        source: "../../pic/Details/App_Datail_Loading.svg";
        visible: parent.status == Image.Loading;
    }
    Image{
        anchors.fill: parent;
        source: "../../pic/Details/App_Datail_Error.svg";
        visible: parent.status == Image.Error;
    }
    MouseArea{
        anchors.fill: parent;
        onClicked: {
            screenshotgallary.state = "close";
        }
    }
}
