
function loadAppClass(os,classtype) {
    var xhr = new XMLHttpRequest();
    var url="http://api.9smart.cn/apps/categorys?system="+os;
    if(classtype)url+="&type="+classtype;
    xhr.open("GET",url,true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                var jsonObject = eval('(' + xhr.responseText + ')');
                for( var i in jsonObject){
                      appClassModel.append({"name":jsonObject[i]});
                    }
                progress.visible = false
            }
        }
    }
    xhr.send();
}


