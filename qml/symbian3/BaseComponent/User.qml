// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item{
    property bool userState: false;
    property string _id;
    property string auth;

    property string nickName;
    property string avatar;
    property string avatar_hd;

    property string group;

    property alias noticeModel: noticemodel;

    ListModel{
        id: noticemodel;
    }

    function clear(){
        userState = false;
        _id = "";
        auth = "";
        nickName = "";
        avatar = "";
        avatar_hd = "";

        noticemodel.clear();
    }
}
