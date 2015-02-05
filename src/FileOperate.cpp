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
#ifdef Q_OS_SYMBIAN
#include <SWInstApi.h>
#include <SWInstDefs.h>
#include "AOSync.h"
#endif
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
void FileOperate::openFile(int key,QString filename){
    //QDesktopServices::openUrl(QUrl("file:///"+filename));
    switch(key){
    case 1://Installation package

        _LIT( KTempPath , "E:\\QVideo.sis" );

        //CAOSync* waiter = CAOSync::NewL();
        //CleanupStack::PushL( waiter );

        SwiUI::RSWInstSilentLauncher iLauncher;
        SwiUI::TInstallOptions iOptions;
        SwiUI::TInstallOptionsPckg iOptionsPckg;

        iOptions.iUpgrade = SwiUI::EPolicyNotAllowed;
        iOptions.iOCSP = SwiUI::EPolicyAllowed;
        //iOptions.iUntrusted = SwiUI::EPolicyNotAllowed;
        iOptions.iDrive = 'C'; //同样可以使用67 69表示C E

        iOptionsPckg = iOptions;

        int a=iLauncher.Connect();
        qDebug()<<"connect ok";
        qDebug()<<a;

        TBufC<50> FName(KTempPath);

        a=iLauncher.SilentInstall(FName,iOptionsPckg);

        //waiter->Execute();

        //CleanupStack::PopAndDestroy( waiter );
        qDebug()<<"install start";

        iLauncher.Close();
        qDebug()<<"install finish";
        qDebug()<<a;
        break;
    }
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
