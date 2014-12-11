import QtQuick 1.0
import "Main"
import "ListPage"
import "../JavaScript/main.js" as Script
import com.nokia.symbian 1.1
import com.nokia.extras 1.1

MyPage {
    id:listpage;
    property int page: 1;
    property string type:"";
    property string category:"";
    property string upload_name:"";
    property string order:"";
    property string searchname:"";
    property bool firstStart: true;
    onVisibleChanged: if (visible && firstStart) {
                          firstStart = false;
                          Script.getlist("s60v5",page.toString(),"15",category,type,upload_name,order,searchname,"appname,author,appid,icon,summary,version,scores,ratingnum");
                      }
    title:qsTr ("list page");
    tools: ListPageToolBar{}
    ListModel{ id:categorymodel; }
    SearchByAuthorDialog {
        id:uiddia;
    }
    CategoryMenu {
        id:categorymenu;
        z:3;
    }
    ListPageHead {
        id:head;
    }
    Menu {
        id:mainmenu;
        //platformInverted:true;
        content: ListPageMenu{}
    }
    TypeSelectdialog {
        id: typeSelect;
    }
    OrderButtons{
        id:orderButtons
    }
    ListView {
        id:listview;
        anchors.top: orderButtons.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.bottom: parent.bottom;
        model: ListModel{ id:listmodel; }
        delegate:ListDelegate{ id:listpagedele; }
        footer: ListFooter{}
    }
    Component.onCompleted: {
        Script.listmodel=listmodel;
        Script.categorymodel=categorymodel;
    }
}
