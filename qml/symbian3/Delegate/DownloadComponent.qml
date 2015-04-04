// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../BaseComponent"
MyListItem{
    property bool currenturl;
    property bool fileexist;
    id:wrapper;
    width: screen.width;
    height: 80;
    Image{
        id:sicon;
        anchors{
            left: parent.left;
            leftMargin: 15;
            verticalCenter: parent.verticalCenter;
        }
        height: 60;
        width: 60;
        smooth: true;
        source: model.icon;
    }
    Text{
        id:name;
        anchors.top: sicon.top;
        anchors.left: sicon.right;
        anchors.leftMargin: 15;
        text: model.name;
        font.pixelSize: 22;
    }
    ProgressBar{
        id:progress;
        anchors.top: name.bottom;
        anchors.topMargin: 15;
        width: 195;
        anchors.left: name.left;
    }
    /*Button
                     {
                      platformInverted: true;
                      anchors.verticalCenter: parent.verticalCenter;
                      anchors.right: parent.right;
                      anchors.rightMargin: 15;
                      iconSource:"toolbar-delete";
                     }*/
    Rectangle
    {
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.bottom: parent.bottom;
        color: "lightgray";
        height: 2;
    }
    MouseArea
    {
        anchors.fill: parent;
        onClicked:
        {
            if(progress.value===1)
                fileoperate.openFile(model.file);
        }
    }
    Timer
    {
        interval: 500;
        running: true;
        repeat: true;
        triggeredOnStart: true;
        onTriggered:
        {
            currenturl=qcurl.iscurrenturl(model.url);
            fileexist=qcurl.isfileexist(model.file);
            if(currenturl===true)
            {
                progress.value=qcurl.getprogress();
            }
            if((currenturl===false)&&(fileexist===false))
            {
                progress.value=0;
            }
            if((currenturl===false)&&(fileexist===true))
            {
                progress.value=1;
                running=false;
            }
        }
    }
}

