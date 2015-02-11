// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "BaseComponent"
MyPage{
    id:aboutpage;
    property string newversion;
    title: qsTr("About");
    ToolBar{
        id:toolbar;
        z:1;
        homeButtonVisible: false;
        topChartsButtonVisible: false;
        searchButtonVisible: false;
        personalButtonVisible: false;
        highlightItem: 0;
        onBackButtonClicked: pageStack.pop();
    }
    Head{
        id:head;
        titleText: title;
    }
    Flickable{
        anchors{
            fill: parent;
            topMargin: head.height;
            bottomMargin: toolbar.height;
        }
        flickableDirection: Flickable.VerticalFlick
        contentHeight: column.height+15;
        clip: true;
        Column{
            id:column;
            anchors{
                verticalCenter: parent.verticalCenter;
                left: parent.left;
                right: parent.right;
                margins: 15;
            }
            spacing: 20;
            Text{
                anchors.left: parent.left;
                anchors.right: parent.right;
                wrapMode: Text.WrapAnywhere;
                text:"    一个关注小众系统的应用商店\n主要功能：\n1、分类浏览；\n2、搜索；\n3、根据人气和下载量浏览；\n4、应用下载列表，直接点击下载列表即可进行安装。\n\n开发团队：\nQshen负责程序主逻辑及Symbian^3版本的开发；\n沛秦负责S60V5版的移植；\n狂魔负责图标以及界面设计；\n掌叔负责服务器端程序。\n\n久智团队介绍\n团队定位\n国内首支依托Qt跨平台优势，专注小众系统的应用开发，及在国内的发展与推广。\n\n目前成果\n久店（9Store）小众系统应用商店，塞班版，米狗版，旗鱼版开发中。\n久闻（9News）小众系统相关最新资讯。\n\n发展方向\n做中国最专业的小众系统综合网络平台。提供资源下载，新闻资讯，开发教程，手机及配件商城，应用开发外包等一体化服务。\n\n团队组成\n目前团队成员共有六人：\nQshen目前正在负责塞班3黑莓以及米狗系统下的久店开发与维护。\n沛秦目前负责久店的S60V5版的移植和适配。\nBirdzhang目前负责久店的旗鱼版开发。\n梦梦目前负责久店的图标设计。\n雨后星辰目前负责久闻的开发及Ubuntu版的久店开发。\n掌叔目前负责久店的服务器端开发与web平台的搭建。\n\n欢迎加入欢迎广大移动平台开发和爱好者加入我们，我们热爱技术是一个团结有爱，充满包容并积极向上的团体。\n\n联系方式\nQQ群：346578991\nEmail：contact@9smart.cn\n官网：www.9smart.cn" ;
            }
            Button{
                platformInverted: true;
                width: 300;
                anchors.horizontalCenter: parent.horizontalCenter;
                text: qsTr("Check for new version");
                onClicked: Script.getversion();
            }
        }
    }
    QueryDialog{
        id:verquerydia;
        platformInverted: true;
        titleText: qsTr("New version has been found")
        message: qsTr("Whether to download the new version?");
        acceptButtonText: qsTr("Yes");
        rejectButtonText: qsTr("No");
        onAccepted:{
            var file=downloadpath+"105.sis";
            downloadmodel.append({"icon":"http://yayabo-s1.stor.sinaapp.com/png/201410/14128173469x5.thumb.png","name":"久店","url":"http://api.9smart.cn/app/105?download=download","file":file});
            qcurl.appenddl("http://api.9smart.cn/app/105?download=download",file);
            signalCenter.showMessage(qsTr("Download appended!"));
        }
    }
    Connections{
        target: signalCenter;
        onVersionGeted:{
            newversion=Script.version;
            if(Script.isnew(version,newversion)){
                signalCenter.showMessage(qsTr("This version is the new newest version"));
            }
            else verquerydia.open()
        }
    }
}
