// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Image
     {
      property int n: 1;
      anchors.fill: parent;
      source: "../../pic/launch/l-"+n+".jpg";
      NumberAnimation on n
                     {
                      from:1;
                      to:6;
                      duration:1000;
                     }
     }
