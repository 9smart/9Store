import QtQuick 1.0
import com.nokia.symbian 1.1
import "../../JavaScript/main.js" as Script

Component {
    id:listfooter;
    Item {
        height: loadBtn.height + 16;
        width: parent.parent.width;
        Button {
            id: loadBtn;
            //platformInverted: true;
            width: parent.width - 16;
            anchors.centerIn: parent;
            text: qsTr("More");
            visible: listview.count == 0 ? false : true;
            enabled: !app.loading;
            onClicked: {
                page++;
                Script.getlist("s60v5",page.toString(),"15",category,type,upload_name,order,searchname,"appname,author,appid,icon,summary,version,scores,ratingnum");
            }
        }
    }
}
