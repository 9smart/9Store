import QtQuick 1.0

Rectangle {
    width: parent.width;
    height: 54;
    radius: 4;
    gradient: Gradient {
        GradientStop {
            position: 1;
            color: "LightGrey";
        }
        GradientStop {
            position: 0;
            color: "White";
        }
    }
}
