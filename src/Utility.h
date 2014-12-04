#ifndef UTILITY_H
#define UTILITY_H
#include <QObject>

class Utility: public QObject {
    Q_OBJECT
public:
    Q_INVOKABLE QString base64(const QByteArray in);
    Q_INVOKABLE QString md5(const QString in);
};
#endif // UTILITY_H
