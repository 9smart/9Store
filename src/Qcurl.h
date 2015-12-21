#ifndef QCURL_H
#define QCURL_H
#include <QObject>
#include <QPointer>
#include <QQueue>
#include <curl/curl.h>
class QCurlPerformer;
class QDeclarativeView;
class Settings;
class FileOperate;

struct QCurlTask{
    char* url;
    FILE *fp;
};
class QCurl : public QObject{

    Q_OBJECT

    Q_PROPERTY(QString currentUrl READ currentUrl NOTIFY currentUrlChanged)
    Q_PROPERTY(QString currentFile READ currentFile NOTIFY currentFileChanged)
    Q_PROPERTY(double progress READ progress NOTIFY progressChanged)

public:
    explicit QCurl(QObject *parent = 0);
    explicit QCurl(QDeclarativeView *viewer, Settings *settings, FileOperate *fileoperate);
    ~QCurl();

    QString currentUrl() const;
    QString currentFile() const;
    double progress() const;

    Q_INVOKABLE void appenddl(QString url, QString file);

    Q_INVOKABLE bool isCurrentUrl(QString url);
    Q_INVOKABLE bool isFileExist(QString file);
    Q_INVOKABLE bool isTaskExist(QString url);

    static size_t file_callback(void *ptr, size_t size, size_t nmemb, void *userp);
    static int progress_callback(void *clientp, double dltotal, double dlnow,double ultotal, double ulnow);

public:
    void setProgress(double progress);

public slots:
    void setCurrentUrl(QString url);
    void setCurrentFile(QString file);
    void downloadFinished(int result);

signals:
    void currentUrlChanged();
    void currentFileChanged();
    void progressChanged();

    void startDownload(CURL *curl);

private:
    CURL *curl;

    QQueue<QCurlTask> downloadQueue;

    QPointer<QThread> thread;
    QPointer<QCurlPerformer> performer;

    int m_state;
    double m_progress;
    QString m_currentUrl;
    QString m_currentFile;

    QDeclarativeView *m_viewer;
    Settings *m_settings;
    FileOperate *m_fileOperate;
};

class QCurlPerformer : public QObject
{

    Q_OBJECT

public:
    QCurlPerformer(QObject *parent = 0);
    ~QCurlPerformer();
signals:
    void finished(int result);

public slots:
    void start(CURL *curl);

};
#endif // QCURL_H
