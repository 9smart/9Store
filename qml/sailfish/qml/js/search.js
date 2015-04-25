
//搜索
function searchApp(os,name) {
    progress.visible=true;
    appListModel.clear();
    var xhr = new XMLHttpRequest();
    var url="http://api.9smart.cn/apps?system="+os+"&appname="+name;
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
    var count=0;
    if(parseInt(jsonObject.pager.count)  == 0 ){
    }
    else{
        listsum = parseInt(jsonObject.pager.count);
        for ( var i in jsonObject.apps   )
        {
            appListModel.append({
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
                                    "scores":jsonObject.apps[i].scores,
                                    "ratingnum":jsonObject.apps[i].ratingnum
                                });

            count +=1;
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

