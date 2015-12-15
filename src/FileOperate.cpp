#include "FileOperate.h"
//#include <stdio.h>
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
    case 1://Silent Install package
        if(pkgmgr==NULL)
            pkgmgr = new QProcess();
        pkgmgr->start("pkgmgr",QStringList()<<"install-file"<<"-f"<<filename);
        break;
    case 2://Install package;
        QDesktopServices::openUrl(QUrl("file:///"+filename));
    }
}
#elif defined(Q_WS_SIMULATOR)
void FileOperate::openFile(int key, QString filename){
    switch(key){
    case 1://Silent Install package
        qDebug()<<"Silent install "<<filename;
        break;
    case 2:
        qDebug()<<"install "<<filename;
        break;
    }
}
#else
void FileOperate::openFile(int key, QString filename){
    switch(key){
    case 1:{//Silent Install package

        qDebug()<<"install "<<filename;

        //_LIT( KTempPath , "E:\\downloadVine.sis" );
        QByteArray ba = filename.toLatin1();
        //char *file = ba.data();
        char *file = "E:\\downloadVine.sis";
        //_LIT( KTempPath , file );

        //const static TLitC<sizeof(file)> KTempPath = {sizeof(file)-1, file};
        //CAOSync* waiter = CAOSync::NewL();
        //CleanupStack::PushL( waiter );

        SwiUI::RSWInstSilentLauncher iLauncher;
        SwiUI::TInstallOptions iOptions;
        SwiUI::TInstallOptionsPckg iOptionsPckg;

        //iOptions.iUpgrade = SwiUI::EPolicyNotAllowed;
        iOptions.iOCSP = SwiUI::EPolicyAllowed;
        //iOptions.iUntrusted = SwiUI::EPolicyNotAllowed;
        iOptions.iDrive = 'E'; //同样可以使用67 69表示C E

        iOptionsPckg = iOptions;

        int a=iLauncher.Connect();
        qDebug()<<"connect ok";
        qDebug()<<a;

        //TBufC<50> FName(KTempPath);
        const TText *text = (TText*)file;
        TBufC<50> FName(text);
        qDebug()<<"install start";
        a=iLauncher.SilentInstall(FName,iOptionsPckg);

        //waiter->Execute();

        //CleanupStack::PopAndDestroy( waiter );


        iLauncher.Close();
        qDebug()<<"install finish";
        qDebug()<<a;
        break;
    }
    case 2://Install package
        qDebug()<<"install package "<<filename;
        QDesktopServices::openUrl(QUrl("file:///"+filename));
        break;
    }
}
#endif
QString FileOperate::selectFolder(){
    return  QFileDialog::getExistingDirectory(0,tr("Select a directory"),"E://",QFileDialog::ShowDirsOnly);
}
void FileOperate::deletFile(QString path){
    QFile fp(path);
    fp.remove();
}
bool FileOperate::dirExist(QString path){
    QDir dir(path);
    return dir.exists();
}
