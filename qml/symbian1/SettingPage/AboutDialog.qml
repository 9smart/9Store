import QtQuick 1.0
import com.nokia.symbian 1.0
import com.nokia.extras 1.0
import "../Main"
import "../../JavaScript/main.js" as Script

CustomDialog {
    id:aboutdia;
    //platformInverted: true;
    titleText:qsTr("About");
    buttonTexts:[qsTr("OK")];
    content:Flickable {
        width:300;
        height:400;
        flickableDirection: Flickable.VerticalFlick;
        contentHeight:abouttext.height+24;
        Text {
            id:abouttext;
            height: paintedHeight;
            anchors.right: parent.right;
            anchors.left: parent.left;
            anchors.top:parent.top;
            anchors.margins: 12;
            wrapMode: Text.WrapAnywhere;
            font.pixelSize: 15; color: "White";
            text: getAboutText();

            function getAboutText() {
                var text = "";
                text = text + "    一个关注小众系统的应用商店\n";
                text = text + "主要功能：\n";
                text = text + "1、分类浏览；\n2、搜索；\n3、根据人气和下载量浏览；\n4、应用下载列表，直接点击下载列表即可进行安装。\n\n";
                text = text + "开发团队：\n";
                text = text + "Qshen负责程序主逻辑及Symbian^3版本的开发；\n沛秦负责S60V5版的移植；\n";
                text = text + "狂魔负责图标以及界面设计；\n掌叔负责服务器端程序。\n\n";
                text = text + "久智团队介绍\n团队定位\n国内首支依托Qt跨平台优势，专注小众系统的应用开发，及在国内的发展与推广。\n\n";
                text = text + "目前成果\n久店（9Store）小众系统应用商店，塞班版，米狗版，旗鱼版开发中。\n";
                text = text + "久闻（9News）小众系统相关最新资讯。\n\n";
                text = text + "发展方向\n做中国最专业的小众系统综合网络平台。提供资源下载，新闻资讯，开发教程，手机及配件商城，应用开发外包等一体化服务。\n\n";
                text = text + "团队组成\n目前团队成员共有六人：\nQshen目前正在负责塞班3黑莓以及米狗系统下的久店开发与维护。\n";
                text = text + "沛秦目前负责久店的S60V5版的移植和适配。\nBirdzhang目前负责久店的旗鱼版开发。\n";
                text = text + "梦梦目前负责久店的图标设计。\n雨后星辰目前负责久闻的开发及Ubuntu版的久店开发。\n";
                text = text + "掌叔目前负责久店的服务器端开发与web平台的搭建。\n\n";
                text = text + "欢迎加入欢迎广大移动平台开发和爱好者加入我们，我们热爱技术是一个团结有爱，充满包容并积极向上的团体。\n\n";
                text = text + "联系方式\nQQ群：346578991\nEmail：contact@9smart.cn\n官网：www.9smart.cn";
                return text;
            }
        }
    }
}
