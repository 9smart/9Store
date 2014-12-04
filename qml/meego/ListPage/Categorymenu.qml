// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
//import com.nokia.extras 1.1
import "../../JavaScript/main.js" as Script
ContextMenu{
    id:categorymenu;
    MenuLayout{
        Repeater{
            id:repeater;
            model: categorymodel;
            delegate: MenuItem{
                text:model.cate;
                onClicked:{
                    categorymenu.close();
                    category=model.cate;
                    page=1;
                    Script.getlist("meego",page.toString(),"15",category,type,upload_name,order,searchname,"appname,author,appid,icon,summary,version,scores,ratingnum");
                }
            }
        }
    }
}
