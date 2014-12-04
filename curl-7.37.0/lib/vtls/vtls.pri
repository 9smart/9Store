DEPENDPATH += $$PWD


HEADERS += gtls.h\
           axtls.h\
           curl_darwinssl.h\
           curl_schannel.h\
           cyassl.h\
           gskit.h \
           vtls.h\
           nssg.h\
           openssl.h\
           polarssl.h\
           polarssl_threadlock.h\
           qssl.h
SOURCES += vtls.c\
           axtls.c\
           curl_darwinssl.c\
           curl_schannel.c\
           cyassl.c\
           gskit.c\
           gtls.c\
           nss.c\
           openssl.c\
           polarssl.c \
           polarssl_threadlock.c\
           qssl.c
