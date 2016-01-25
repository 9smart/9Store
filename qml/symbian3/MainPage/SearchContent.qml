// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../../JavaScript/main.js" as Script
Item{
    id:root;
    property string currentContent:"LibraryContent.qml";
    property string category;
    //property string page: "";
    width: screen.width;
    SearchFiled{
        id:searchfiled;
        onClicked: {
            if(text==="")
                signalCenter.showMessage(qsTr("Please input the key word"));
            else if(currentContent==="LibraryContent.qml"){
                Script.getapplication("Symbian%5e3", text);
                Script.getgame("Symbian%5e3", text);
            }
            else if(currentContent==="CategoryContent.qml"){
                Script.listPage = "";
                Script.getSearch("Symbian%5e3", text, "", Script.listPage);
                root.currentContent="ListContent.qml";
            }
            else {
                Script.listPage = ""
                Script.getSearch("Symbian%5e3", text, root.category, Script.listPage);
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
