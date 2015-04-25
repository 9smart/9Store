# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-9store

CONFIG += sailfishapp

DEFINES += Q_OS_SAILFISH

DEFINES += QT_USE_FAST_CONCATENATION QT_USE_FAST_OPERATOR_PLUS

SOURCES +=\
                    src/cache.cpp \
                    #src/Qcurl.cpp \
                    src/Settings.cpp \
                    src/Utility.cpp \
                    src/MyImage.cpp \
    src/harbour-9store.cpp
#include(curl-7.37.0/lib/curl.pri)
#include(curl-7.37.0/lib/vtls/vtls.pri)

QT += network quick qml

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    qml/pages/*.qml\
    qml/js/*.js\
    qml/img/star_active.png\
    qml/img/star_inactive.png\
    translations/*.ts \
    qml/pages/AboutPage.qml \
    qml/pages/components/ScreenshotBox.qml \
    qml/pages/qmlprovate.js \
    qml/pages/components/TextCollapsible.qml\
    qml/pages/components/DetailComponet.qml \
    qml/pages/components/RealtedComponet.qml \
    qml/pages/LoginPage.qml\
    qml/py/*.py \
    qml/pages/components/*.qml \
    qml/pages/components/AppListComponet.qml \
    qml/pages/components/AppListViewComponet.qml \
    qml/pages/components/RatingBox.qml \
    qml/pages/components/Progress.qml \
    qml/pages/components/ImagePage.qml \
    qml/pages/WelcomePage.qml \
    qml/pages/components/CommentsComponet.qml \
    qml/pages/UserCenter.qml \
    qml/js/utility.js \
    qml/pages/components/SubmitCommentComponet.qml \
    qml/js/base64.js \
    qml/js/des.js \
    qml/js/main.js \
    qml/pages/Signalcenter.qml \
    qml/js/han2pin.js \
    qml/pages/components/Notification.qml \
    qml/img/notifactionbar.png \
    qml/pages/components/WelcomeBoxBackground.qml \
    qml/pages/components/MoreButton.qml \
    qml/pages/components/WelcomeFeedItem.qml \
    qml/pages/components/AppGridListComponet.qml \
    qml/img/harbour-9smart.png \
    qml/img/App_icon_Error.svg \
    qml/img/App_icon_Loading.svg \
    qml/img/Score_1.* \
    qml/img/Score_2.* \
    qml/img/Score_3.* \
    qml/pages/components/InfoBanner.qml \
    rpm/harbour-9store.changes \
    rpm/harbour-9store.yaml \
    rpm/harbour-9store.spec \
    translations/harbour-9store-zh_CN.ts \
    harbour-9store.desktop \
    qml/harbour-9store.qml \
    qml/pages/DownloadPage.qml \
    qml/js/download.js \
    qml/pages/components/CacheImage.qml \
    qml/pages/SettingPage.qml


# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-9store-de.ts\
        translations/harbour-9store-zh_CN.ts

HEADERS += \
    #src/rpminstall.h \
    src/cache.h \
    src/Settings.h \
    src/Utility.h \
    src/MyImage.h
#INCLUDEPATH += curl-7.37.0/include\
#               curl-7.37.0/lib
