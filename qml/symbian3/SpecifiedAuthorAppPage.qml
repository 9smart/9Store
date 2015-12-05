// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../JavaScript/main.js" as Script
import "BaseComponent"
import "Delegate"
MyPage{
    id:relatedappspage;
    property int page:1;
    property bool firstStart: true;

    property ListModel specifiedAuthorModel;
    onVisibleChanged: if (visible && firstStart) {
                          firstStart = false
                          //Script.getlist("belle",page.toString(),"15","","",title,"","","appname,author,appid,icon,summary,version,scores,ratingnum");
                          Script.page = "";
                          Script.getSpecifiedAuthorList("Symbian%5e3", title, Script.page, "12");
                      }
    title: qsTr("Related apps");
    ToolBar{
        id:toolbar;
        z:1;
        homeButtonVisible: false;
        topChartsButtonVisible: false;
        searchButtonVisible: false;
        personalButtonVisible: false;
        highlightItem: 0;
        onBackButtonClicked: pageStack.pop();
    }
    Head{
        id:head;
        titleText: title;
        z:1;
    }
    ListView{
        id:listview;
        anchors.fill:parent;
        anchors.topMargin: head.height;
        anchors.bottomMargin: toolbar.height;
        clip:true;
        model: specifiedAuthorModel;
        delegate:ListComponent{ id:listdelegate; }
        footer: ListFooter{
            id: listfooter
            onClicked: {
                if(Script.page !== "NULL"){
                    Script.getSpecifiedAuthorList("Symbian%5e3", title, Script.page, "12");
                }
                else{
                    signalCenter.showMessage(qsTr("No next page aviliable..."))
                }
            }
        }
    }
}
