.pragma library
Qt.include("des.js");
Qt.include("base64.js")
Qt.include("api.js")
var signalcenter;
var utility;
var userData;
var settings;
var qCurl;
function initialize(sc, ut, ud, st, qc){
    signalcenter = sc;
    utility = ut;
    userData = ud;
    qCurl = qc?qc:"";
    settings = st;
}

function substr(string,length){
    string.toString();
    string.substr(0,length);
    return string;
}

function isEmail(string){
    var re = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
    return re.test(string);
}

function humanedate(_dateline){
    var thatday=new Date(_dateline*1000);
    var now=parseInt(new Date().valueOf()/1000);
    var cha=now-_dateline;
    if(cha<180){
        return "刚刚";
    }else if(cha<3600){
        return Math.floor(cha/60)+" 分钟前";
    }else if(cha<86400){
        return Math.floor(cha/3600)+" 小时前";
    }else if(cha<172800){
        return "昨天 "+thatday.getHours()+':'+thatday.getMinutes();
    }else if(cha<259200){
        return "前天 "+thatday.getHours()+':'+thatday.getMinutes();
    }else if(cha<345600){
        return Math.floor(cha/86400)+" 天前";
    }else{
        return thatday.getFullYear()+'-'+(thatday.getMonth()+1)+'-'+thatday.getDate();
    }
}

function sendWebRequest(url, callback, method, postdata) {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
                switch(xmlhttp.readyState) {
                case xmlhttp.OPENED:signalcenter.loadStarted();break;
                case xmlhttp.HEADERS_RECEIVED:if (xmlhttp.status != 200)signalcenter.loadFailed(qsTr("erro,code:")+xmlhttp.status+"  "+xmlhttp.statusText);break;
                case xmlhttp.DONE:if (xmlhttp.status == 200) {
                        try {
                            callback(xmlhttp.responseText);
                            signalcenter.loadFinished();
                        } catch(e) {
                            signalcenter.loadFailed(qsTr("loading erro..."));
                        }
                    } else {
                        signalcenter.loadFailed("");
                    }
                    break;
                }
            }
    if(method==="GET") {
        xmlhttp.open("GET",url);
        xmlhttp.send();
    }
    if(method==="POST") {
        xmlhttp.open("POST",url);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.setRequestHeader("Content-Length", postdata.length);
        xmlhttp.send(postdata);
    }
}

var application;
function logIn(userName, passWord){
    var url = login();
    var postData = loginData(userName, passWord);
    sendWebRequest(url, loadLogInResult, "POST", postData);
}
function loadLogInResult(oritxt){
    var obj = JSON.parse(oritxt);
    if(obj.error === 0){
        application.user._id = obj._id;
        application.user.auth = obj.auth;
        var url = user(obj._id, obj.auth);
        sendWebRequest(url, loadUserInfo, "GET", "")
    }
    else{
        signalcenter.showMessage(obj.error);
    }
}
function loadUserInfo(oritxt){
    if(!oritxt) {
        return;
    }
    //console.log(oritxt);
    var obj = JSON.parse(oritxt);
    if(obj.error===0){
        application.user.nickName = obj.user.nickname;
        application.user.avatar = obj.user.avatar;
        application.user.avatar_hd = obj.user.avatar_hd;
        application.user.group = obj.user.group;
        application.user.userState = true;
        if(obj.user.auth)
            application.user.auth = obj.user.auth;
        savaUserData();

    }
}
function savaUserData(){
    if(application.user.userState){
        var obj = {"error":0, "user":{"_id": application.user._id, "auth": application.user.auth, "nickname": application.user.nickName, "avatar": application.user.avatar, "avatar_hd": application.user.avatar_hd, "group": application.user.group}};
        userData.setUserData("UserData", JSON.stringify(obj));
    }
    else{
        userData.clearUserData("UserData")
    }
}

function sendRegister(userName, nickname, password){
    var url = register();
    var postData = registerData(userName, nickname, password, password, "From Symbian client");
    sendWebRequest(url, loadRegisterResult, "POST", postData);
}
function loadRegisterResult(oritxt){
    var obj = JSON.parse(oritxt);
    if(obj.error === 0){
        application.user._id = obj._id;
        application.user.auth = obj.auth;
        var url = user(obj._id, obj.auth);
        sendWebRequest(url, loadUserInfo, "GET", "");
    }
    else{
        signalcenter.showMessage(obj.error);
    }
}

var noticeListPage;
function getNotices(auth, page, pageSize){
    var url = notices(auth, page, pageSize);
    sendWebRequest(url, loadNoticed, "GET", "");
}
function loadNoticed(oritxt){
    var obj = JSON.parse(oritxt);
    //console.log(oritxt);
    if(obj.error === 0){

    }
}

var mainPage;
var listPage;
function getfeatured(system){
    var url = getRecommendation(system);
    sendWebRequest(url,loadfeatured,"GET","");
}
function loadfeatured(oritxt){
    var obj = JSON.parse(oritxt);
    if(obj.error === 0){
        mainPage.featuredModel.clear();
        for(var i in obj.apps){
            mainPage.featuredModel.append(obj.apps[i]);
        }
    }
    else signalcenter.showMessage(obj.error);
}

function getcover(system){
    var url = getPoster(system);
    sendWebRequest(url,loadcover,"GET","");
}
function loadcover(oritxt){
    var obj = JSON.parse(oritxt);
    if(obj.error === 0){
        mainPage.coverModel.clear();
        for(var i in obj.apps){
            mainPage.coverModel.append(obj.apps[i]);
        }
    }
    else signalcenter.showMessage(obj.error);
}

function getcategory(type){
    var url = categorys(type);
    sendWebRequest(url,loadcategory,"GET","");
}
function loadcategory(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.error === 0){
        mainPage.categorymodel.clear();
        for(var i in obj.categorys){
            mainPage.categorymodel.append({"category":obj.categorys[i]});
        }
    }
    else signalcenter.showMessage(obj.error);
}

function getlist(system, category, developer, page, pagesize, sort){
    var url = apps(system, category, developer, page, pagesize, sort);
    sendWebRequest(url,loadlist,"GET","");
}
function loadlist(oritxt){
    var obj = JSON.parse(oritxt);
    if(obj.error === 0){
        if(obj.pager.page === 1){
            mainPage.listmodel.clear();
        }
        for(var i in obj.apps){
            if(!obj.apps[i].score_num){
                obj.apps[i].score_num = 0;
                obj.apps[i].scores = 0;
            }
            mainPage.listmodel.append(obj.apps[i]);
        }
        if(obj.pager.next_page !== 0){
            listPage = obj.pager.next_url;
        }
        else{
            listPage = "NULL";
        }
    }
    else signalcenter.showMessage(obj.error);
}

function getapplication(system, keyWord){
    var url = search(system, keyWord, "", "", "app");
    sendWebRequest(url,loadapplication,"GET","");
}
function loadapplication(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.error === 0){
        mainPage.applicationModel.clear();
        for(var i in obj.apps){
            mainPage.applicationModel.append(obj.apps[i]);
        }
    }
}

function getgame(system, keyWord){
    var url= search(system, keyWord, "", "", "game");
    sendWebRequest(url,loadgame,"GET","");
}
function loadgame(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.error === 0){
        mainPage.gameModel.clear();
        for(var i in obj.apps){
            mainPage.gameModel.append(obj.apps[i]);
        }
    }
}

function getSearch(system, keyWord, category, page){
    var url = search(system, keyWord, "", page, "", category);
    sendWebRequest(url, loadlist, "GET", "");
}

var infoPage;
var infoListPage;
function getinfo(id){
    var url = app(id);
    sendWebRequest(url,loadinfo,"GET","");
}
function loadinfo(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.error === 0){
        //console.log(oritxt);
        infoPage.type=obj.app.type;
        infoPage.category = obj.app.category;
        infoPage.version = obj.app.version;
        infoPage.summary = obj.app.summary;
        infoPage.comment_num = obj.app.comment_num;
        if(obj.app.size){
            var size = parseInt(obj.app.size);
            if(size < 1048576)
                size=((size/1024).toFixed(2)).toString()+"KB";
            else size=((size/1048576).toFixed(2)).toString()+"MB";
            infoPage.size = size;
        }
        else infoPage.size = qsTr("Unknown");
        for(var i=1;i<=5;i++){
            infoPage.screenShotsModel.append({"thumburl":"http://apps-images.9smart.cn/" + obj.app.uploader.uid + "/" + obj.app._id + "/s/" + i.toString() + "_thumb"
                                                 ,"url":"http://apps-images.9smart.cn/" + obj.app.uploader.uid + "/" + obj.app._id + "/s/" + i.toString()})
        }
    }
    else signalcenter.showMessage(obj.error);

}

var downloadName;
var downloadIcon;
function getDownloadUrl(id, auth, name, icon){
    var url = download(id, auth, "");
    downloadName = name;
    downloadIcon = icon;
    sendWebRequest(url, loadDownloadUrl, "GET", "");
}
function loadDownloadUrl(oritxt){
    var obj = JSON.parse(oritxt);
    if(obj.error === 0){
        application.downloadModel.append({"name": downloadName, "url": obj.down_url,
                                             "filename": settings.downloadPath + "/" +downloadName + ".sis", "icon": downloadIcon});
        qCurl.appenddl(obj.down_url, settings.downloadPath + "/" + downloadName + ".sis");
        signalCenter.showMessage(qsTr("Task added!"));
    }
    else signalcenter.showMessage(obj.error);
}

function getrelatedlist(system, category, page, pagesize){
    var url = apps(system, category, "", page, pagesize, "");
    sendWebRequest(url,loadrelatedlist,"GET","");
}
function loadrelatedlist(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.error === 0){
        if(obj.pager.page=== 1){
            infoPage.relatedAppsModel.clear();
        }
        for(var i in obj.apps){
            infoPage.relatedAppsModel.append(obj.apps[i]);
        }
        if(obj.pager.next_page !== 0){
            infoListPage = obj.pager.next_url;
        }
        else{
            infoListPage = "NULL";
        }
    }
}

function getSpecifiedAuthorList(system, developer, page, pageSize){
    var url = apps(system, "", developer, page, pageSize);
    sendWebRequest(url, loadSpecifiedAuthorList, "GET", "");
}
function loadSpecifiedAuthorList(oritxt){
    var obj = JSON.parse(oritxt);
    if(obj.error === 0){
        if(obj.pager.page === 1){
            infoPage.specifiedAuthorModel.clear();
        }
        for(var i in obj.apps){
            infoPage.specifiedAuthorModel.append(obj.apps[i]);
        }
        if(obj.pager.next_page !== 0){
            infoListPage = obj.pager.next_url;
        }
        else{
            infoListPage = "NULL";
        }
    }
    else signalcenter.showMessage(obj.error);
}



var commentPage;
var commentListPage;
function getComment(appid, page){
    var url = comments(appid, page);
    sendWebRequest(url,loadComment,"GET","");
}
function loadComment(oritxt){
    var obj=JSON.parse(oritxt);

    if(obj.error === 0){
        if(obj.pager.page === 1){
            commentPage.commentModel.clear();
        }
        for(var i in obj.comments){
            commentPage.commentModel.append(obj.comments[i]);
        }
        if(obj.pager.next_page !== 0){
            commentListPage = obj.pager.next_url;
        }
        else{
            commentListPage = "NULL";
        }
    }
    else signalcenter.showMessage(obj.error);
}
function sendComment(auth, id, type, content, score, model) {
    var url = sendcomments(auth, id, type);
    var postData = commentsData(content, score, model);
    sendWebRequest(url, sendCommentResult, "POST", postData);
}

function sendCommentResult(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.error === 0){
        signalcenter.showMessage(qsTr("send successful!"));
    }
    else signalcenter.showMessage(obj.error);
}

function sendReply(auth, cid, content, model){
    var url = reply(auth, cid);
    console.log(url);
    var postData = encodeURIComponent(replyData(content, model));
    console.log(postData);
    sendWebRequest(url, sendReplyResult, "POST", postData);
}

function sendReplyResult(oritxt){
    console.log(oritxt);
    var obj = JSON.parse(oritxt);

    if(obj.error === 0){
        signalcenter.showMessage(qsTr("send successful!"));
    }
    else signalcenter.showMessage(obj.error);
}

var version;
function getversion() {
    var url = "http://api.9smart.cn/app/";
    if (system == "belle")
        url = url + "105";
    else if (system == "s60v5")
        url = url + "119";
    sendWebRequest(url,loadversion,"GET","");
}
function loadversion(oritxt){
    var obj=JSON.parse(oritxt);
    version=obj.version;
    signalcenter.versionGeted();
}
function isnew(currentver,lastver){
    var j = 0,s1,s2;
    var num=new Array;
    for(var i in lastver)
    {
        if(lastver[i]==='.')
        {
            num[j]=i;
            j++;
        }
    }
    var temp=lastver.substring(0,++num[0]);
    s1=parseInt(temp)*100;
    temp=lastver.substring(num[0],++num[1]);
    s1=s1+parseInt(temp)*10;
    temp=lastver.substring(num[1]);
    s1=s1+parseInt(temp);
    j=0;
    i=0;
    for(i in currentver)
    {
        if(currentver[i]==='.')
        {
            num[j]=i;
            j++;
        }
    }
    temp=currentver.substring(0,++num[0]);
    s2=parseInt(temp)*100;
    temp=currentver.substring(num[0],++num[1]);
    s2=s2+parseInt(temp)*10;
    temp=currentver.substring(num[1]);
    s2=s2+parseInt(temp);
    if(s2>=s1)return true;
    else return false;
}
