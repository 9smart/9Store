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
#if defined(Q_OS_SYMBIAN) | defined(Q_WS_SIMULATOR)
    Q_PROPERTY(QString installDriver READ getInstallDriver WRITE setInstallDriver NOTIFY installDriverChanged)
#endif
    Q_PROPERTY(bool autoInstall READ autoInstall WRITE setAutoInstall NOTIFY autoInstallChanged)
    Q_PROPERTY(bool silenceInstall READ silenceInstall WRITE setSilenceInstall NOTIFY silenceInstallChanged)
    Q_PROPERTY(int versionCode READ versionCode WRITE setVersionCode NOTIFY versionCodeChanged)

public:
    explicit Settings(QObject *parent = 0);
    ~Settings();

    Q_INVOKABLE QString getDownloadPath();
    Q_INVOKABLE void setDownloadPath(QString newDownloadPath);

#if defined(Q_OS_SYMBIAN) | defined(Q_WS_SIMULATOR)
    Q_INVOKABLE QString getInstallDriver();
    void setInstallDriver(QString newInstallDriver);
#endif

    Q_INVOKABLE bool autoInstall();
    void setAutoInstall(bool newAutoInstall);

    Q_INVOKABLE bool silenceInstall();
    void setSilenceInstall(bool newSilenceInstall);

    Q_INVOKABLE int versionCode();
    void setVersionCode(int newVersionCode);

signals:
    void downloadPathChanged();
#if defined(Q_OS_SYMBIAN) | defined(Q_WS_SIMULATOR)
    void installDriverChanged();
#endif
    void autoInstallChanged();
    void silenceInstallChanged();
    void versionCodeChanged();

public slots:
    void loadSettings();
    void saveSettings();
    void clear();

private:
    QSettings *settings;
    QString m_downloadPath;
#if defined(Q_OS_SYMBIAN) | defined(Q_WS_SIMULATOR)
    QString m_installDriver;
#endif
    bool m_autoInstall;
    bool m_silenceInstall;
    int m_versionCode;
};
#endif // SETTINGS_H
