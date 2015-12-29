import QtQuick 2.0
import Sailfish.Silica 1.0

Page{
    property int userstate:0;
    property string uid;
    property string accesstoken;
    property string nickname;
    property string avatar;
    property string gender;
    property string logintype;

    SilicaFlickable{
        id:fickable
        contentHeight:123
        VerticalScrollDecorator {}
        PageHeader{
            id:header
            title:qsTr("Settings")
        }

        TextSwitch {
            id: allowAllOrientations
            checked: false
            text: "Allow all orientations"
        }

    }


}
