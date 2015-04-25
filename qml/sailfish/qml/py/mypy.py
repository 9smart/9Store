import sys,os
import subprocess
import urllib
import pyotherside

"""
//定义发送消息规则
//0,开始下载
//1,下载完成，开始安装
//2,安装完成
//3,升级成功
//4,卸载完成

"""
def install(rpmpath):
    p = subprocess.Popen("pkcon -y install-local "+rpmpath,shell=True,stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    #0则安装成功
    retval = p.wait()
    print("installed,",rpmpath)
    pyotherside.send("2")
    return p.returncode

def unistall(rpmpath):
    p = subprocess.Popen("pkcon remove "+rpmpath,shell=True,stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    #0则安装成功
    retval = p.wait()
    print("removed,",rpmpath)
    pyotherside.send("4")
    return p.returncode


def getAppCName():
    apps=getInstalledApps()
    for i in apps:
        realpath="/usr/share/applications/"+i

    return "OK"

"""
    获取安装的应用
"""
def getInstalledApps():
    app_list=[]
    app_str = subprocess.Popen('ls /usr/share/applications', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    for line in app_str.stdout.readlines():
        app_list.append(line.decode('utf-8').strip('\n'))
    retval = app_str.wait()
    return app_list

"""
    检测是否安装
"""
def checkInstalled(appname):
    print("Python---Appname:",appname)
    p = subprocess.Popen('rpm -q '+appname, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    app_info=p.stdout.readline().decode('utf-8').strip('\n')
    retval = p.wait()
    if app_info.startswith("package"):
        return "false"
    else:
        app_info=app_info.strip(b'.armv7hl').strip(appname+"-")
        return app_info

"""
    下载文件

"""
def downloadRpm(downname,downurl):
    print("starting download")
    pyotherside.send("0")
#    r=urllib.request.get(downurl)
#    with open(downname,"wb") as code:
#        code.write(r.content)
    p = subprocess.Popen("curl -c -o "+downname+" "+downurl,shell=True)
    #0则安装成功
    retval = p.wait()
    pyotherside.send("1")
    install(downname)
