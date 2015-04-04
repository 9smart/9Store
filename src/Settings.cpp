#include "Settings.h"
#include <QSettings>
#include <QDebug>
Settings::Settings(QObject *parent) : QObject(parent),settings(NULL)
{
    settings = new QSettings(QSettings::IniFormat,QSettings::UserScope,"QShen","9Store",this);
    loadSettings();
}
Settings::~Settings()
{
    saveSettings();
}
void Settings::loadSettings()
{
    qDebug() << "Loading settings...";
    if (settings){
#ifdef Q_OS_HARMATTAN
        m_downloadPath = settings->value("downloadPath", "/home/user/MyDocs/").toString();
#else
        m_downloadPath = settings->value("downloadPath", "E:/").toString();
        m_installDriver = settings->value("installDriver", "E:/").toString();
#endif
        m_autoInstall = settings->value("autoInstall",false).toBool();
    }
    else qDebug() << "settings load failed...";
}
void Settings::saveSettings()
{
    qDebug() << "Saving settins...";
    if (settings){
        settings->setValue("downloadPath", m_downloadPath);
        #ifdef Q_OS_SYMBIAN
        settings->setValue("installDriver",m_installDriver);
        #endif
        settings->setValue("autoInstall",m_autoInstall);
    }
    else qDebug() << "settings save failed...";
}
void Settings::clear()
{
    if (settings){
        settings->clear();
        loadSettings();
    }
}
QString Settings::getDownloadPath()
{
    return m_downloadPath;
}
void Settings::setDownloadPath(const QString newDownloadPath)
{
    if (m_downloadPath != newDownloadPath){
        m_downloadPath = newDownloadPath;
        emit downloadPathChanged();
    }
}
#ifdef Q_OS_SYMBIAN
QString Settings::getInstallDriver()
{
    return m_installDriver;
}
void Settings::setInstallDriver(QString newInstallDriver)
{
    if (m_installDriver != newInstallDriver){
        m_installDriver = newInstallDriver;
        emit installDriverChanged();
    }
}
#endif
bool Settings::autoInstall()
{
    return m_autoInstall;
}
void Settings::setAutoInstall(bool newAutoInstall)
{
    if (m_autoInstall != newAutoInstall){
        m_autoInstall = newAutoInstall;
        emit autoInstallChanged();
    }
}
