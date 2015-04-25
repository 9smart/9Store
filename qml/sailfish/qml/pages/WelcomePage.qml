import QtQuick 2.0
import Sailfish.Silica 1.0
import "./components"
import "../js/applist.js" as JS
Page{
    id:welcome
    property int pagenum:1
    property int listsum: 0
    property string photoUrl: ""
    Component.onCompleted: {
        //pagenum,os,order,model,type,category,pagesize
        JS.loadAppList(pagenum,window.os_type,"scores",hotappModel,"","","6")
        JS.loadAppList(pagenum,window.os_type,"views",newappModel,"","","6")
    }

    ListModel{id:listmodel}
    ListModel{id:hotappModel}
    ListModel{id:newappModel}
    Progress{
        id:progress
        anchors.centerIn: parent
    }

    SilicaFlickable{
        id:flick
        visible: !busyIndicator.running
        opacity:(progress.visible?0:1)
        PullDownMenu {
            id:pulldownid
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("My Apps")
                onClicked: pageStack.push(Qt.resolvedUrl("DownloadPage.qml"))
            }
        }

        PageHeader{
            id:header
            title: qsTr("Welcome,")+nickname
        }
        anchors.fill: parent
        contentHeight: content.height + header.height+ category.height + Theme.paddingLarge
        Item{
            id: content
            width: parent.width
            height: hotappBak.height+newappItem.height
            Component.onCompleted: {
                conBusy.running=false
                content.visible = true;
            }
            BusyIndicator {
                id: conBusy
                anchors.centerIn: parent
                running: true
                size: BusyIndicatorSize.Medium
            }
            visible: false
            anchors.top: header.bottom
            BackgroundItem{
                id:hotappBak
                Component.onCompleted: {
                    habusy.running = false
                }
                BusyIndicator {
                    id: habusy
                    anchors.centerIn: parent
                    running: true
                    size: BusyIndicatorSize.Small
                }
                visible: !habusy.running
                anchors.top:parent.top
                height: hotgrid.height + Theme.itemSizeMedium + Theme.paddingMedium
                width: parent.width
                MoreButton{
                    id:feedButton
                    width:parent.width
                    visible: !habusy.running
                    anchors.top: parent.top
                    height: Theme.itemSizeMedium
                    text: qsTrId("HotApps")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("HotList.qml"),
                                       {"query_type":"views"
                                       });
                    }
                    WelcomeBoxBackground {
                        anchors.fill: parent
                        z: -1
                    }
                }
                AppGridListComponet{
                    id:hotgrid
                    width:parent.width
                    visible: false
                    Component.onCompleted: {
                        hotgrid.visible = true;
                    }
                    anchors{
                        left:parent.left
                        right:parent.right
                        top:feedButton.bottom
                    }
                    model: hotappModel
                    VerticalScrollDecorator {flickable: flick}
                }

            }

            BackgroundItem{
                Component.onCompleted: {
                    nibusy.running = false
                }
                BusyIndicator {
                    id: nibusy
                    anchors.centerIn: parent
                    running: true
                    size: BusyIndicatorSize.Small
                }
                id:newappItem
                visible: !nibusy.running
                anchors.top:hotappBak.bottom
                //height: childrenRect.height
                //contentHeight:childrenRect.height
                height: newgrid.height + Theme.itemSizeMedium + Theme.paddingMedium
                width: parent.width
                MoreButton{
                    id:newapps
                    visible: !nibusy.running
                    width:parent.width
                    anchors.top: parent.top
                    height: Theme.itemSizeMedium
                    text: qsTrId("NewApps")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("HotList.qml"),
                                       {"query_type":"views"
                                       });
                    }
                    WelcomeBoxBackground {
                        anchors.fill: parent
                        z: -1
                    }
                }
                AppGridListComponet{
                    id:newgrid
                    visible: false
                    Component.onCompleted: {
                        newgrid.visible = true;
                    }

                    anchors{
                        left:parent.left
                        right:parent.right
                        top:newapps.bottom
                    }
                    model: newappModel
                    VerticalScrollDecorator {flickable: flick}
                }

            }

            BackgroundItem{
                Component.onCompleted: {
                    apclassbi.running = false
                    category.visible = true
                }
                BusyIndicator {
                    id: apclassbi
                    anchors.centerIn: parent
                    running: true
                    size: BusyIndicatorSize.Small
                }
                id:category
                visible: !apclassbi.running
                anchors.top:newappItem.bottom
                height: allclass.height + gameclass.height+ appclass.height
                width: parent.width
                MoreButton{
                    id:allclass
                    visible: !apclassbi.running
                    width:parent.width
                    anchors.top: parent.top
                    height: Theme.itemSizeMedium
                    text: qsTrId("All Class")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("AppClass.qml"));
                    }
                    WelcomeBoxBackground {
                        anchors.fill: parent
                        z: -1
                    }
                }
                MoreButton{
                    id:gameclass
                    width:parent.width
                    visible: !apclassbi.running
                    anchors.top: allclass.bottom
                    height: Theme.itemSizeMedium
                    text: qsTrId("Game Class")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("AppClass.qml"),{"classtype":"game"});
                    }
                }
                MoreButton{
                    id:appclass
                    visible: !apclassbi.running
                    width:parent.width
                    anchors.top: gameclass.bottom
                    height: Theme.itemSizeMedium
                    text: qsTrId("Apps Class")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("AppClass.qml"),{"classtype":"app"});
                    }

                }

            }


        }
     VerticalScrollDecorator {flickable: flick}

    }

    Label {
        anchors {
            left: parent.left
            right: parent.right
            bottom: busyIndicator.top
            margins: Theme.paddingLarge
        }
        width: parent.width
        visible: busyIndicator.running
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.Wrap
        font.pixelSize: Theme.fontSizeExtraLarge
        color: Theme.highlightColor
        text: qsTrId("Loading...")
    }

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: !PageStatus.Active
        size: BusyIndicatorSize.Large
    }
}
