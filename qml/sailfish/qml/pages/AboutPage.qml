/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
import QtQuick 2.0
import Sailfish.Silica 1.0
Page {
    id: aboutPopup
    Item {
        id: aboutInfos
        property string version:'0.1'
        property string text:
                             "     一个关注小众系统的应用商店<br/>主要功能：<br/>1、分类浏览；<br/>2、搜索；<br/>3、根据人气和下载量浏览；<br/>4、应"+
                             "用下载列表，直接点击下载列表即可进行安装。<br/><br/>开发团队：<br/>Qshen负责程序主逻辑及Symbian^3版本的开发；<br/>沛秦负责S60V5版的移植；"+
                             "<br/>狂魔负责图标以及界面设计；<br/>掌叔负责服务器端程序。<br/><br/>久智团队介绍<br/>团队定位<br/>国内首支依托Qt跨平台优势，专注小众系统的应用"+
                             "开发，及在国内的发展与推广。<br/><br/>目前成果<br/>久店（9Store）小众系统应用商店，塞班版，米狗版，旗鱼版开发中。<br/>久闻（9News）小众系"+
                             "统相关最新资讯。<br/><br/>发展方向<br/>做中国最专业的小众系统综合网络平台。提供资源下载，新闻资讯，开发教程，手机及配件商城，应用开发外包等一体化服务。"+
                             "<br/><br/>团队组成<br/>目前团队成员共有六人：<br/>Qshen目前"+
                             "正在负责塞班3黑莓以及米狗系统下的久店开发与维护。<br/>沛秦目前负责久店的S60V5版的移植和适配。<br/>Birdzhang目前负责久店的旗鱼版开发。<br/>梦梦目前负责久店的图标设计。"+
                             "<br/>雨后星辰目前负责久闻的开发及Ubuntu版的久店开发。<br/>掌叔目前负责久店的服务器端开发与web平台的搭建。<br/><br/>欢迎加入<br/>欢迎广大移动平台开发和爱好者加入我们，"+
                             "我们热爱技术是一个团结有爱，充满包容并积极向上的团体。<br/><br/>联系方式<br/>QQ群："+
                             "346578991<br/>Email：contact@9smart.cn<br/>官网：www.9smart.cn" ;
    }

    SilicaFlickable {
        id: aboutFlick
        anchors.fill: parent
        PageHeader {
            id: header
            title: qsTr("About")
        }
        width: Screen.width
        contentHeight: contentItem.childrenRect.height
        contentWidth: aboutFlick.width
        clip:true
        VerticalScrollDecorator { flickable: aboutFlick }



        Column {
            id: aboutColumn
            anchors {
                left: parent.left
                right: parent.right
                top:header.bottom
                margins: Theme.paddingMedium
            }
            spacing: Theme.paddingMedium

            Item {
                width: 1
                height: Theme.paddingMedium
            }
            Label {
                id: content
                text: aboutInfos.text
                width: aboutFlick.width-Theme.paddingLarge
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                //textFormat: Text.RichText
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingMedium
                }
                onLinkActivated: {
                    Qt.openUrlExternally(link)
                }
            }
        }
    }
}
