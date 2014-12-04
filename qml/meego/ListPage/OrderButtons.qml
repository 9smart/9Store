// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "../../JavaScript/main.js" as Script
Rectangle{
    id:orderbuttonshadow;
    anchors.left: parent.left;
    anchors.right: parent.right;
    anchors.top: head.bottom;
    height: orderbutton.height+16;
    color: "#e0e1e2"
    z:1;
    ButtonRow{
        id:orderbutton;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.verticalCenter: parent.verticalCenter;
        checkedButton: b1;
        z:1;
        Button{
            id:b1;
            text: qsTr("Newest");
            onClicked:{
                listpage.order="";
                page=1;
                Script.getlist("meego",page.toString(),"15",category,type,upload_name,order,searchname,"appname,author,appid,icon,summary,version,scores,ratingnum");
            }
        }
        Button{
            id:b2;
            text: qsTr("most pop");
            onClicked:{
                listpage.order="views";
                page=1;
                Script.getlist("meego",page.toString(),"15",category,type,upload_name,order,searchname,"appname,author,appid,icon,summary,version,scores,ratingnum");
            }
        }
        Button{
            id:b3;
            text: qsTr("most dl");
            onClicked:{
                listpage.order="downloads";
                page=1;
                Script.getlist("meego",page.toString(),"15",category,type,upload_name,order,searchname,"appname,author,appid,icon,summary,version,scores,ratingnum");
            }
        }
    }
}
