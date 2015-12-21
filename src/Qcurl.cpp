#include <QThread>
#include <QDebug>
#include <QDeclarativeItem>
#include <QDeclarativeView>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "Qcurl.h"
#include "Settings.h"
#include "FileOperate.h"
//double QCurl::progress;

QCurl::QCurl(QObject *parent):QObject(parent)
{
    curl_global_init(CURL_GLOBAL_ALL );
}

QCurl::QCurl(QDeclarativeView *viewer, Settings *settings, FileOperate *fileOperate)
{
    curl_global_init(CURL_GLOBAL_ALL );
    m_viewer = viewer;
    m_settings = settings;
    m_fileOperate = fileOperate;
}

QCurl::~QCurl()
{
    if (!thread.isNull()){
        thread->terminate();
        thread->wait();
        performer->deleteLater();
    }
    curl_global_cleanup();
}

QString QCurl::currentUrl() const
{
    return m_currentUrl;
}

QString QCurl::currentFile() const
{
    return m_currentFile;
}

double QCurl::progress() const
{
    return m_progress;
}

void QCurl::appenddl(QString url,  QString file)
{
    qDebug()<<"curl append: "<< url << " " << file;
    QByteArray ba = url.toLatin1();
    char *urlc=ba.data();
    ba = file.toUtf8();
    char *filename=ba.data();
    QCurlTask task;
    task.url = new char[url.size()+1];
    strcpy(task.url, urlc);
    task.fp = fopen(filename, "w");
    if(thread.isNull()){
        thread = new QThread(this);
        performer = new QCurlPerformer;
        performer->moveToThread(thread);
        connect(this, SIGNAL(startDownload(CURL*)), performer, SLOT(start(CURL *)));
        connect(performer, SIGNAL(finished(int)), this, SLOT(downloadFinished(int)));
        thread->start(QThread::IdlePriority);
    }
    downloadQueue.enqueue(task);
    if(currentUrl() == ""){
        task = downloadQueue.dequeue();
        curl = curl_easy_init();
        curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0);
        curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1);
        curl_easy_setopt(curl, CURLOPT_VERBOSE, 1);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, QCurl::file_callback);
        curl_easy_setopt(curl, CURLOPT_PROGRESSFUNCTION, QCurl::progress_callback);
        curl_easy_setopt(curl, CURLOPT_URL, task.url);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, task.fp);
        curl_easy_setopt(curl, CURLOPT_PROGRESSDATA, this);

        setCurrentUrl(QString(task.url));
        setCurrentFile(file);

        emit startDownload(curl);
    }
}

void QCurl::downloadFinished(int result)
{
    qDebug() << "curl finished" << result;
    QDeclarativeItem *rootItem = qobject_cast<QDeclarativeItem*>(m_viewer->rootObject());
    QObject *signalCenter = rootItem->findChild<QObject*>("signalCenter");
    if(result == CURLE_OK){
        QMetaObject::invokeMethod(signalCenter, "showMessage", Qt::QueuedConnection, Q_ARG(QVariant, QVariant(tr(" download successfully"))));
        if(m_settings->autoInstall()){
            if(m_settings->silenceInstall()){
                m_fileOperate->openFile(1, currentFile());
            }
            else {
                m_fileOperate->openFile(2, currentFile());
            }
        }
    }
    else{
        QMetaObject::invokeMethod(signalCenter, "showMessage", Qt::QueuedConnection, Q_ARG(QVariant, QVariant(tr(" dowanload failed"))));
    }
    curl_easy_cleanup(curl);
    setCurrentUrl("");
    setCurrentFile("");
    if(!downloadQueue.isEmpty()){
        QCurlTask task = downloadQueue.dequeue();

        curl = curl_easy_init();
        curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0);
        curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1);
        curl_easy_setopt(curl, CURLOPT_VERBOSE, 1);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, QCurl::file_callback);
        curl_easy_setopt(curl, CURLOPT_PROGRESSFUNCTION, QCurl::progress_callback);
        curl_easy_setopt(curl, CURLOPT_URL,task.url);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, task.fp);
        curl_easy_setopt(curl, CURLOPT_PROGRESSDATA, this);

        setCurrentUrl(QString(task.url));
        setCurrentFile(QString((char *)task.fp->_ub._base));
        qDebug() << QString((char *)task.fp->_ub._base);
        emit startDownload(curl);
    }
}

bool QCurl::isCurrentUrl(QString url)
{
    if(url == m_currentUrl){
        return true;
    }
    return false;
}

bool QCurl::isFileExist(QString file)
{
    QByteArray ba = file.toUtf8();
    char *filename=ba.data();
    FILE *fp;
    fp=fopen(filename,"r");
    if(fp==NULL){
        return false;
    }
    fseek(fp,0,SEEK_END);
    if(ftell(fp)==0){
        return false;
    }
    fclose(fp);
    return true;
}

bool QCurl::isTaskExist(QString url)
{
    for(int i=0;i<downloadQueue.length();i++){
        if(QString(downloadQueue[i].url) == url){
            return true;
        }
    }
    return false;
}

size_t QCurl::file_callback(void *ptr, size_t size, size_t nmemb, void *userp)
{
    FILE *fp = (FILE *)userp;
    ptr=(char *)ptr;
    size_t return_size = fwrite(ptr, size, nmemb, fp);
    return return_size;
}

int QCurl::progress_callback(void *clientp, double dltotal, double dlnow, double ultotal, double ulnow)
{
    if(dltotal==0){
        ((QCurl *)clientp)->setProgress(0);
        return 0;
    }
    ((QCurl *)clientp)->setProgress(dlnow/dltotal);
    return 0;
}

void QCurl::setCurrentUrl(QString url)
{
    if(url != m_currentUrl){
        m_currentUrl = url;
        emit currentUrlChanged();
    }
}

void QCurl::setCurrentFile(QString file)
{
    if(file != m_currentFile){
        m_currentFile = file;
        emit currentFileChanged();
    }
}

void QCurl::setProgress(double progress){
    if(m_progress!=progress){
        m_progress=progress;
        emit progressChanged();
    }
}

QCurlPerformer::QCurlPerformer(QObject *parent):QObject(parent){
}

QCurlPerformer::~QCurlPerformer(){
}

void QCurlPerformer::start(CURL *curl){
    qDebug("curl start");
    emit finished(curl_easy_perform(curl));
}
