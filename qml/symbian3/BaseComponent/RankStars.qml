// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Row{
    id:root;
    property real ranknum: 5;
    property int size:18;
    property bool optional:  false;
    Repeater{
        model: 5;
        Image{
            height: size;
            width: size;
            smooth: true;
            source: {
                if((ranknum-index)>=1)
                    return "../../pic/General/Score_1.svg";
                else if((ranknum-index)>0&&(ranknum-index)<1)
                    return "../../pic/General/Score_2.svg";
                else return "../../pic/General/Score_3.svg"
            }
            MouseArea{
                anchors.fill: parent;
                enabled: optional;
                onClicked: {
                    ranknum=index+1;
                }
            }
        }
    }
}
