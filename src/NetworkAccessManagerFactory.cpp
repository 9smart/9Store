#include "NetworkAccessManagerFactory.h"
#include <QDesktopServices>

NetworkAccessManagerFactory::NetworkAccessManagerFactory() :
    QDeclarativeNetworkAccessManagerFactory()
{
}

QNetworkAccessManager* NetworkAccessManagerFactory::create(QObject *parent)
{
    QNetworkAccessManager* manager = new NetworkAccessManager(parent);

    QNetworkDiskCache* diskCache = new QNetworkDiskCache(parent);
    QString dataPath = QDesktopServices::storageLocation(QDesktopServices::CacheLocation);
    diskCache->setCacheDirectory(dataPath);
    diskCache->setMaximumCacheSize(3*1024*1024);
    manager->setCache(diskCache);

    return manager;
}

NetworkAccessManager::NetworkAccessManager(QObject *parent) :
    QNetworkAccessManager(parent)
{
}

QNetworkReply *NetworkAccessManager::createRequest(Operation op,
                                                   const QNetworkRequest &request,
                                                   QIODevice *outgoingData)
{
    QNetworkRequest req(request);
    //req.setRawHeader("Referer",".baidu.com");
    req.setAttribute(QNetworkRequest::CacheLoadControlAttribute, QNetworkRequest::PreferCache);
    QNetworkReply *reply = QNetworkAccessManager::createRequest(op, req, outgoingData);
    return reply;
}


