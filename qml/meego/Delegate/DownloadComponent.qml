// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "../BaseComponent"
MyListItem{
    property bool currenturl;
    property bool fileexist;
    id:wrapper;
    width: screen.width;
    height: 107;
    Image{
        id:sicon;
        sourceSize.height: 80;
        sourceSize.width: 80;
        height: sourceSize.height;
        width:sourceSize.width;
        anchors{
            verticalCenter: parent.verticalCenter;
            left: parent.left;
            leftMargin: 16;
        }
        source: model.icon;
        Image{
            anchors.fill: parent;
            source: "../../pic/General/App_icon_Loading.svg";
            visible: parent.status==Image.Loading;
        }
        Image{
            anchors.fill: parent;
            source: "../../pic/General/App_icon_Error.svg";
            visible: parent.status==Image.Error;
        }
    }
    Text{
        id:name;
        anchors.top: sicon.top;
        anchors.left: sicon.right;
        anchors.leftMargin: 20;
        text: model.name;
        font.pixelSize: 29;
    }
    ProgressBar{
        id:progress;
        width: 260;
        anchors{
            top: name.bottom;
            topMargin: 20;
            left: name.left;
        }
        //value:
    }
    MouseArea{
        anchors.fill: parent;
        onClicked:{
            if(progress.value===1)
                fileoperate.openFile(model.file);
        }
    }
    states: [
        State {
            name: "Waiting";
        },
        State{
            name:"Downloading";
        },
        State{
            name:"Downloaded";
        },
        State{
            name:"Installing";
        },
        State{
            name:"Installed";
        }
    ]
    Connections{
        target: qcurl;
        onStateChanged:{

        }
    }
}

