#include "Utility.h"
#include <QString>
#include <QCryptographicHash>

QString Utility::base64(const QByteArray in){

    return QString(in.toBase64());
}
QString Utility::md5(const QString in){
    QString md55;
    QByteArray ba,bb;
    QCryptographicHash md(QCryptographicHash::Md5);
    ba.append(in);
    md.addData(ba);
    bb = md.result();
    md55.append(bb.toHex());
    return md55;
}
