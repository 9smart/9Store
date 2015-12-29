#ifndef QCURL_H
#define QCURL_H
#include <QObject>
#include <QtNetwork>
#include <QPointer>
#include <QQueue>
#include <QUrl>
#include <QFile>

class DownloadPerformer;
class QDeclarativeView;
class Settings;
class FileOperate;

struct DownloadTask{
    QUrl url;
    QString file;
    QString fileName;
};
class Downloader : public QObject{

    Q_OBJECT

    Q_PROPERTY(QString currentUrl READ currentUrl NOTIFY currentUrlChanged)
    Q_PROPERTY(QString currentFile READ currentFile NOTIFY currentFileChanged)
    Q_PROPERTY(qreal progress READ progress NOTIFY progressChanged)

public:
    explicit Downloader(QObject *parent = 0);
    explicit Downloader(QDeclarativeView *viewer, Settings *settings, FileOperate *fileoperate);
    ~Downloader();

    QString currentUrl() const;
    QString currentFile() const;
    qreal progress() const;

    Q_INVOKABLE void appendDl(QByteArray url, QString file);

    Q_INVOKABLE bool isCurrentUrl(QString url);
    Q_INVOKABLE bool isFileExist(QString file);
    Q_INVOKABLE bool isTaskExist(QString url);

public slots:
    void setProgress(qint64 bytesReceived, qint64 bytesTotal);
    void setCurrentUrl(QString url);
    void setCurrentFile(QString file);
    void downloadFinished(int result);

signals:
    void currentUrlChanged();
    void currentFileChanged();
    void progressChanged();

    void startDownload(QUrl, QString);

private:
    QQueue<DownloadTask> downloadQueue;

    QPointer<QThread> thread;
    QPointer<DownloadPerformer> performer;

    qreal m_progress;
    QString m_currentUrl;
    QString m_currentFile;

    QDeclarativeView *m_viewer;
    Settings *m_settings;
    FileOperate *m_fileOperate;
};

class DownloadPerformer : public QObject
{

    Q_OBJECT

public:
    DownloadPerformer(QObject *parent = 0);
    DownloadPerformer(Downloader *downloader);
    ~DownloadPerformer();
signals:
    void finished(int);

public slots:
    void start(QUrl url, QString file);
    void downloadFinished();
    void downloadReadyRead();

private:
    //Downloader *m_downloader;
    QPointer<Downloader> m_downloader;
    QPointer<QNetworkAccessManager> manager;
    QPointer<QNetworkReply> currentDownload;
    QPointer<QFile> output;

};
#endif // QCURL_H
