import QtQuick 1.0
import "Main"
import "../JavaScript/main.js" as Script
import com.nokia.symbian 1.1
import Qt.labs.folderlistmodel 1.0

Mypage {
    id:uploadpage;
    height: 854;
    width: 480;
    tools: ToolBarLayout {
        ToolIcon {
            platformIconId: privateStyle.toolBarIconPath("toolbar-back");
            onClicked: pageStack.pop();
        }
    }
    FolderListModel {
        id:foldlistmodel;
        folder: "/home";
        showDotAndDotDot: true;
        showOnlyReadable: true;
    }
    ListModel {
        id:categorymodel;
    }
    ContextMenu {
        id:categorymenu;
        MenuLayout {
            Repeater {
                model: categorymodel;
                MenuItem {
                    text:model.category;
                    onClicked: {
                        category.text=model.category;
                    }
                }
            }
        }
    }
    ContextMenu {
        id:foldmenu;
        MenuLayout {
            MenuItem {
                text: qsTr("..(Parent folder)");
                onClicked: {
                    foldlistmodel.folder=foldlistmodel.parentFolder;
                }
            }
            Repeater {
                model: foldlistmodel;
                MenuItem {
                    text: model.filename;
                    onClicked: {
                        if(FolderListModel.isFolder(index)===true) {
                            foldlistmodel.folder=model.filePath;
                        } else {
                            file.text=model.filePath;
                            foldmenu.close();
                        }
                    }
                }
            }
        }
    }
    Head {
        id:head;
        z:1;
        Image {
            id:icon;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: parent.left;
            anchors.leftMargin: 15;
            height: 45;
            width: 45;
            source: "Resource/icon.svg";
        }
        Text {
            text: qsTr("Upload");
            font.pixelSize: 32;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: icon.right;
            anchors.rightMargin: 15;
        }
    }
    Column {
        id:colu;
        anchors.top: head.bottom;
        Item {
            width: parent.parent.width;
            height: 70;
            Row {
                anchors.left: parent.left;
                anchors.leftMargin: 20;
                anchors.verticalCenter: parent.verticalCenter;
                Text {
                    text: qsTr("Name:");
                    font.pixelSize: 26;
                    anchors.verticalCenter: parent.verticalCenter;
                }
                TextField {
                    id:name;
                    width: 260;
                    height: 40;
                    placeholderText: qsTr("Please input the name");
                }
                spacing: 20;
            }
        }
        Item {
            width: parent.parent.width;
            height: 70;
            Row {
                anchors.left: parent.left;
                anchors.leftMargin: 20;
                anchors.verticalCenter: parent.verticalCenter;
                Text {
                    text: qsTr("Type:");
                    font.pixelSize: 26;
                    anchors.verticalCenter: parent.verticalCenter;
                }
                TextField {
                    id:type;
                    width: 260;
                    height: 40;
                    placeholderText: qsTr("app or game?")
                }
                spacing: 20;
            }
        }
        Item {
            width: parent.parent.width;
            height: 70;
            Row {
                anchors.left: parent.left;
                anchors.leftMargin: 20;
                anchors.verticalCenter: parent.verticalCenter;
                Text {
                    text: qsTr("category:");
                    font.pixelSize: 26;
                    anchors.verticalCenter: parent.verticalCenter;
                }
                TextField {
                    id:category;
                    width: 200;
                    height: 40;
                }
                Button {
                    id:selectbutton;
                    text: qsTr("select");
                    height: 40;
                    width: 80;
                    onClicked: {
                        if(type.text==="")
                            signalcenter.showMessage(qsTr("Please input the type"));
                        else {
                            if(categorymenu.status===DialogStatus.Closed) {
                                Script.getcategory(category.text);
                                categorymenu.open();
                            } else
                                categorymenu.close();
                        }
                    }
                }
                spacing: 20;
            }
        }
        Item {
            width: parent.parent.width;
            height: 240;
            Row {
                anchors.left: parent.left;
                anchors.leftMargin: 20;
                anchors.verticalCenter: parent.verticalCenter;
                Text {
                    text: qsTr("summary:");
                    font.pixelSize: 26;
                }
                TextField {
                    id:summary;
                    width: 260;
                    height: 200;
                    placeholderText: qsTr("Please input the summary");
                }
                spacing: 20;
            }
        }
        Item {
            width: parent.parent.width;
            height: 70;
            Row {
                anchors.left: parent.left;
                anchors.leftMargin: 20;
                anchors.verticalCenter: parent.verticalCenter;
                Text {
                    text: qsTr("file:");
                    font.pixelSize: 26;
                    anchors.verticalCenter: parent.verticalCenter;
                }
                TextField {
                    id:file;
                    width: 200;
                    height: 40;
                }
                Button {
                    id:filebutton;
                    text: qsTr("select");
                    height: 40;
                    width: 80;
                    onClicked: {
                        foldmenu.open();
                    }
                }
                spacing: 20;
            }
        }
    }
    Button {
        id:ulbutton;
        height: 50;
        width: 100;
        anchors.top: colu.bottom;
        anchors.topMargin: 20;
        anchors.right: parent.right;
        anchors.rightMargin: 20;
        text: qsTr("upload");
        onClicked: {
            if(file.text==="") {
                signalcenter.showMessage(qsTr("Please choose the file"));
            } else {
                Script.getfilehash(fileopt.fileHash(file.text));
            }
        }
    }
    Connections {
        target: signalCenter;
        onFilehashgeted: {
            var isfileexist=Script.isexist;
            if(isfileexist===1) {
                signalcenter.showMessage(qsTr("App existed"));
            } else if(fileopt.checkfilesize(file.text)===false) {
                signalcenter.showMessage(qsTr("Sorry,we can't upload files which are larger than 10M now"));
            }
            //else ulqcurl.appendul("http://api.9smart",file.text);
        }
    }
}
