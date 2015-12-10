#ifndef QCURL_H
#define QCURL_H
#include <QObject>
#include <QPointer>
#include <curl/curl.h>
class QCurlPerformer;

struct QCurldl{
    char* url;
    FILE *fp;
    struct QCurldl *next;
};
class QCurl : public QObject{

    Q_OBJECT

    Q_PROPERTY(int state READ state NOTIFY stateChanged)
    Q_PROPERTY(QString currentUrl READ currentUrl NOTIFY currentUrlChanged)
    Q_PROPERTY(double progress READ progress NOTIFY progressChanged)

public:
    explicit QCurl(QObject *parent = 0);
    ~QCurl();

    int state() const;
    QString currentUrl() const;
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
    void setState(int state);
    void setCurrentUrl(QString url);

signals:
    void stateChanged();
    void currentUrlChanged();
    void progressChanged();

    void dlSetted();
    void startDl(CURL *curl);

private slots:
    void startNextDl();

private:
    struct QCurldl *head;
    struct QCurldl *current;
    struct QCurldl *last;
    CURL *curl;

    QPointer<QThread> thread;
    QPointer<QCurlPerformer> dl;

private:
    int m_state;
    double m_progress;
    QString m_currentUrl;
};

class QCurlPerformer : public QObject{

    Q_OBJECT

public:
    QCurlPerformer(QObject *parent = 0);
    ~QCurlPerformer();
signals:
    void stateChanged(int state);
    void finished();

public slots:
    void start(CURL *curl);

private:
    CURLcode res;
};
#endif // QCURL_H
