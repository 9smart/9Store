import QtQuick 1.0
import com.nokia.symbian 1.0
import "../../JavaScript/main.js" as Script
Rectangle{
    id:root;
    anchors.left: parent.left;
    anchors.right: parent.right;
    height: orderbutton.height+12;
    anchors.top: head.bottom;
    color: "Black";
    z:1;
    ButtonRow{
        id:orderbutton;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.verticalCenter: parent.verticalCenter;
        checkedButton: b1;
        z:1;
        Button{
            //platformInverted:true;
            id:b1;
            text: qsTr("Newest");
            onClicked:{
                listpage.order="";
                page=1;
                Script.getlist("s60v5",page.toString(),"15",category,type,upload_name,order,searchname,"appname,author,appid,icon,summary,version,scores,ratingnum");
            }
        }
        Button{
            id:b2;
            //platformInverted:true;
            text: qsTr("most pop");
            onClicked:{
                listpage.order="views";
                page=1;
                Script.getlist("s60v5",page.toString(),"15",category,type,upload_name,order,searchname,"appname,author,appid,icon,summary,version,scores,ratingnum");
            }
        }
        Button{
            id:b3;
            //platformInverted:true;
            text: qsTr("most dl");
            onClicked:{
                listpage.order="downloads";
                page=1;
                Script.getlist("s60v5",page.toString(),"15",category,type,upload_name,order,searchname,"appname,author,appid,icon,summary,version,scores,ratingnum");
            }
        }
    }
}
