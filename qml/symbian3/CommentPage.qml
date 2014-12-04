// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "Main"
import "CommentPage"
import "../JavaScript/main.js" as Script
MyPage{
    id:commentpage;
    property string appid;
    property bool firstStart: true;
    property string size;
    property string author;
    property string icon;
    property string scores;
    property int ratingnum;
    property int page: 1;
    onVisibleChanged: if (visible && firstStart) {
        firstStart = false
        Script.getComment(appid,page.toString());
    }
    tools: ToolBarLayout{
        ToolButton{
            platformInverted: true;
            iconSource: "toolbar-back";
            onClicked: pageStack.pop();
        }
    }
    ListModel{
        id:commentmodel;
    }
    Head{
        id:head;
        z:1;
        Image{
            id:sicon;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: parent.left;
            anchors.leftMargin: 12;
            height: 36;
            width: 36;
            source: icon;
        }
        Text{
            text: title;
            font.pixelSize: 24;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: sicon.right;
            anchors.leftMargin: 12;
        }
    }
    ListView{
        id:commentview;
        anchors.fill: parent;
        anchors.topMargin: head.height;
        delegate: CommentDelegate{}
        model: commentmodel;
        header:Headinfo{}
        footer: ListFooter{}
    }
    Component.onCompleted:{
        Script.commentmodel=commentmodel;
    }
}
