// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
Flickable{
    id:root;
    width:parent.width;
    flickableDirection: Flickable.HorizontalFlick;
    PathView{
        id:cover;
        height: 170;
    }
    ListHeading{
        id:heading;
        width: parent.width;
        platformInverted: true;
        anchors.top: cover.bottom;
        ListItemText{
            anchors.fill: parent.paddingItem;
            platformInverted: true;
            role: "Title";
            text: qsTr("Featured");
        }
    }
    ListView{
        id:featuredview;
        width: parent.width;
        anchors.top: heading.bottom;
    }
}
