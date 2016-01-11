// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Component{
    Image{
        height:287;
        width:160;
        smooth:true;
        source:model.thumburl;
        Image{
            anchors.fill: parent;
            source: "../../pic/Details/App_Datail_Loading.svg";
            visible: parent.status==Image.Loading;
        }
        Image{
            anchors.fill: parent;
            source: "../../pic/Details/App_Datail_Error.svg";
            visible: parent.status==Image.Error;
        }
        MouseArea{
            anchors.fill: parent;
            onClicked: {
                screenshotgallary.state = "open";
                //console.log("here");
            }
        }
    }
}
