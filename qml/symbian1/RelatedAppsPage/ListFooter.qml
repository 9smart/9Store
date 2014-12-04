import QtQuick 1.0
import com.nokia.symbian 1.0
import "../../JavaScript/main.js" as Script
Component{
    id:listfooter;
    Item{
        height: loadBtn.height + 16;
        width: parent.parent.width;
        Button{
            id: loadBtn;
            //platformInverted: true;
            width: parent.width - 16;
            anchors.centerIn: parent;
            text: qsTr("More");
            visible : listview.count === 0 ? false : true;
            enabled: !app.loading;
            onClicked:{
                page++;
                Script.getrelatedlist("s60v5",page.toString(),"15",appid,category);
            }
        }
    }
}
