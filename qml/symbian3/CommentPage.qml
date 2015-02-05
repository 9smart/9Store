// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "BaseComponent"
import "InfoPage"
import "Delegate"
import "../JavaScript/main.js" as Script
MyPage{
    id:commentpage;
    property string appid;
    property bool firstStart: true;
    property string size;
    property string author;
    property string type;
    property string category;
    property string icon;
    property string scores;
    property int ratingnum;
    property int page: 1;
    onVisibleChanged: if (visible && firstStart) {
        firstStart = false
        Script.getComment(appid,page.toString());
    }
    ToolBar{
        id:toolbar;
        z:1;
        homeButtonVisible: false;
        topChartsButtonVisible: false;
        searchButtonVisible: false;
        personalButtonVisible: true;
        personalSource: "../pic/Details/edit.svg";
        highlightItem: 0;
        onBackButtonClicked: pageStack.pop();
    }
    ListModel{
        id:commentmodel;
    }
    Flickable{
        id:flick;
        flickableDirection: Flickable.VerticalFlick
        anchors.fill: parent;
        anchors.bottomMargin: toolbar.height;
        contentHeight: commentColumn.height;
        Column{
            id:commentColumn;
            InfoPageHead{
                id:infopagehead;
            }
            MainInfo{
                id:maininfo;
            }
            Rectangle{
                height: 15;
                width: screen.width;
                color: "#f5f5f5";
                Image{
                    anchors.top: parent.bottom;
                    source: "../pic/General/HeadShadow.png";
                    opacity: 0.75;
                    z:1;
                }
            }
            Repeater{
                model: commentmodel;
                delegate: CommentComponent{}
            }
        }
    }
    Component.onCompleted:{
        Script.commentmodel=commentmodel;
    }
}
