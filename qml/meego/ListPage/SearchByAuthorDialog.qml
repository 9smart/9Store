// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import "../../JavaScript/main.js" as Script
Dialog{
    id:uiddia;
    title: Text{
        text:qsTr("pleas input the author name");
        color:"white";
        font.pixelSize: 30;
        anchors.horizontalCenter:parent.horizontalCenter;
    }
    content: Item{
        height:200;
        width:parent.width;
        TextField{
            id:uid;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.horizontalCenter:parent.horizontalCenter;
            placeholderText:upload_name;
        }
    }
    buttons: Button{
        text: qsTr("OK");
        width:200;
        anchors.horizontalCenter:parent.horizontalCenter;
        onClicked:{
            uiddia.close();
            upload_name=uid.text;
            category="";
            type="";
            order="";
            searchname="";
            Script.getlist("meego",page.toString(),"15",category,type,upload_name,order,searchname,"appname,author,appid,icon,summary,version,scores,ratingnum");
        }
    }
}
