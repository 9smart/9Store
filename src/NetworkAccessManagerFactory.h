#ifndef NETWORKACCESSMANAGERFACTORY_H
#define NETWORKACCESSMANAGERFACTORY_H
#include <QtDeclarative>
#include <QtNetwork>

class NetworkAccessManagerFactory : public QDeclarativeNetworkAccessManagerFactory
{
public:
    explicit NetworkAccessManagerFactory();
    virtual QNetworkAccessManager* create(QObject *parent);
};

class NetworkAccessManager : public QNetworkAccessManager
{
    Q_OBJECT
public:
    explicit NetworkAccessManager(QObject *parent=0);
protected:
    QNetworkReply *createRequest(Operation op, const QNetworkRequest &request, QIODevice *outgoingData);
};
#endif // NETWORKACCESSMANAGERFACTORY_H
