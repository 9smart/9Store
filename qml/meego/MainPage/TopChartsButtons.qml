// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Image{
    id:root;
    source: "../../pic/TopCharts/ButtonRow_Background.svg";
    sourceSize: Qt.size(screen.displayWidth, 60);
    property int highlightItem:1;
    signal newestClicked;
    signal mostPopClicked;
    signal mostDlClicked;
    Row{
        Item{
            width: 158;
            height: 60;
            Rectangle{
                anchors.fill: parent;
                color: "#787878";
                opacity: 0.2;
                visible: highlightItem==1;
            }
            Text{
                anchors.centerIn: parent;
                text: qsTr("Newest");
                font.pixelSize: 28
            }
            MouseArea{
                anchors.fill: parent;
                onClicked: {
                    root.highlightItem=1;
                    root.newestClicked();
                }
            }
        }
        Rectangle{
            width: 3;
            height: 60;
            color: "#b4b4b4";
            opacity: 0.3;
        }
        Item{
            width: 158;
            height: 60;
            Rectangle{
                anchors.fill: parent;
                color: "#787878";
                opacity: 0.2;
                visible: highlightItem==2;
            }
            Text{
                anchors.centerIn: parent;
                text: qsTr("Most pop");
                font.pixelSize: 28
            }
            MouseArea{
                anchors.fill: parent;
                onClicked: {
                    root.highlightItem=2;
                    root.mostPopClicked();
                }
            }
        }
        Rectangle{
            width: 3;
            height: 60;
            color: "#b4b4b4";
            opacity: 0.3;
        }
        Item{
            width: 158;
            height: 60;
            Rectangle{
                anchors.fill: parent;
                color: "#787878";
                opacity: 0.2;
                visible: highlightItem==3;
            }
            Text{
                anchors.centerIn: parent;
                text: qsTr("Most dl");
                font.pixelSize: 28
            }
            MouseArea{
                anchors.fill: parent;
                onClicked: {
                    root.highlightItem=3;
                    root.mostDlClicked();
                }
            }
        }
    }
}
