// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../BaseComponent"
MyListItem{    
    id:wrapper;
    width: screen.width;
    height: 80;
    Image{
        id:sicon;
        sourceSize.height: 60;
        sourceSize.width: 60;
        height: sourceSize.height;
        width:sourceSize.width;
        anchors{
            verticalCenter: parent.verticalCenter;
            left: parent.left;
            leftMargin: 15;
        }
        source: model.icon;
        Image{
            anchors.fill: parent;
            source: "../../pic/General/App_icon_Loading.svg";
            visible: parent.status==Image.Loading;
        }
        Image{
            anchors.fill: parent;
            source: "../../pic/General/App_icon_Error.svg";
            visible: parent.status==Image.Error;
        }
    }
    Text{
        id:name;
        anchors.top: sicon.top;
        anchors.left: sicon.right;
        anchors.leftMargin: 15;
        text: model.name;
        font.pixelSize: 22;
    }
    ProgressBar{
        id:progress;
        width: 195;
        anchors{
            top: name.bottom;
            topMargin: 15;
            left: name.left;
        }
    }
    Image{
        id: downloadstate;
        anchors{
            verticalCenter: parent.verticalCenter;
            right: parent.right;
            rightMargin: 15;
        }
        height: sourceSize.height;
        width: sourceSize.width;
    }
    onClicked:{
        if(state === "Erro"){
            redownloaddialog.openDia(model.id, model.name, model.icon, index);
        }
        else if(state === "Downloaded"){
            if(settings.silenceInstall){
                signalCenter.showMessage(model.name + " start installing!");
                fileoperate.openFile(1, model.filename);

            }
            else{
                fileoperate.openFile(2, model.filename);
            }
        }
    }

    states: [
        State {
            name: "Waiting";
            PropertyChanges{
                target: progress;
                value: 0;
            }
            PropertyChanges{
                target: downloadstate;
                source: "../../pic/TopCharts/Downloading.svg";
            }
            when: downloader.isTaskExist(model.url) && !downloader.isFileExist(model.filename) && !downloader.isCurrentUrl(model.url);
        },
        State{
            name:"Downloading";
            PropertyChanges{
                target: progress;
                value: downloader.progress;
            }
            PropertyChanges{
                target: downloadstate;
                source: "../../pic/TopCharts/Downloading.svg";
            }
            when: downloader.isCurrentUrl(model.url);
        },
        State{
            name:"Downloaded";
            PropertyChanges{
                target: progress;
                value: 1;
            }
            PropertyChanges{
                target: downloadstate;
                source: "../../pic/TopCharts/Downloaded.svg";
            }
            when: downloader.isFileExist(model.filename) && !downloader.isCurrentUrl(model.url) && fileoperate.currentInstallFile !== model.filename;
        },
        State{
            name:"Installing";
            PropertyChanges{
                target: progress;
                value: 1;
            }
            PropertyChanges{
                target: downloadstate;
                source: "../../pic/TopCharts/Installing.svg";
            }
            when: fileoperate.currentInstallFile === model.filename
        },
        State{
            name:"Installed";
        },
        State{
            name:"Erro";
            PropertyChanges{
                target: progress;
                value: 0;
            }
            PropertyChanges{
                target: downloadstate;
                source: "../../pic/TopCharts/Downloaderr.svg";
            }
            when: !downloader.isFileExist(model.filename) && !downloader.isCurrentUrl(model.url);
        }

    ]

    Connections{
        target: downloader;
        onCurrentUrlChanged:{
            if(downloader.isCurrentUrl(model.url)){
                state = "Downloading";
            }
            else if(downloader.isFileExist(model.filename)){
                state = "Downloaded";
            }
            else if(downloader.isTaskExist(model.url)){
                state = "Waiting";
            }
            else{
                state = "Erro";
            }
        }
    }

    Connections{
        target: fileoperate;
        onCurrentInstallFileChanged:{
            if(fileoperate.currentInstallFile === model.filename){
                state = "Installing";
            }
        }
    }
}

