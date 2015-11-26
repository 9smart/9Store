TEMPLATE = app
TARGET = 9Store
VERSION = 0.5.1
DEFINES += VER=\\\"$$VERSION\\\"

TRANSLATIONS = 9store_zh_CN.ts

RESOURCES += \
    9Store.qrc

QT += network webkit

DEFINES += BUILDING_LIBCURL CURL_STATICLIB

SOURCES += main.cpp \
    src/Qcurl.cpp \
    src/Settings.cpp \
    src/FileOperate.cpp \
    src/UserData.cpp \
    src/Utility.cpp \
    src/NetworkAccessManagerFactory.cpp \
    src/MyImage.cpp

HEADERS += \
    src/Qcurl.h \
    src/Settings.h \
    src/FileOperate.h \
    src/UserData.h \
    src/Utility.h \
    src/NetworkAccessManagerFactory.h \
    src/MyImage.h

include(curl-7.37.0/lib/curl.pri)
include(curl-7.37.0/lib/vtls/vtls.pri)
include(selectfilesdialog/selectfilesdialog.pri)

INCLUDEPATH += curl-7.37.0/include \
               curl-7.37.0/lib

folder_Meego.source = qml/meego
folder_Meego.target = qml

folder_Symbian.source = qml/symbian3
folder_Symbian.target = qml

folder_Symbian1.source = qml/symbian1
folder_Symbian1.target = qml

folder_pic.source = qml/pic
folder_pic.target = qml

folder_JS.source = qml/JavaScript
folder_JS.target = qml

simulator{
          DEPLOYMENTFOLDERS +=  folder_Symbian folder_pic folder_JS
}

contains(MEEGO_EDITION,harmattan){
         DEFINES += Q_OS_HARMATTAN
         CONFIG += qdeclarative-boostable meegotouch
         DEPLOYMENTFOLDERS +=  folder_JS folder_Meego folder_pic
         RESOURCES += Meego-res.qrc
         OTHER_FILES += \
                       qtc_packaging/debian_harmattan/rules \
                       qtc_packaging/debian_harmattan/README \
                       qtc_packaging/debian_harmattan/manifest.aegis \
                       qtc_packaging/debian_harmattan/copyright \
                       qtc_packaging/debian_harmattan/control \
                       qtc_packaging/debian_harmattan/compat \
                       qtc_packaging/debian_harmattan/changelog
}
symbian{   
    contains(QT_VERSION, 4.7.3){
        DEFINES += Q_OS_S60V5
        #DEPLOYMENTFOLDERS += folder_Symbian1 folder_JS
        #DEPLOYMENTFOLDERS -= folder_pic
        RESOURCES += Symbian1-res.qrc
    } else {
        DEPLOYMENTFOLDERS += folder_Symbian folder_pic folder_JS
        #RESOURCES += Symbian3-res.qrc
    }
    INCLUDEPATH += $$[QT_INSTALL_PREFIX]/epoc32/include/platform/mw
    SOURCES += src/AOSync.cpp

    HEADERS += src/AOSync.h

    vendorinfo = "%{\"QShen\"}" ":\"QShen\""
    my_deployment.pkg_prerules += vendorinfo
    DEPLOYMENT.display_name = 久店
    DEPLOYMENT += my_deployment

    CONFIG += localize_deployment
    TARGET.UID3 = 0xE5735851
    TARGET.CAPABILITY += NetworkServices \
                         TrustedUI

    LIBS *= \
         -lswinstcli


    DEFINES -= VER=\\\"$$VERSION\\\"
    DEFINES += VER=\"$$VERSION\"
}

include(qmlapplicationviewer/qmlapplicationviewer.pri)

qtcAddDeployment()
