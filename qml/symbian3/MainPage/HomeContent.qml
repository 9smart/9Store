// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../../JavaScript/main.js" as Script
Flickable{
    id:root;
    contentHeight: cover.height+heading.height+featuredapp.height;
    width:screen.width;
    flickableDirection: Flickable.VerticalFlick;
    PathView{
        id:cover;
        height: 170;
        width: parent.width;
        model:covermodel;
        clip: true;
        preferredHighlightBegin: 0.5;
        preferredHighlightEnd: 0.5;
        delegate: CoverDelegate{}
        path: Path{
            startX: -cover.width*cover.count/2+cover.width/2;
            startY: cover.height/2;
            PathLine{
                x:cover.width*cover.count/2+cover.width/2;
                y:cover.height/2;
            }
        }
        Timer{
            running: cover.visible && cover.count>0 && !cover.moving;
            interval: 3000;
            repeat: true;
            onTriggered: cover.incrementCurrentIndex;
        }
    }
    ListHeading{
        id:heading;
        width: parent.width;
        platformInverted: true;
        anchors.top: cover.bottom;
        ListItemText{
            anchors.fill: parent.paddingItem;
            platformInverted: true;
            text: qsTr("Featured");
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 19
        }
        Rectangle{
            width: parent.width;
            anchors.top: parent.bottom;
            height: 1
            color: "#c9c9c9";
        }
    }
    Column{
        id:featuredapp;
        width: parent.width;
        anchors.top: heading.bottom;
        anchors.topMargin: 1;
        Repeater{
            model:featuredmodel;
            delegate: ListItemDelegate{}
        }
    }
    Component.onCompleted: {
        if(covermodel.count===0)
            Script.getcover();
        if(featuredmodel.count===0)
            Script.getfeatured("belle");
    }
}
