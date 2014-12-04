// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
Dialog{
    id:folderselecter;
    title: Text{
        z:1;
        id:path;
        wrapMode:Text.WrapAnywhere;
        text:Script.cutfile(foldlistmodel.folder);
        color:"white";
        font.pixelSize: 40;
        anchors.horizontalCenter:parent.horizontalCenter;
    }
    content: ListView{
        height:360;
        width:parent.width;
        model:foldlistmodel;
        delegate:Text{
            text:model.fileName;
            color: "white";
            font.pixelSize: 36;
            MouseArea{
                anchors.fill: parent;
                onClicked: foldlistmodel.isFolder(model.index)?path.text=Script.cutfile(model.filePath):signalCenter.showMessage(qsTr("Please select a folder"));
                onDoubleClicked: foldlistmodel.isFolder(model.index)?foldlistmodel.folder=Script.cutfile(model.filePath):signalCenter.showMessage(qsTr("Please select a folder"));
            }
        }
    }
    buttons: ButtonRow{
        z:1;
        width:300;
        anchors.horizontalCenter:parent.horizontalCenter;
        Button{
            text: qsTr("Choose");
            onClicked:{
                downloadpath=path.text;
                folderselecter.close()
            }
        }
        Button{
            text: qsTr("Cancel");
            onClicked: folderselecter.close();
        }
    }
}
