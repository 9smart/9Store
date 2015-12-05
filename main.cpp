#include <QtGui/QApplication>
#include <QtDeclarative>
#include <QDebug>
#include "qmlapplicationviewer.h"

#include "src/FileOperate.h"
#include "src/Settings.h"
#include "src/UserData.h"
#include "src/Utility.h"
#include "src/NetworkAccessManagerFactory.h"
#include "src/MyImage.h"
#include "selectfilesdialog.h"

#ifndef Q_WS_SIMULATOR
#include "src/Qcurl.h"
#endif

Q_DECL_EXPORT int main(int argc, char *argv[])
   {
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    //splash
    #ifdef Q_OS_S60V5 //Symbian^1
    QSplashScreen *splash = new QSplashScreen(QPixmap("qml/symbian1/Resource/splash.png"));
    splash->show();
    splash->raise();
    #elif defined(Q_OS_SYMBIAN) //Symbian^3
    QSplashScreen *splash = new QSplashScreen(QPixmap(":/qml/pic/splash.png"));
    splash->show();
    splash->raise();
    #endif

    //translator
    QString locale = QLocale::system().name();
    QTranslator translator;
    translator.load( QString("9store_") + locale,":/");
    app->installTranslator(&translator);

    qmlRegisterType<SelectFilesDialog>("com.stars.widgets",1,0,"FilesDialog");
    qmlRegisterType<MyImage>("com.stars.widgets",1,0,"MyImage");

    QmlApplicationViewer viewer;
    FileOperate fileoperate;
    Settings settings;
    UserData userdata;
    Utility utility;

#ifndef Q_WS_SIMULATOR
    QCurl qcurl;
    viewer.rootContext()->setContextProperty("qcurl",&qcurl);
#endif
    NetworkAccessManagerFactory factory;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.engine()->setNetworkAccessManagerFactory(&factory);
    viewer.rootContext()->setContextProperty("fileoperate",&fileoperate);
    viewer.rootContext()->setContextProperty("settings",&settings);

    viewer.rootContext()->setContextProperty("userdata",&userdata);
    viewer.rootContext()->setContextProperty("utility",&utility);
    viewer.engine()->rootContext()->setContextProperty("fileDialog",new SelectFilesDialog());

    #ifdef Q_OS_S60V5  //Symbian^1
    //viewer.setMainQmlFile(QLatin1String("qml/symbian1/main.qml"));
    viewer.setSource(QUrl("qrc:/qml/symbian1/main.qml"));
    #elif defined(Q_OS_SYMBIAN) //Symbian^3
    viewer.setSource(QUrl("qml/symbian3/main.qml"));
    #elif defined(Q_WS_SIMULATOR)
    viewer.setSource(QUrl("qml/symbian3/main.qml"));
    #else //Meego
    viewer.setSource(QUrl("qrc:/qml/meego/main.qml"));
    #endif
    viewer.showExpanded();

    #ifdef Q_OS_SYMBIAN
    splash->finish(&viewer);
    splash->deleteLater();
    #endif

    return app->exec();
   }
