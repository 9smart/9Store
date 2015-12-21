// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../BaseComponent"
Rectangle{
    id: maininfo;
    width: screen.width;
    height: 90;
    color: "#f5f5f5";
    Image{
        id:bigicon;
        anchors{
            left: parent.left;
            top: parent.top;
            leftMargin: 15;
            topMargin: 10;
        }
        width: 80;
        height: 80;
        source: icon;
        smooth: true;
        Image{
            anchors.fill: parent;
            source: "../../pic/General/App_icon_Loading.svg";
            visible: parent.status == Image.Loading;
        }
        Image{
            anchors.fill: parent;
            source: "../../pic/General/App_icon_Error.svg";
            visible: parent.status == Image.Error;
        }
    }
    Column{
        anchors{
            bottom: parent.bottom;
            left: bigicon.right;
            leftMargin: 15;
        }
        RankStars{
            ranknum: score_num === 0? 0 : (scores / score_num);
            size: 21;
        }
        Text{
            text: qsTr("By:") + developer;
            font.pixelSize: 15;
            color: "gray";
        }
        Text{
            text: type+" > " + category;
            font.pixelSize: 15;
            color: "gray"
        }
        Text{
            text: "v" + version + " - " + size;
            font.pixelSize: 15;
            color: "gray"
        }
    }    
}
