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
public:
    explicit Settings(QObject *parent = 0);
    ~Settings();
    Q_INVOKABLE QString getDownloadPath();
    Q_INVOKABLE void setDownloadPath(QString newDownloadPath);
signals:
    void downloadPathChanged();
public slots:
    void loadSettings();
    void saveSettings();
    void clear();
private:
    QSettings *settings;
    QString downloadPath;
};
#endif // SETTINGS_H
