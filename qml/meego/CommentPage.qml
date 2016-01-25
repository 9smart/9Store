// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "BaseComponent"
import "InfoPage"
import "Delegate"
import "Dialog"
import "../JavaScript/main.js" as Script
MyPage{
    id:commentpage;
    property string _id;
    property bool firstStart: true;
    property string size;
    property string developer;
    property string type;
    property string category;
    property string icon;
    property string scores;
    property int score_num;
    property alias commentModel: commentmodel;
    onVisibleChanged: if (visible && firstStart) {
                          Script.commentListPage = "";
                          Script.getComment(_id, Script.commentListPage);
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
        onPersonalButtonClicked: {
            if(user.userState){
                sendcommentdialog.open();
            }
            else{
                signalCenter.showMessage(qsTr("Please login"));
            }
        }
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
            height: 20;
            //width: screen.displayWidth;
            width: 480;
            color: "#f5f5f5";
            Image{
                anchors.top: parent.bottom;
                width: parent.width;
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
            topMargin: infopagehead.height + maininfo.height + 20;
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
            ListFooter{
                visible: commentmodel.count > 0;
                onClicked: {
                    if(Script.commentListPage !== "NULL"){
                        Script.getComment(_id, Script.commentListPage);
                    }
                    else{
                        signalCenter.showMessage(qsTr("No next page aviliable..."))
                    }
                }
            }
        }
    }
    SendCommentDialog{
        id: sendcommentdialog;
    }
    SendReplyDialog{
        id: sendreplydialog;
    }
    Component.onCompleted:{
        Script.commentPage = commentpage;
    }
}
