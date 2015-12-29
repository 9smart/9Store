#include "Settings.h"
#include <QSettings>
#include <sailfishapp.h>
#include <QDebug>
Settings::Settings(QObject *parent) : QObject(parent),settings(NULL)
        {
         settings = new QSettings(QSettings::IniFormat,QSettings::UserScope,"Bird","9Store",this);
         loadSettings();
        }
Settings::~Settings()
        {
         saveSettings();
        }
void Settings::loadSettings()
    {
     qDebug() << "Loading settings...";
     if (settings)
       {
        #ifdef Q_OS_SAILFISH
        downloadPath = settings->value("downloadPath", "/home/nemo/.9store/").toString();
        #else
        //downloadPath = settings->value("downloadPath", "E:/").toString();
        #endif
       }
     else qDebug() << "settings load failed...";
    }
void Settings::saveSettings()
    {
     qDebug() << "Saving settins...";
     if (settings)
       {
        settings->setValue("downloadPath", downloadPath);
       }
     else qDebug() << "settings save failed...";
    }
void Settings::clear()
    {
     if (settings)
       {
        settings->clear();
        loadSettings();
       }
    }
QString Settings::getDownloadPath()
       {
        return downloadPath;
       }
void Settings::setDownloadPath(const QString newDownloadPath)
    {
     if (downloadPath != newDownloadPath)
       {
        downloadPath = newDownloadPath;
        emit downloadPathChanged();
       }
    }

