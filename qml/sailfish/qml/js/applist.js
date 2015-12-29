
//app列表
function loadAppList(pagenum,os,order,model,type,category,pagesize) {
    model.clear();
    var xhr = new XMLHttpRequest();
    //views或者downloads或者scores
    if(!pagesize)pagesize=20;
    var url="http://api.9smart.cn/apps?system="+os+"&page="+pagenum+"&pagesize="+pagesize;
    if(order)url=url+"&order="+order;
    if(type)url+="&type="+type;
    if(category)url+="&category="+category;
    xhr.open("GET",url,true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                var jsonObject = eval('(' + xhr.responseText + ')');

                loaded(jsonObject,pagenum,model)
            }
        }
    }

    xhr.send();
}



function loaded(jsonObject,pagenum,model)
{
    if(parseInt(jsonObject.pager.count)  === 0 ){

    }
    else{
        listsum = parseInt(jsonObject.pager.count);
        for ( var i in jsonObject.apps   )
        {
            model.append({
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
        }

    }
        progress.visible=false
}

/**
  *parse time
  */
function js_date_time(unixtime) {
    var timestr = new Date(parseInt(unixtime) * 1000);
    var datetime = timestr.toLocaleDateString();
    return datetime;
}

