import QtQuick 2.0
import Sailfish.Silica 1.0

SilicaGridView {
    id: gridView
    clip: true
    height: childrenRect.height
    width: childrenRect.width
    currentIndex: -1
    cellWidth: gridView.width / 3
    cellHeight: cellWidth
    delegate: BackgroundItem {
        id: rectangle
        width: gridView.cellWidth
        height: gridView.cellHeight
        Label{
            id: moreAppname
            x: morepic.width/2
            text:appname
            width:rectangle.width-Theme.paddingMedium
            truncationMode: TruncationMode.Elide
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingMedium
            font {
                pixelSize: Theme.fontSizeSmall
                family: Theme.fontFamilyHeading
            }
        }
        Label{
            id:moreimgid
            height: parent.width/2
            width:moreimgid.height
            anchors{
                left:parent.left
                right:parent.right
                top:moreAppname.bottom
                margins: Theme.paddingMedium
            }
            CacheImage{
                id:morepic
                //anchors.fill: parent
                asynchronous: true
                sourceUncached: icon
                fillMode: Image.PreserveAspectFit;
                width: parent.height
                height:parent.height
                source: icon
                Image{

                    anchors.fill: parent;
                    source: "../../img/App_icon_Loading.svg";
                    visible: parent.status==Image.Loading;
                }
                Image{

                    anchors.fill: parent;
                    source: "../../img/App_icon_Error.svg";
                    visible: parent.status==Image.Error;
                }
            }
        }
        onClicked :{
            pageStack.push(Qt.resolvedUrl("../AppDetail.qml"),{
                                  "appid":appid,
                                  "author":author,
                                  "appname":appname
                              })
        }

    }

    VerticalScrollDecorator {}

}

