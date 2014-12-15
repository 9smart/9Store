#ifndef QCURL_H
#define QCURL_H
#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include <QObject>
#include <QThread>
#include <QPointer>
#include <QtDebug>
#include <curl/curl.h>
#include <QTextCodec>

class Qcurlperformer;
struct Qcurldl{
    char* url;
    FILE *fp;
    struct Qcurldl *next;
};
class Qcurl : public QObject{

    Q_OBJECT
    Q_PROPERTY(int state READ state NOTIFY stateChanged)
    Q_PROPERTY(char* currentUrl READ currentUrl NOTIFY currentUrlChanged)
    Q_PROPERTY(double progress READ getProgress NOTIFY progressChanged)
private:
    struct Qcurldl *head;
    struct Qcurldl *current;
    struct Qcurldl *last;
    CURL *curl;
    char currentUrl[3000];
    int state;
    static double progress;
    QPointer<QThread> thread;
    QPointer<Qcurlperformer> dl;
signals:
    void stateChanged();
    void currentUrlChanged();
    void progressChanged();

    void dlSetted();
    void startDl(CURL *curl);
public:
    explicit Qcurl(QObject *parent = 0);
    ~Qcurl();
    Q_INVOKABLE void appenddl(QString url, QString file);
    Q_INVOKABLE static double getProgress();
    Q_INVOKABLE bool isCurrentUrl(QString url);
    Q_INVOKABLE bool isFileExist(QString file);
    static size_t file_callback(void *ptr, size_t size, size_t nmemb, void *userp);
    static int progress_callback(void *clientp, double dltotal, double dlnow,double ultotal, double ulnow);
private slots:
    void startNextDl();
    //void changeprogress(double progress);
    void changeState(int state);
};
class Qcurlperformer : public QObject{
    Q_OBJECT
private:
    CURLcode res;
signals:
    void stateChanged(int state);
    void finished();
public:
    Qcurlperformer(QObject *parent = 0);
    ~Qcurlperformer();
public slots:
    void start(CURL *curl);

};
#endif // QCURL_H
