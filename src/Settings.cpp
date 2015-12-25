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
#elif defined(Q_OS_SYMBIAN) | defined(Q_WS_SIMULATOR)
        m_downloadPath = settings->value("downloadPath", "E:/download").toString();
        m_installDriver = settings->value("installDriver", "E:/").toString();
#endif
        m_autoInstall = settings->value("autoInstall", false).toBool();
        m_silenceInstall = settings->value("silenceInstall", true).toBool();
        m_versionCode = settings->value("versionCode", 0).toInt();
    }
    else qDebug() << "settings load failed...";
}
void Settings::saveSettings()
{
    qDebug() << "Saving settins...";
    if (settings){
        settings->setValue("downloadPath", m_downloadPath);
#if defined(Q_OS_SYMBIAN) | defined(Q_WS_SIMULATOR)
        settings->setValue("installDriver",m_installDriver);
#endif
        settings->setValue("autoInstall",m_autoInstall);
        settings->setValue("silenceInstall", m_silenceInstall);
        settings->setValue("versionCode", m_versionCode);
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
#if defined (Q_OS_SYMBIAN) | defined (Q_WS_SIMULATOR)
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

bool Settings::silenceInstall()
{
    return m_silenceInstall;
}
void Settings::setSilenceInstall(bool newSilenceInstall)
{
    if(m_silenceInstall != newSilenceInstall){
        m_silenceInstall = newSilenceInstall;
        emit silenceInstallChanged();
    }
}

int Settings::versionCode()
{
    return m_versionCode;
}
void Settings::setVersionCode(int newVersionCode)
{
    if(m_versionCode != newVersionCode){
        m_versionCode = newVersionCode;
        emit versionCodeChanged();
    }
}
