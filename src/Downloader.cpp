#include <QThread>
#include <QDebug>
#include <QDeclarativeItem>
#include <QDeclarativeView>

#include "Downloader.h"
#include "Settings.h"
#include "FileOperate.h"

Downloader::Downloader(QObject *parent):QObject(parent)
{
    m_progress = 0;
}

Downloader::Downloader(QDeclarativeView *viewer, Settings *settings, FileOperate *fileOperate)
{
    m_progress = 0;
    m_viewer = viewer;
    m_settings = settings;
    m_fileOperate = fileOperate;
}

Downloader::~Downloader()
{
    if (!thread.isNull()){
        thread->terminate();
        thread->wait();
        performer->deleteLater();
    }
}

QString Downloader::currentUrl() const
{
    return m_currentUrl;
}

QString Downloader::currentFile() const
{
    return m_currentFile;
}

qreal Downloader::progress() const
{
    return m_progress;
}

void Downloader::appendDl(QByteArray url,  QString fileName)
{
    qDebug()<<"download append: "<< url << " " << fileName;

    DownloadTask task;
    task.url = url;
    task.fileName = fileName;
    task.file = m_settings->getDownloadPath() + "/" + fileName;
    if(thread.isNull()){
        thread = new QThread(this);
        performer = new DownloadPerformer(this);
        performer->moveToThread(thread);
        connect(this, SIGNAL(startDownload(QUrl, QString)), performer, SLOT(start(QUrl, QString)));
        connect(performer, SIGNAL(finished(int)), this, SLOT(downloadFinished(int)));
        thread->start(QThread::IdlePriority);
    }
    downloadQueue.enqueue(task);
    if(currentUrl() == ""){
        task = downloadQueue.dequeue();

        setCurrentUrl(url);
        setCurrentFile(task.file);

        emit startDownload(QUrl(url), task.file);
    }
}

void Downloader::downloadFinished(int result)
{
    qDebug() << "download finished" << result;

    QDeclarativeItem *rootItem = qobject_cast<QDeclarativeItem*>(m_viewer->rootObject());
    QObject *signalCenter = rootItem->findChild<QDeclarativeItem*>("signalCenter");

    if(result == 0){
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

    setCurrentUrl("");
    setCurrentFile("");
    if(!downloadQueue.isEmpty()){
        DownloadTask task = downloadQueue.dequeue();

        setCurrentUrl(task.url.toString());
        setCurrentFile(task.file);

        emit startDownload(task.url, task.file);
    }
}

bool Downloader::isCurrentUrl(QString url)
{
    if(url == m_currentUrl){
        return true;
    }
    return false;
}

bool Downloader::isFileExist(QString file)
{
    QFile fp(file);
    return fp.exists();
}

bool Downloader::isTaskExist(QString url)
{
    for(int i=0;i<downloadQueue.length();i++){
        if(downloadQueue[i].url.toString() == url){
            return true;
        }
    }
    return false;
}


void Downloader::setCurrentUrl(QString url)
{
    if(url != m_currentUrl){
        m_currentUrl = url;
        emit currentUrlChanged();
    }
}

void Downloader::setCurrentFile(QString file)
{
    if(file != m_currentFile){
        m_currentFile = file;
        emit currentFileChanged();
    }
}

void Downloader::setProgress(qint64 bytesReceived, qint64 bytesTotal){
    if(bytesTotal == 0){
        m_progress = 0;
    }
    else{
        m_progress = ((qreal)bytesReceived) / ((qreal)bytesReceived);
    }
    emit progressChanged();
}

DownloadPerformer::DownloadPerformer(QObject *parent):QObject(parent){
}

DownloadPerformer::DownloadPerformer(Downloader *downloader)
{
    m_downloader = downloader;
}

DownloadPerformer::~DownloadPerformer(){
}

void DownloadPerformer::start(QUrl url, QString file){
    qDebug("download start");

    if (manager.isNull())
        manager = new QNetworkAccessManager(this);

    if (output.isNull())
        output = new QFile(this);
    output->setFileName(file);
    if (!output->open(QIODevice::WriteOnly)){
        emit finished(-1);
    } else {
        //qDebug() << url.toString();
        QNetworkRequest req;

        req.setUrl(url);
        currentDownload = manager->get(req);
        qDebug() << req.url().toString();
        connect(currentDownload.data(), SIGNAL(downloadProgress(qint64,qint64)), m_downloader.data(), SLOT(setProgress(qint64,qint64)));
        connect(currentDownload.data(), SIGNAL(finished()), SLOT(downloadFinished()));
        connect(currentDownload.data(), SIGNAL(readyRead()), SLOT(downloadReadyRead()));

    }
}

void DownloadPerformer::downloadReadyRead()
{
    output->write(currentDownload->readAll());
}

void DownloadPerformer::downloadFinished()
{
    currentDownload->deleteLater();
    output->close();
    if (currentDownload->error()){
        output->remove();
    }
    //emit error(currentDownload->error());
    emit finished(currentDownload->error());
}
