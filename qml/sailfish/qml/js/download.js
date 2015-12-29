.import QtQuick.LocalStorage 2.0 as SQL//数据库连接模块

function getDatabase() {
    return SQL.LocalStorage.openDatabaseSync("9store", "1.0", "9smart app shop", 10000);

}
// 程序打开时，初始化表
function initialize() {
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    // status:0未安装，1已安装，2已卸载
                    tx.executeSql('CREATE TABLE IF NOT EXISTS download(appid integer primary key,appname TEXT,downpath TEXT,icon TEXT,status integer);');
                });
}

var status = false;
function getStatus(appid){
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('select status from download where appid =?;',[appid]);
        if (rs.rows.length > 0) {
           var tmp = rs.rows.item(0).status;
            if(tmp == 1)status=true;
        } else {
           status = false;
        }
    });
    return status;
}

//获取所有的下载列表
function getDownload(){
    progress.visible = true;
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('select * from download ;');
        if (rs.rows.length > 0) {
            for(var i=0;i<rs.rows.length;i++){
            downloadModel.append({"appid":rs.rows.item(i).appid,
                                     "appname":rs.rows.item(i).appname,
                                     "icon":rs.rows.item(i).icon,
                                     "downpath":rs.rows.item(i).downpath,
                                     "status":rs.rows.item(i).status
                                 });

            }
        }
    });
    progress.visible = false;
}

//更新或插入

function updateDown(appid,appname,downPath,icon,status){
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO download(appid,appname,downpath,icon,status) VALUES (?,?,?,?,?);',[appid,appname,downPath,icon,status]);
        console.log(rs.rowsAffected)
        if (rs.rowsAffected > 0) {
            console.log("Saved!");
        } else {
            console.log("Failed!");
        }
    });
}
