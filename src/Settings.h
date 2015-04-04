#ifndef SETTINGS_H
#define SETTINGS_H
#include <QObject>

QT_BEGIN_NAMESPACE
class QSettings;
QT_END_NAMESPACE

class Settings : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString downloadPath READ getDownloadPath WRITE setDownloadPath NOTIFY downloadPathChanged)
#ifdef Q_OS_SYMBIAN
    Q_PROPERTY(QString installDriver READ getInstallDriver WRITE setInstallDriver NOTIFY installDriverChanged)
#endif
    Q_PROPERTY(bool autoInstall READ autoInstall WRITE setAutoInstall NOTIFY autoInstallChanged)

public:
    explicit Settings(QObject *parent = 0);
    ~Settings();

    Q_INVOKABLE QString getDownloadPath();
    Q_INVOKABLE void setDownloadPath(QString newDownloadPath);
#ifdef Q_OS_SYMBIAN
    Q_INVOKABLE QString getInstallDriver();
    Q_INVOKABLE void setInstallDriver(QString newInstallDriver);
#endif
    Q_INVOKABLE bool autoInstall();
    Q_INVOKABLE void setAutoInstall(bool newAutoInstall);

signals:
    void downloadPathChanged();
#ifdef Q_OS_SYMBIAN
    void installDriverChanged();
#endif
    void autoInstallChanged();

public slots:
    void loadSettings();
    void saveSettings();
    void clear();

private:
    QSettings *settings;
    QString m_downloadPath;
#ifdef Q_OS_SYMBIAN
    QString m_installDriver;
#endif
    bool m_autoInstall;
};
#endif // SETTINGS_H
