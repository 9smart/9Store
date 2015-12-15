#include "UserData.h"
#include <QDesktopServices>
#include <QDir>
#include <QTextStream>
#include <QDebug>
void UserData::setUserData(const QString &key, const QString &data)
{
    QString path = QDesktopServices::storageLocation(QDesktopServices::DataLocation) + QDir::separator() + ".userdata" + QDir::separator() + "9Store";
    QDir dir(path);
    if (!dir.exists()) dir.mkpath(path);

    QString filename = path + QDir::separator() + key + ".dat";
    //qDebug()<<filename;
    QFile file(filename);
    if(file.open(QIODevice::WriteOnly))
    {
        QTextStream stream(&file);
        stream << data;
        file.close();
    }
    else qDebug()<<"data failed!";
}

QString UserData::getUserData(const QString &key)
{
    QString path = QDesktopServices::storageLocation(QDesktopServices::DataLocation) + QDir::separator() + ".userdata" + QDir::separator() + "9Store";
    QString filename = path + QDir::separator() + key + ".dat";
    QString res;
    QFile file(filename);
    if (file.exists() && file.open(QIODevice::ReadOnly))
    {
        QTextStream stream(&file);
        res = stream.readAll();
        file.close();
    }
    return res;
}

bool UserData::clearUserData(const QString &key)
{
    QString path = QDesktopServices::storageLocation(QDesktopServices::DataLocation) + QDir::separator() + ".userdata" + QDir::separator() + "9Store";
    QString filename = path + QDir::separator() + key + ".dat";
    QFile file(filename);
    return file.remove();
}
