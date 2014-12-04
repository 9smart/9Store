// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Rectangle
         {
          width: parent.width;
          height: 54;
          radius: 4;
          gradient: Gradient
                            {
                             GradientStop
                                         {
                                          position: 1;
                                          color: "lightgray";
                                         }
                             GradientStop
                                         {
                                          position: 0;
                                          color: "white";
                                         }
                            }
         }
