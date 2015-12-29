// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Image {
    id: root;
    height: 170;
    width: parent.width;
    source: "http://apps-images.9smart.cn/" + model.uploader.uid + "/p/" + model._id;
    Rectangle{
        anchors.fill: parent;
        color: "lightgray";
        visible: parent.status == Image.Loading?true:false;
    }
    Image{
        anchors.fill: parent;
        source: "../../pic/Home/Poster_Error.png"
        visible: parent.status == Image.Error?true:false;
    }
    states: [
        State{
            name:"focused";
            when: parent.parent.currentIndex===index;
            PropertyChanges{
                target: root;
                opacity:0.5;
            }
        },
        State{
            name:"unfocused";
            when: parent.parent.currentIndex!==index;
            PropertyChanges{
                target: root;
                opacity:1;
            }
        }

    ]
    transitions: [
        Transition{
            from: "focused";
            to:"unfocused";
            PropertyAnimation{
                target: root;
                properties: "opacity";
                duration: 500;
            }
            reversible: true;
        }
    ]
    MouseArea{
        anchors.fill: parent;
        onClicked: {
            pageStack.push(Qt.resolvedUrl("../InfoPage.qml"),
                           {_id:model._id, title:model.appname, icon:"http://apps-images.9smart.cn/" + model.uploader.uid + "/i/" + model._id, score_num:((model.score_num)?model.score_num:0), scores:((model.scores)?model.scores:0), developer:model.developer});
        }
    }
}
