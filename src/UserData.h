#ifndef USERDATA_H
#define USERDATA_H
#include <QObject>
QT_BEGIN_NAMESPACE

QT_END_NAMESPACE
class UserData: public QObject
     {
      Q_OBJECT
      public:
            Q_INVOKABLE void setUserData(const QString &key, const QString &data);
            Q_INVOKABLE QString getUserData(const QString &key);
            Q_INVOKABLE bool clearUserData(const QString &key);
     };
#endif // USERDATA_H
