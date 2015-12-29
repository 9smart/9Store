import QtQuick 2.0
import Sailfish.Silica 1.0
import com.stars.widgets 1.0
BackgroundItem{
    id:showcomments
    //height:(userPic.height>messageid.height?(userPic.height+nick.height):(messageid.height+nick.height))
    height: scoreBox.height+nick.height+messageid.height+Theme.paddingMedium*4
    width: parent.width
    anchors.leftMargin: Theme.paddingSmall
    anchors.rightMargin: Theme.paddingSmall
    MyImage{
        id:userPic
        width:Screen.width/5
        height:Screen.width/5
        source: avatar
        smooth: true
        anchors {
            left: parent.left
            top:scoreBox.bottom
            leftMargin: Theme.paddingSmall
            topMargin: Theme.paddingMedium
            //verticalCenter:parent.verticalCenter
        }
    }
    RatingBox {
        id:scoreBox
        score:scorenum
        //width:parent.width
        anchors {
            left: userPic.right
            top:parent.top
            leftMargin: Theme.paddingSmall
            topMargin: Theme.paddingSmall
        }
    }

    Label{
        id:nick
        text:nickname
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.highlightColor
        horizontalAlignment: Text.AlignLeft
        truncationMode: TruncationMode.Elide
        width: parent.width-userPic.width
        anchors {
            top:scoreBox.bottom
            left: scoreBox.left
            leftMargin: Theme.paddingSmall
            topMargin: Theme.paddingMedium
        }
    }

    Label{
        id:date
        text:user_dateline
        font.pixelSize: Theme.fontSizeExtraSmall
        font.italic: true
        horizontalAlignment: Text.AlignRight
        anchors{
            right:parent.right
            top:parent.top
            rightMargin: Theme.paddingLarge
        }
    }

    Label{
        id:messageid
        text:message
        width: parent.width-userPic.width-Theme.paddingMedium
        font.pixelSize: Theme.fontSizeExtraSmall
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignLeft
        truncationMode: TruncationMode.Elide
        anchors {
            top:nick.bottom
            left: scoreBox.left
            leftMargin: Theme.paddingSmall
        }
    }

    Separator {
        visible: (index>0?true:false)
        width:parent.width;
        color: Theme.highlightColor
    }

}
