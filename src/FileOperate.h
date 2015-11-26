#ifndef FILEOPERATE_H
#define FILEOPERATE_H
#include <QObject>
QT_BEGIN_NAMESPACE
class QProcess;
QT_END_NAMESPACE

class FileOperate : public QObject
{
    Q_OBJECT
public:
    explicit FileOperate(QObject *parent = 0);
    ~FileOperate();
    Q_INVOKABLE QString fileHash(const QString &filename);
    Q_INVOKABLE bool checkFileSize(QString filename);
#ifdef Q_OS_HARMATTAN
    Q_INVOKABLE void openFile(int key, QString filename);
#else
    Q_INVOKABLE void openFile(int key, QString filename);
#endif
    Q_INVOKABLE QString selectFolder();
    Q_INVOKABLE void deletFile(QString path);
    Q_INVOKABLE bool dirExist(QString path);
private:
    QProcess *pkgmgr;
};
#endif
