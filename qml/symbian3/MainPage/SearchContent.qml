// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item{
    id:root;
    width: screen.width;
    SearchFiled{
        id:searchfiled;
    }
    Loader{
        id:content;
        anchors.top: searchfiled.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right;
    }
    ListModel{
        id:applicationmodel;
    }
    ListModel{
        id:gamemodel;
    }
}
