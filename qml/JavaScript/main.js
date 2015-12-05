.pragma library
Qt.include("des.js");
Qt.include("base64.js")
Qt.include("api.js")
var signalcenter;
var system = "belle";
function setsignalcenter(mycenter){
    signalcenter=mycenter;
}
function substr(string,length){
    string.toString();
    string.substr(0,length);
    return string;
}
function cutfile(file){
    file=file.toString();
    return file.substr(7);
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
                case xmlhttp.HEADERS_RECEIVED:if (xmlhttp.status != 200)signalcenter.loadFailed(qsTr("连接错误,代码:")+xmlhttp.status+"  "+xmlhttp.statusText);break;
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

var app;
function logIn(userName, passWord){
    var url = login();
    var postData = loginData(userName, passWord);
    sendWebRequest(url, loadLogInResult, "POST", postData);
}
function loadLogInResult(oritxt){
    var obj = JSON.parse(oritxt);
    if(obj.err === 0){
        app.user._id = obj._id;
        app.user.auth = obj.auth;
        var url = user(obj._id, obj.auth);
        sendWebRequest(url, loadUserInfo, "GET", "")
    }
    else{
        signalcenter.showMessage(obj.err);
    }
}
function loadUserInfo(oritxt){
    var obj = JSON.parse(oritxt);
    //console.log(oritxt);
    if(obj._id !== ""){
        app.user.nickName = obj.nickname;
        app.user.avatar = obj.avatar;
        app.user.avatar_hd = obj.avatar_hd;
        app.user.noticeNumber = obj.notice_num;
        app.savaUserData();
        app.user.userState = true;

    }
}

var mainPage;
var page;
function getfeatured(os){
    var url="http://api.9smart.cn/apps?system="+os+"&recommended=1";
    sendWebRequest(url,loadfeatured,"GET","");
}
function loadfeatured(oritxt){
    var obj=JSON.parse(oritxt);
    featuredmodel.clear();
    for(var i in obj.apps){
        featuredmodel.append(obj.apps[i]);
    }
}

function getcover(){
    var url="http://api.9smart.cn/covers?type=app";
    sendWebRequest(url,loadcover,"GET","");
}
function loadcover(oritxt){
    var obj=JSON.parse(oritxt);
    covermodel.clear();
    for(var i in obj.covers){
        covermodel.append(obj.covers[i]);
    }
}

function getcategory(type){
    var url = categorys(type);
    sendWebRequest(url,loadcategory,"GET","");
}
function loadcategory(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.err === 0){
        mainPage.categorymodel.clear();
        for(var i in obj.categorys){
            mainPage.categorymodel.append({"category":obj.categorys[i]});
        }
    }
    else signalcenter.showMessage(obj.err);
}

function getlist(system, category, developer, page, pagesize, sort){
    var url = apps(system, category, developer, page, pagesize, sort);
    sendWebRequest(url,loadlist,"GET","");
}
function loadlist(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.err === 0){
        if(obj.pager.page === 1){
            mainPage.listmodel.clear();
        }
        for(var i in obj.apps){
            mainPage.listmodel.append(obj.apps[i]);
        }
        if(obj.pager.next_page !== 0){
            page = obj.pager.next_url;
        }
        else{
            page = "NULL";
        }
    }
    else signalcenter.showMessage(obj.err);
}

function getapplication(os,appname,fields){
    //var url="http://api.9smart.cn/apps?type=app&system="+os+"&appname="+appname+"&fields="+fields;
    sendWebRequest(url,loadapplication,"GET","");
}
function loadapplication(oritxt){
    var obj=JSON.parse(oritxt);
    applicationmodel.clear();
    for(var i in obj.apps){
        applicationmodel.append(obj.apps[i]);
    }
}

function getgame(os,appname,fields){
    var url="http://api.9smart.cn/apps?type=game&system="+os+"&appname="+appname+"&fields="+fields;
    sendWebRequest(url,loadgame,"GET","");
}
function loadgame(oritxt){
    var obj=JSON.parse(oritxt);
    gamemodel.clear();
    for(var i in obj.apps){
        gamemodel.append(obj.apps[i]);
    }
}

var infoPage;
function getinfo(id){
    var url = app(id);
    sendWebRequest(url,loadinfo,"GET","");
}
function loadinfo(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.err === 0){
        //type=obj.type;
        infoPage.category = obj.app.category;
        infoPage.version = obj.app.version;
        infoPage.size = obj.app.size;
        infoPage.summary = obj.app.summary;
        infoPage.comment_num = obj.app.comment_num;
        var size = parseInt(obj.app.size);
        if(size < 1048576)
            size=((size/1024).toFixed(2)).toString()+"KB";
        else size=((size/1048576).toFixed(2)).toString()+"MB";
        infoPage.size = size;
        for(var i=1;i<=5;i++){
            infoPage.screenShotsModel.append({"thumburl":"http://apps-images.9smart.cn/" + obj.app.uploader.uid + "/" + obj.app._id + "/s/" + i.toString() + "_thumb"
                                                 ,"url":"http://apps-images.9smart.cn/" + obj.app.uploader.uid + "/" + obj.app._id + "/s/" + i.toString()})
        }
    }
    else signalcenter.showMessage(obj.err);
}

function getrelatedlist(system, category, page, pagesize){
    var url = apps(system, category, "", page, pagesize, "");
    sendWebRequest(url,loadrelatedlist,"GET","");
}
function loadrelatedlist(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.err === 0){
        if(obj.pager.page=== 1){
            infoPage.relatedAppsModel.clear();
        }
        for(var i in obj.apps){
            infoPage.relatedAppsModel.append(obj.apps[i]);
        }
        if(obj.pager.next_page !== 0){
            page = obj.pager.next_url;
        }
        else{
            page = "NULL";
        }
    }
}

function getSpecifiedAuthorList(system, developer, page, pageSize){
    var url = apps(system, "", developer, page, pageSize);
    sendWebRequest(url, loadSpecifiedAuthorList, "GET", "");
}
function loadSpecifiedAuthorList(oritxt){
    var obj = JSON.parse(oritxt);
    if(obj.err === 0){
        if(obj.pager.page === 1){
            infoPage.specifiedAuthorModel.clear();
        }
        for(var i in obj.apps){
            infoPage.specifiedAuthorModel.append(obj.apps[i]);
        }
        if(obj.pager.next_page !== 0){
            page = obj.pager.next_url;
        }
        else{
            page = "NULL";
        }
    }
    else signalcenter.showMessage(obj.err);
}



var commentmodel;
function getComment(appid,page){
    var url="http://api.9smart.cn/comments/"+appid+"?page="+page;
    sendWebRequest(url,loadComment,"GET","");
}
function loadComment(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.pager.page==="1"){
        commentmodel.clear();
    }
    for(var i in obj.comments){
        commentmodel.append(obj.comments[i]);
    }
}
function sendComment(appid,auth,message,score) {
    var url="http://api.9smart.cn/comments/"+appid;
    console.log(auth);
    console.log(encodeURIComponent(auth));
    sendWebRequest(url,sendCommentState,"POST","auth="+encodeURIComponent(auth)+"&message="+message+"&score="+score+"&clientid=1");
}
function sendCommentState(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.success) {
        signalcenter.commentSendSuccessful();
    }
    else signalcenter.commentSendFailed(obj.error);
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
