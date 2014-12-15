#ifndef QCURL_H
#define QCURL_H
#include <QObject>
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
    Q_PROPERTY(char* currentUrl READ currentUrl NOTIFY currentUrlChanged)
    Q_PROPERTY(double progress READ progress NOTIFY progressChanged)

public:
    explicit QCurl(QObject *parent = 0);
    ~QCurl();

    int state() const;
    char *currentUrl() const;
    static double progress();

    Q_INVOKABLE void appenddl(QString url, QString file);
    //Q_INVOKABLE static double getProgress();
    Q_INVOKABLE bool isCurrentUrl(QString url);
    Q_INVOKABLE bool isFileExist(QString file);

    static size_t file_callback(void *ptr, size_t size, size_t nmemb, void *userp);
    static int progress_callback(void *clientp, double dltotal, double dlnow,double ultotal, double ulnow);

signals:
    void stateChanged();
    void currentUrlChanged();
    void progressChanged();

    void dlSetted();
    void startDl(CURL *curl);

private:
    struct Qcurldl *head;
    struct Qcurldl *current;
    struct Qcurldl *last;
    CURL *curl;    

    QPointer<QThread> thread;
    QPointer<QCurlPerformer> dl;

private slots:
    void startNextDl();

    void setState(int state);
    void setCurrentUrl(char *url);
    void setProgress(double progress);

private:
    int m_state;
    static double m_progress;
    char m_currentUrl[3000];
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
