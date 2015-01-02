// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../BaseComponent"
import "../Delegate"
import "../../JavaScript/main.js" as Script
Flickable{
    id:root;
    clip: true;
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
        delegate: CoverComponent{}
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
    Image{
        anchors.bottom: cover.bottom;
        anchors.right: cover.right;
        source: {
            switch(cover.currentIndex){
                case 0:
                    return "../../pic/Home/Poster_Pageindicator1.svg";
                case 1:
                    return "../../pic/Home/Poster_Pageindicator2.svg";
                case 2:
                    return "../../pic/Home/Poster_Pageindicator3.svg";
                case 3:
                    return "../../pic/Home/Poster_Pageindicator4.svg";
            }
        }
    }
    MyListHeading{
        id:heading;
        width: parent.width;
        anchors.top: cover.bottom;
        text: title;
    }
    Column{
        id:featuredapp;
        width: parent.width;
        anchors.top: heading.bottom;
        Repeater{
            model:featuredmodel;
            delegate: ListComponent{}
        }
    }
    Component.onCompleted: {
        if(covermodel.count===0)
            Script.getcover();
        if(featuredmodel.count===0)
            Script.getfeatured("belle");
    }
}
