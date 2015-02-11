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
        onPersonalButtonClicked: sendcommentdialog.open();
    }
    ListModel{
        id:commentmodel;
    }
    Column{
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
    }
    Flickable{
        id:flick;
        flickableDirection: Flickable.VerticalFlick;
        anchors{
            fill: parent;
            topMargin: infopagehead.height+maininfo.height+15;
            bottomMargin: toolbar.height;
        }
        contentHeight: commentColumn.height;
        clip: true;
        Column{
            id:commentColumn;
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
