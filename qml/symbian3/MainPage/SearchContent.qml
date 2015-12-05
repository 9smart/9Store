// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../../JavaScript/main.js" as Script
Item{
    id:root;
    property string currentContent:"LibraryContent.qml";
    property string category;
    property string page: "";
    width: screen.width;
    SearchFiled{
        id:searchfiled;
        onClicked: {
            if(text==="")
                signalCenter.showMessage(qsTr("Please input the key word"));
            else if(currentContent==="LibraryContent.qml"){
                //Script.getapplication("belle",text,"appname,author,appid,icon,summary,version,scores,ratingnum");
                //Script.getgame("belle",text,"appname,author,appid,icon,summary,version,scores,ratingnum");
            }
            else if(currentContent==="CategoryContent.qml"){
                Script.getlist("Symbian%5e3", "", "", page,"12","");
                root.currentContent="ListContent.qml";
            }
            else {
                Script.getlist("Symbian%5e3", root.category, "", page,"12","");
            }
        }
    }
    Loader{
        id:searchcontent;
        anchors{
            top: searchfiled.bottom;
            left: parent.left;
            right: parent.right;
        }
        source: currentContent;
    }    
    NumberAnimation on opacity {
        from: 0;
        to:1;
        duration: 300;
    }   
}
