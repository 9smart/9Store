#include <QThread>
#include <QDebug>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Qcurl.h"
//double QCurl::progress;

QCurl::QCurl(QObject *parent):QObject(parent){
    last=head=current=(struct QCurldl *)malloc(sizeof(struct QCurldl));
    curl_global_init(CURL_GLOBAL_ALL );
    setState(0);
}

QCurl::~QCurl(){
    if (!thread.isNull()){
        thread->terminate();
        thread->wait();
        dl->deleteLater();
    }
}

int QCurl::state() const {
    return m_state;
}

char *QCurl::currentUrl() {
    return m_currentUrl;
}

double QCurl::progress(){
    return m_progress;
}

void QCurl::appenddl(QString url,  QString file){
    QByteArray ba = url.toLatin1();
    char *urlc=ba.data();
    ba = file.toUtf8();
    char *filename=ba.data();
    if(m_state==0){
        current->url=new char[url.size()+1];
        strcpy(current->url,urlc);
        current->fp=fopen(filename,"w");
        current->next=NULL;
        connect(this,SIGNAL(dlSetted()),this,SLOT(startNextDl()));
        emit dlSetted();
        return;
    }
    if(m_state==1){
        last->next=(struct QCurldl*)malloc(sizeof(struct QCurldl));
        last=last->next;
        last->next=NULL;
        last->url=new char[url.size()+1];
        strcpy(last->url,urlc);
        last->fp=fopen(filename,"w");
    }
}

bool QCurl::isCurrentUrl(QString url){
    QByteArray ba = url.toLatin1();
    char *urlc=ba.data();
    if(strcmp(urlc,m_currentUrl)==0){
        return true;
    }
    return false;
}

bool QCurl::isFileExist(QString file){
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

size_t QCurl::file_callback(void *ptr, size_t size, size_t nmemb, void *userp){
    FILE *fp = (FILE *)userp;
    ptr=(char *)ptr;
    size_t return_size = fwrite(ptr, size, nmemb, fp);
    return return_size;
}

int QCurl::progress_callback(void *clientp, double dltotal, double dlnow, double ultotal, double ulnow){
    //(QCurl *)clientp;
    if(dltotal==0){
        ((QCurl *)clientp)->setProgress(0);
        return 0;
    }
    ((QCurl *)clientp)->setProgress(dlnow/dltotal);
    return 0;
}

void QCurl::startNextDl(){
    if(current==last&&m_state==3){
        fclose(current->fp);
        setCurrentUrl("/0");
        setState(0);
        return;
    }
    if(m_state==3){
        fclose(current->fp);
        current=current->next;
    }
    curl=curl_easy_init();
    curl_easy_setopt(curl,CURLOPT_NOPROGRESS,0);
    curl_easy_setopt(curl,CURLOPT_FOLLOWLOCATION,1);
    curl_easy_setopt(curl,CURLOPT_VERBOSE,1);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, QCurl::file_callback);
    curl_easy_setopt(curl,CURLOPT_PROGRESSFUNCTION,QCurl::progress_callback);
    curl_easy_setopt(curl, CURLOPT_URL,current->url);
    setCurrentUrl(current->url);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA,current->fp);
    curl_easy_setopt(curl, CURLOPT_PROGRESSDATA,this);
    if(thread.isNull()){
        thread = new QThread(this);
        dl = new QCurlPerformer;
        dl->moveToThread(thread);
        connect(this,SIGNAL(startDl(CURL*)),dl,SLOT(start(CURL*)));
        connect(dl,SIGNAL(stateChanged(int)),this,SLOT(setState(int)));
        connect(dl,SIGNAL(finished()),this,SLOT(startNextDl()));
        thread->start();
    }
    setState(1);
    emit startDl(curl);
}

void QCurl::setState(int state){
    if(m_state!=state){
        m_state=state;
        emit stateChanged();
    }
}

void QCurl::setCurrentUrl(char *url){
    if(strcmp(m_currentUrl,url)!=0){
        strcpy(m_currentUrl,url);
        emit currentUrlChanged();
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
    qDebug("start");
    res=curl_easy_perform(curl);
    if(res==CURLE_OK){
        curl_easy_cleanup(curl);
        qDebug("finished");
        emit stateChanged(3);
        emit finished();
    }
}
