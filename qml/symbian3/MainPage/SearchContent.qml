// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../../JavaScript/main.js" as Script
Item{
    id:root;
    property string currentContent:"LibraryContent.qml";
    property string category;
    width: screen.width;
    SearchFiled{
        id:searchfiled;
        onClicked: {
            if(text==="")
                signalCenter.showMessage(qsTr("Please input the key word"));
            else if(currentContent==="LibraryContent.qml"){
                Script.getapplication("belle",text,"appname,author,appid,icon,summary,version,scores,ratingnum");
                Script.getgame("belle",text,"appname,author,appid,icon,summary,version,scores,ratingnum");
            }
            else if(currentContent==="CategoryContent.qml"){
                Script.getlist("belle","1","15","","","","",text,"appname,author,appid,icon,summary,version,scores,ratingnum");
                root.currentContent="ListContent.qml";
            }
            else Script.getlist("belle","1","15","","","","",text,"appname,author,appid,icon,summary,version,scores,ratingnum");
        }
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
        //onCountChanged: console.log("modelcount:"+count);
    }
    ListModel{
        id:gamemodel;
    }
    Component.onCompleted: {
        Script.categorymodel=categorymodel;
        Script.applicationmodel=applicationmodel;
        Script.gamemodel=gamemodel;
        //Script.listmodel=listmodel;
    }
    NumberAnimation on opacity {
        from: 0;
        to:1;
        duration: 300;
    }
}
