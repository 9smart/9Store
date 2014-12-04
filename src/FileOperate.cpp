#include "FileOperate.h"
#include <stdio.h>
#include <QFile>
#include <QTextStream>
#include <QFileDialog>
#include <QCryptographicHash>
#include <QDebug>
#include <QDesktopServices>
#include <QUrl>
#include <QProcess>
#include <QByteArray>
FileOperate::FileOperate(QObject *parent) :QObject(parent){
    pkgmgr=NULL;

}
FileOperate::~FileOperate(){
    if(pkgmgr!=NULL)
        delete pkgmgr;
}
QString FileOperate::fileHash(const QString &filename){
    QFile file(filename);
    QString result;
    if (file.open(QIODevice::ReadOnly)){
        QByteArray content = file.readAll();
        QByteArray md5 = QCryptographicHash::hash(content, QCryptographicHash::Md5);
        result = QString(md5.toHex());
        file.close();
    }
    return result;
}
bool FileOperate::checkFileSize(QString filename){
    QFile file;
    file.setFileName(filename);
    if(file.size()>10485760)
        return false;
    return true;
}
#ifdef Q_OS_HARMATTAN
void FileOperate::openFile(int key, QString filename){
    switch(key){
    case 1://Installation package
        if(pkgmgr==NULL)
            pkgmgr = new QProcess();
        pkgmgr->start("pkgmgr",QStringList()<<"install-file"<<"-f"<<filename);
        break;
    }
}
#else
void FileOperate::openFile(QString filename){
    QDesktopServices::openUrl(QUrl("file:///"+filename));
}
#endif
QString FileOperate::selectFolder(){
    return  QFileDialog::getExistingDirectory();
}
void FileOperate::deletFile(QString path){
    QFile fp(path);
    fp.remove();
}
bool FileOperate::dirExist(QString path){
    QDir dir(path);
    return dir.exists();
}
