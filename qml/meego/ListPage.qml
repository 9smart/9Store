// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import "../JavaScript/main.js" as Script
import "Main"
import "ListPage"
MyPage{
    id:listpage;
    property int page: 1;
    property string type:"";
    property string category;
    property string upload_name;
    property string order;
    property string searchname:"";
    property string dlurl;
    property bool firstStart: true;
    onVisibleChanged: if (visible && firstStart){
                          firstStart = false
                          Script.getlist("meego",page.toString(),"15",category,type,upload_name,order,searchname,"appname,author,appid,icon,summary,version,scores,ratingnum");
                      }
    title:qsTr ("list page");
    tools: ListPageToolBar{}
    ListModel { id:categorymodel;}
    SearchByAuthorDialog{
        id:uiddia;
    }
    Categorymenu{
        id:categorymenu;
        z:3;
    }
    Menu{
        id:mainmenu;
        content: ListPageMenu{}
    }
    ListPageHead{
        id:head;
    }
    TypeSelecterDialog{
        id: typeSelect;
    }
    OrderButtons{
        id:orderButtons;
    }
    ListView{
        id:listview;
        anchors.top: orderButtons.bottom;
        anchors.topMargin: 5;
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.bottom: parent.bottom;
        model: ListModel { id:listmodel;}
        delegate:ListDelegate { id:listpagedele;}
        footer: Listfooter{}
    }
    Component.onCompleted:{
        Script.listmodel=listmodel;
        Script.categorymodel=categorymodel;
    }
}
