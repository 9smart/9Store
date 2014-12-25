INCLUDEPATH += $$PWD
HEADERS += \
    $$PWD/selectfilesdialog.h

SOURCES += \
    $$PWD/selectfilesdialog.cpp

symbian{
    message(Symbian build)

    #CONFIG += mobility
    #MOBILITY += systeminfo

    contains(QT_VERSION, 4.7.3){
        DEFINES += SYMBIAN1_BOOSTER
    RESOURCES += \
        $$PWD/symbian1.qrc
    OTHER_FILES += \
        $$PWD/symbian1.qml
    } else {
    RESOURCES += \
        $$PWD/symbian.qrc
    OTHER_FILES += \
        $$PWD/symbian.qml
    }
}

simulator{
    message(Simulator build)
    RESOURCES += \
        $$PWD/symbian.qrc \
        $$PWD/symbian1.qrc

    OTHER_FILES += \
        $$PWD/symbian.qml \
        $$PWD/symbian1.qml \
        $$PWD/meego.qml
}

contains(MEEGO_EDITION, harmattan){
    message(Harmattan build)
    DEFINES += HARMATTAN_BOOSTER

    RESOURCES += \
        $$PWD/meego.qrc

    OTHER_FILES += \
        $$PWD/meego.qml
}

RESOURCES += \
    $$PWD/icons.qrc
