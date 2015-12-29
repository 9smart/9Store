#include <QtQuick>
#include <QQuickView>
#include <sailfishapp.h>
#include <QProcess>
#include <QDir>
#include <QGuiApplication>
#include "Utility.h"
#include "Settings.h"
#include "src/MyImage.h"
#include "cache.h"
int main(int argc, char *argv[])
{

    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF8"));
    qmlRegisterType<MyImage>("com.stars.widgets",1,0,"MyImage");
    QGuiApplication *app = SailfishApp::application(argc, argv);
    Cache *imageCache = new Cache("9store",app);
    QScopedPointer<QQuickView> view(SailfishApp::createView());
    view->rootContext()->setContextProperty("settings",new Settings());
    view->rootContext()->setContextProperty("utility",new Utility());
    view->rootContext()->setContextProperty("imageCache", imageCache);
    view->setSource(SailfishApp::pathTo("qml/harbour-9store.qml"));
    view->show();

    return app->exec();
}
