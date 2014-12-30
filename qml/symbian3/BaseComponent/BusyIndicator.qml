// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Image{
    id:root;
    property int num:1;
    source: "../../pic/Loading/Loading_"+num.toString()+".svg";
    NumberAnimation on num{
        running: true;
        loops: Animation.Infinite;
        from: 1;
        to:8;
    }
}
