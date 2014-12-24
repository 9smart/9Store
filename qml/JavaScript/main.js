.pragma library
Qt.include("des.js");
Qt.include("base64.js")
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
var featuredmodel;
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

var categorymodel;
var listmodel;
function getcategory(type){
    var url="http://api.9smart.cn/apps/categorys?type="+type;
    sendWebRequest(url,loadcategory,"GET","");
}
function loadcategory(oritxt){
    var obj=JSON.parse(oritxt);
    categorymodel.clear();
    for(var i in obj){
        categorymodel.append({"cate":obj[i]});
        //console.log(categorymodel.get(i).cate);
    }
}
var covermodel;
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

function getlist(os,page,pagesize,category,type,upload_id,order,appname,fields){
    var url="http://api.9smart.cn/apps?system="+os+"&page="+page+"&pagesize="+pagesize+"&category="+category+"&type="+type+"&author="+upload_id+"&order="+order+"&appname="+appname+"&fields="+fields;
    sendWebRequest(url,loadlist,"GET","");
}
function loadlist(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.pager.page==="1"){
        listmodel.clear();
    }
    for(var i in obj.apps){
        listmodel.append(obj.apps[i]);
    }
}
var category;
var summary;
var size;
var screenshotmodel;
function getinfo(id){
    var url ="http://api.9smart.cn/app/"+id;
    sendWebRequest(url,loadinfo,"GET","");
}
function loadinfo(oritxt){
    var obj=JSON.parse(oritxt);
    screenshotmodel.clear();
    for(var i in obj.screenshots){
        screenshotmodel.append(obj.screenshots[i])
    }
    category=obj.category;
    summary=obj.summary;
    size=obj.size;
    size=parseInt(size);
    if(size<1048576)
        size=((size/1024).toFixed(2)).toString()+"KB";
    else size=((size/1048576).toFixed(2)).toString()+"MB";
    signalcenter.dlInfoSetted();
}


function getuid(oritxt){
    var obj=JSON.parse(oritxt);
    return obj.uid;
}
function getaccesstoken(oritxt){
    var obj=JSON.parse(oritxt);
    return obj.access_token;
}

var isexist;
function getfilehash(filehash){
    var url="http://api.9smart.cn/apps/exists?myappid=2";
    var postdata="file_md5="+filehash;
    sendWebRequest(url,loadfilehash,"POST",postdata);
}
function loadfilehash(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.error===0){
        if(obj.message==="true")
            isexist=1;
        else isexist=0;
    }
    signalcenter.fileHashGeted();
}

var relatedlistmodel;
function getrelatedlist(system,page,pagesize,id,category){
    var url ="http://api.9smart.cn/apps?system="+system+"&page="+page+"&pagesize="+pagesize+"&category="+category+"&appid="+id;
    sendWebRequest(url,loadrelatedlist,"GET","");
}
function loadrelatedlist(oritxt){

    var obj=JSON.parse(oritxt);
    if(obj.pager.page==="1"){
        relatedlistmodel.clear();
    }
    for(var i in obj.apps){
        relatedlistmodel.append(obj.apps[i]);
    }
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
