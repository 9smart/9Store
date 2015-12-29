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
#include <QThread>
#include <QDeclarativeView>
#include <QDeclarativeItem>

#include "Settings.h"
#ifdef Q_OS_SYMBIAN
#include <SWInstApi.h>
#include <SWInstDefs.h>
#include "AOSync.h"
#endif
FileOperate::FileOperate(QObject *parent) :QObject(parent)
{
    pkgmgr = NULL;
}

FileOperate::FileOperate(Settings *settings, QDeclarativeView *viewer)
{
    pkgmgr = NULL;
    m_settings = settings;
    m_viewer = viewer;
}

FileOperate::~FileOperate()
{
    if(pkgmgr != NULL)
        delete pkgmgr;

#ifdef Q_OS_SYMBIAN
    if(!thread.isNull()){
        thread->terminate();
        thread->wait();
        symbianInstaller->deleteLater();
    }
#endif
}
QString FileOperate::fileHash(const QString &filename)
{
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
bool FileOperate::checkFileSize(QString filename)
{
    QFile file;
    file.setFileName(filename);
    if(file.size()>10485760)
        return false;
    return true;
}
#ifdef Q_OS_HARMATTAN
void FileOperate::openFile(int key, QString filename)
{
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
void FileOperate::openFile(int key, QString filename)
{
    switch(key){
    case 1://Silent Install package
        qDebug()<<"Silent install "<<filename;
        break;
    case 2:
        qDebug()<<"install "<<filename;
        break;
    }
}
#elif defined(Q_OS_SYMBIAN)
void FileOperate::openFile(int key, QString filename)
{
    filename.replace("//", "/");
    switch(key){
    case 1:{//Silent Install package
        qDebug()<< "silence install package" << filename;
        if(thread.isNull()){
            thread = new QThread(this);
            symbianInstaller = new SymbianInstaller();
            symbianInstaller->moveToThread(thread);
            connect(this, SIGNAL(startSymbianSilenceInstall(QString,char)), symbianInstaller, SLOT(start(QString,char)));
            connect(symbianInstaller, SIGNAL(finished(int)), this, SLOT(symbianInstallFinished(int)));
            thread->start(QThread::IdlePriority);
        }
        installQueue.enqueue(filename);
        if(currentInstallFile() == ""){
            setCurrentInstallFile(installQueue.dequeue());
            emit startSymbianSilenceInstall(currentInstallFile(), m_settings->getInstallDriver().at(0).toAscii());
        }
        break;
    }
    case 2://Install package
        qDebug()<<"install package "<<filename;
        QDesktopServices::openUrl(QUrl("file:///"+filename));
        break;
    }
}

QString FileOperate::currentInstallFile()
{
    return m_currentInstallFile;
}

void FileOperate::setCurrentInstallFile(QString newCurrentInstallFile)
{
    if(m_currentInstallFile != newCurrentInstallFile){
        m_currentInstallFile = newCurrentInstallFile;
        emit currentInstallFileChanged();
    }
}

void FileOperate::symbianInstallFinished(int result)
{
    QDeclarativeItem *rootItem = qobject_cast<QDeclarativeItem*>(m_viewer->rootObject());
    QObject *signalCenter = rootItem->findChild<QObject*>("signalCenter");
    if(result == 0){
        QMetaObject::invokeMethod(signalCenter, "showMessage", Qt::QueuedConnection, Q_ARG(QVariant, QVariant(currentInstallFile() + tr(" was installed successfully"))));
    }
    else {
        QMetaObject::invokeMethod(signalCenter, "showMessage", Qt::QueuedConnection, Q_ARG(QVariant, QVariant(currentInstallFile() + tr(" installation was failed"))));
    }
    setCurrentInstallFile("");
    if(!installQueue.isEmpty()){
        setCurrentInstallFile(installQueue.dequeue());
        emit startSymbianSilenceInstall(currentInstallFile(), m_settings->getInstallDriver().at(0).toAscii());
    }
}

#endif
QString FileOperate::selectFolder()
{
    return  QFileDialog::getExistingDirectory(0,tr("Select a directory"),"E://",QFileDialog::ShowDirsOnly);
}
void FileOperate::deletFile(QString path)
{
    QFile fp(path);
    fp.remove();
}
bool FileOperate::dirExist(QString path)
{
    QDir dir(path);
    return dir.exists();
}

#ifdef Q_OS_SYMBIAN
SymbianInstaller::SymbianInstaller(QObject *parent) : QObject(parent)
{

}

SymbianInstaller::~SymbianInstaller()
{

}

void SymbianInstaller::start(QString fileName, char drive)
{
    qDebug()<<"Silent install "<<fileName;

    fileName.replace(QString("/"), QString("\\"));

    SwiUI::RSWInstSilentLauncher iLauncher;
    SwiUI::TInstallOptions iOptions;
    SwiUI::TInstallOptionsPckg iOptionsPckg;

    iOptions.iOCSP = SwiUI::EPolicyNotAllowed;
    //iOptions.iOverwrite = SwiUI::EPolicyAllowed;
    /*iOptions.iUpgrade = SwiUI::EPolicyAllowed;
    iOptions.iIgnoreOCSPWarnings = SwiUI::EPolicyAllowed;*/
    //iOptions.iUntrusted = SwiUI::EPolicyAllowed;

    //iOptions.iDrive = 'E'; //同样可以使用67 69表示C E
    iOptions.iDrive = drive;


    iOptionsPckg = iOptions;

    int result = iLauncher.Connect();
    if(result != 0){
        qDebug() << "launcher failed";
        emit finished(result);
        return;
    }

    TPtrC16 ptr(static_cast<const TUint16*>(fileName.utf16()), fileName.length());
    HBufC *desc_param = HBufC::NewLC(ptr.Length());
    desc_param->Des().Copy(ptr);

    qDebug()<<"install start";
    result = iLauncher.SilentInstall(*desc_param, iOptionsPckg);

    CleanupStack::PopAndDestroy(desc_param );

    iLauncher.Close();
    qDebug()<<"install finish " << result;
    emit finished(result);
}

#endif
