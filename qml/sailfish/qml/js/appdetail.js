
//应用详情
function loadappdetail(id) {
    //appDetailModel.clear();
    screenShotModel.clear();
    moreAppsModel.clear();
    var xhr = new XMLHttpRequest();
    var url="http://api.9smart.cn/app/"+id
    console.log("URL:"+url);
    xhr.open("GET",url,true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                var jsonObject = eval('(' + xhr.responseText + ')');

                loaded(jsonObject)
            }
        }
    }

    xhr.send();
}



function loaded(jsonObject)
{

    showappdetail.appid=jsonObject.appid;
    showappdetail.downurl=jsonObject.url;
    header.title=jsonObject.appname;
    showappdetail.appname=jsonObject.appname;
    showappdetail.author=jsonObject.author;
    showappdetail.system =jsonObject.system;
    showappdetail.type =jsonObject.type;
    showappdetail.category =jsonObject.category;
    showappdetail.views =jsonObject.views;
    showappdetail.downloads =jsonObject.downloads;
    showappdetail.dateline =humanedate(jsonObject.dateline);
    showappdetail.icon =jsonObject.icon;
    showappdetail.version =jsonObject.version;
    showappdetail.scores = parseInt(jsonObject.scores);
    showappdetail.size =jsonObject.size;
    showappdetail.summary =jsonObject.summary;
    showappdetail.url =jsonObject.url;
    showappdetail.compatible =jsonObject.compatible;
    showappdetail.downloadname =jsonObject.downloadname;
    showappdetail.ratingnum = parseInt(jsonObject.ratingnum);
    showappdetail.compatible = jsonObject.compatible;
    for ( var i in jsonObject.screenshots   ){
        screenShotModel.append({
                                   "url":jsonObject.screenshots[i].url,
                                   "thumburl":jsonObject.screenshots[i].thumburl
                               });
    }



    progress.visible=false

}

function searchbyauthor(os,author,id) {
    var xhr = new XMLHttpRequest();
    var url="http://api.9smart.cn/apps?system="+os+"&author="+author
    xhr.open("GET",url,true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                var jsonObject = eval('(' + xhr.responseText + ')');
                loadAuthorApps(jsonObject,id)
            }
        }
    }

    xhr.send();
}

function loadAuthorApps(jsonObject,id){
    if(parseInt(jsonObject.pager.count)  == 0 ){
        console.log("none");
    }
    else{
        for ( var i in jsonObject.apps   )
        {

            if(id != jsonObject.apps[i].appid){
                moreAppsModel.append({
                                         "appid":jsonObject.apps[i].appid,
                                         "appname":jsonObject.apps[i].appname,
                                         "icon":jsonObject.apps[i].icon,
                                         "views":jsonObject.apps[i].views,
                                         "downloads":jsonObject.apps[i].downloads
                                     });
            }
        }

    }
}

function searchRelated(os,appid,category,pagenum) {
    var xhr = new XMLHttpRequest();
    var url="http://api.9smart.cn/apps?system="+os+"&appid="+appid+"&category="+category+"&page="+pagenum+"&pagesize=20";
    xhr.open("GET",url,true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                var jsonObject = eval('(' + xhr.responseText + ')');
                loadRelated(jsonObject)
            }
        }
    }

    xhr.send();
}

function loadRelated(jsonObject){
    //console.log("Related Sum:"+jsonObject.pager.count);
    if(parseInt(jsonObject.pager.count)  == 0 ){
        console.log("none related");
    }
    else{
        related_sum=jsonObject.pager.count;
        for ( var i in jsonObject.apps   )
        {
            relatedModel.append({
                                    "appid":jsonObject.apps[i].appid,
                                    "appname":jsonObject.apps[i].appname,
                                    "icon":jsonObject.apps[i].icon,
                                    "dateline":js_date_time(jsonObject.apps[i].dateline),
                                    "summary":jsonObject.apps[i].summary,
                                    "version":jsonObject.apps[i].version,
                                    "author":jsonObject.apps[i].author,
                                    "views":jsonObject.apps[i].views,
                                    "downloads":jsonObject.apps[i].downloads,
                                    "category":jsonObject.apps[i].category,
                                    "scores":parseInt(jsonObject.apps[i].scores),
                                    "ratingnum":parseInt(jsonObject.apps[i].ratingnum)
                                });
            //console.log("appname:"+jsonObject.apps[i].appname);

        }

    }
}


function js_date_time(unixtime) {
    var timestr = new Date(parseInt(unixtime) * 1000);
    var datetime = timestr.toLocaleDateString();
    return datetime;
}
function humanedate(_dateline){
    var thatday=new Date(_dateline*1000);
    var now=parseInt(new Date().valueOf()/1000);
    var cha=now-_dateline;
    if(cha<180){
        return '刚刚';
    }else if(cha<3600){
        return Math.floor(cha/60)+'分钟前';
    }else if(cha<86400){
        return Math.floor(cha/3600)+'小时前';
    }else if(cha<172800){
        return '昨天 '+thatday.getHours()+':'+thatday.getMinutes();
    }else if(cha<259200){
        return '前天 '+thatday.getHours()+':'+thatday.getMinutes();
    }else if(cha<345600){
        return Math.floor(cha/86400)+'天前';
    }else{
        return thatday.getFullYear()+'-'+(thatday.getMonth()+1)+'-'+thatday.getDate();
    }
}

function loadComments(appid,pagenum){
    commentsModel.clear();
    var xhr = new XMLHttpRequest();
    var url="http://api.9smart.cn/comments/"+appid+"?page="+pagenum;
    xhr.open("GET",url,true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                var jsonObject = eval('(' + xhr.responseText + ')');
                if(jsonObject.comments  !== 'false'){
                    for(var i in jsonObject.comments){
                        commentsModel.append({
                                                 "uid":jsonObject.comments[i].uid,
                                                 "nickname":jsonObject.comments[i].nickname,
                                                 "avatar":jsonObject.comments[i].avatar,
                                                 "message":jsonObject.comments[i].message,
                                                 "scorenum":parseInt(jsonObject.comments[i].score),
                                                 "model":jsonObject.comments[i].model,
                                                 "user_dateline":humanedate(jsonObject.comments[i].dateline)
                                             }
                                             );
                    }
                }
            }
        }
    }

    xhr.send();
}
