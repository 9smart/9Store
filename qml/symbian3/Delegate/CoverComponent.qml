// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Image {
    id: root;
    height: 170;
    width: parent.width;
    source: model.thumb;
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
}
