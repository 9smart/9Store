import QtQuick 1.0
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
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
                text = text + "    ä¸€ä¸ªå…³æ³¨å°ä¼—ç³»ç»Ÿçš„åº”ç”¨å•†åº—\n";
                text = text + "ä¸»è¦åŠŸèƒ½ï¼š\n";
                text = text + "1ã€åˆ†ç±»æµè§ˆï¼›\n2ã€æœç´¢ï¼›\n3ã€æ ¹æ®äººæ°”å’Œä¸‹è½½é‡æµè§ˆï¼›\n4ã€åº”ç”¨ä¸‹è½½åˆ—è¡¨ï¼Œç›´æŽ¥ç‚¹å‡»ä¸‹è½½åˆ—è¡¨å³å¯è¿›è¡Œå®‰è£…ã€‚\n\n";
                text = text + "å¼€å‘å›¢é˜Ÿï¼š\n";
                text = text + "Qshenè´Ÿè´£ç¨‹åºä¸»é€»è¾‘åŠSymbian^3ç‰ˆæœ¬çš„å¼€å‘ï¼›\næ²›ç§¦è´Ÿè´£S60V5ç‰ˆçš„ç§»æ¤ï¼›\n";
                text = text + "ç‹‚é­”è´Ÿè´£å›¾æ ‡ä»¥åŠç•Œé¢è®¾è®¡ï¼›\næŽŒå”è´Ÿè´£æœåŠ¡å™¨ç«¯ç¨‹åºã€‚\n\n";
                text = text + "ä¹…æ™ºå›¢é˜Ÿä»‹ç»\nå›¢é˜Ÿå®šä½\nå›½å†…é¦–æ”¯ä¾æ‰˜Qtè·¨å¹³å°ä¼˜åŠ¿ï¼Œä¸“æ³¨å°ä¼—ç³»ç»Ÿçš„åº”ç”¨å¼€å‘ï¼ŒåŠåœ¨å›½å†…çš„å‘å±•ä¸ŽæŽ¨å¹¿ã€‚\n\n";
                text = text + "ç›®å‰æˆæžœ\nä¹…åº—ï¼Storeï¼‰å°ä¼—ç³»ç»Ÿåº”ç”¨å•†åº—ï¼Œå¡žç­ç‰ˆï¼Œç±³ç‹—ç‰ˆï¼Œæ——é±¼ç‰ˆå¼€å‘ä¸­ã€‚\n";
                text = text + "ä¹…é—»ï¼Newsï¼‰å°ä¼—ç³»ç»Ÿç›¸å…³æœ€æ–°èµ„è®¯ã€‚\n\n";
                text = text + "å‘å±•æ–¹å‘\nåšä¸­å›½æœ€ä¸“ä¸šçš„å°ä¼—ç³»ç»Ÿç»¼åˆç½‘ç»œå¹³å°ã€‚æä¾›èµ„æºä¸‹è½½ï¼Œæ–°é—»èµ„è®¯ï¼Œå¼€å‘æ•™ç¨‹ï¼Œæ‰‹æœºåŠé…ä»¶å•†åŸŽï¼Œåº”ç”¨å¼€å‘å¤–åŒ…ç­‰ä¸€ä½“åŒ–æœåŠ¡ã€‚\n\n";
                text = text + "å›¢é˜Ÿç»„æˆ\nç›®å‰å›¢é˜Ÿæˆå‘˜å…±æœ‰å…­äººï¼š\nQshenç›®å‰æ­£åœ¨è´Ÿè´£å¡žç­3é»‘èŽ“ä»¥åŠç±³ç‹—ç³»ç»Ÿä¸‹çš„ä¹…åº—å¼€å‘ä¸Žç»´æŠ¤ã€‚\n";
                text = text + "æ²›ç§¦ç›®å‰è´Ÿè´£ä¹…åº—çš„S60V5ç‰ˆçš„ç§»æ¤å’Œé€‚é…ã€‚\nBirdzhangç›®å‰è´Ÿè´£ä¹…åº—çš„æ——é±¼ç‰ˆå¼€å‘ã€‚\n";
                text = text + "æ¢¦æ¢¦ç›®å‰è´Ÿè´£ä¹…åº—çš„å›¾æ ‡è®¾è®¡ã€‚\né›¨åŽæ˜Ÿè¾°ç›®å‰è´Ÿè´£ä¹…é—»çš„å¼€å‘åŠUbuntuç‰ˆçš„ä¹…åº—å¼€å‘ã€‚\n";
                text = text + "æŽŒå”ç›®å‰è´Ÿè´£ä¹…åº—çš„æœåŠ¡å™¨ç«¯å¼€å‘ä¸Žwebå¹³å°çš„æ­å»ºã€‚\n\n";
                text = text + "æ¬¢è¿ŽåŠ å…¥æ¬¢è¿Žå¹¿å¤§ç§»åŠ¨å¹³å°å¼€å‘å’Œçˆ±å¥½è€…åŠ å…¥æˆ‘ä»¬ï¼Œæˆ‘ä»¬çƒ­çˆ±æŠ€æœ¯æ˜¯ä¸€ä¸ªå›¢ç»“æœ‰çˆ±ï¼Œå……æ»¡åŒ…å®¹å¹¶ç§¯æžå‘ä¸Šçš„å›¢ä½“ã€‚\n\n";
                text = text + "è”ç³»æ–¹å¼\nQQç¾¤ï¼š346578991\nEmailï¼šcontact@9smart.cn\nå®˜ç½‘ï¼šwww.9smart.cn";
                return text;
            }
        }
    }
}
