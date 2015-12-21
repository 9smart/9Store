#ifndef FILEOPERATE_H
#define FILEOPERATE_H
#include <QObject>
#include <QPointer>
#include <QQueue>
QT_BEGIN_NAMESPACE
class QProcess;
class Settings;
class QDeclarativeView;

class SymbianInstaller;
QT_END_NAMESPACE

class FileOperate : public QObject
{
    Q_OBJECT

#ifdef Q_OS_SYMBIAN
    Q_PROPERTY(QString currentInstallFile READ currentInstallFile NOTIFY currentInstallFileChanged)
#endif

public:
    explicit FileOperate(QObject *parent = 0);
    FileOperate(Settings *settings, QDeclarativeView *view);
    ~FileOperate();

    Q_INVOKABLE QString fileHash(const QString &filename);
    Q_INVOKABLE bool checkFileSize(QString filename);
    Q_INVOKABLE void openFile(int key, QString filename);
    Q_INVOKABLE QString selectFolder();
    Q_INVOKABLE void deletFile(QString path);
    Q_INVOKABLE bool dirExist(QString path);

#ifdef Q_OS_SYMBIAN
    QString currentInstallFile();
    void setCurrentInstallFile(QString newCurrentInstallFile);
#endif

public slots:

#ifdef Q_OS_SYMBIAN
    void symbianInstallFinished(int result);
#endif

signals:

#ifdef Q_OS_SYMBIAN
    void startSymbianSilenceInstall(QString fileName, char drive);
    void currentInstallFileChanged();
#endif

private:
    QProcess *pkgmgr;
    Settings *m_settings;
    QDeclarativeView *m_viewer;

#ifdef Q_OS_SYMBIAN
    QString m_currentInstallFile;
    QQueue<QString> installQueue;

    QPointer<QThread> thread;
    QPointer<SymbianInstaller> symbianInstaller;
#endif

};

#ifdef Q_OS_SYMBIAN
class SymbianInstaller : public QObject
{
    Q_OBJECT

public:
    SymbianInstaller(QObject *parent = 0);
    ~SymbianInstaller();

signals:
    void finished(int result);

public slots:
    void start(QString fileName, char drive);
};
#endif

#endif
