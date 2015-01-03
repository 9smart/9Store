// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../../JavaScript/main.js" as Script
Item{
    id:root;
    property string currentContent:"LibraryContent.qml";
    width: screen.width;
    SearchFiled{
        id:searchfiled;
    }
    Loader{
        id:searchcontent;
        anchors.top: searchfiled.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right;
        source: currentContent;
    }
    ListModel{
        id:categorymodel;
    }    
    ListModel{
        id:applicationmodel;
    }
    ListModel{
        id:gamemodel;
    }
    Component.onCompleted: {
        Script.categorymodel=categorymodel;
    }
}
