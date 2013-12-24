//
//  FileLogger.h
//  hifi
//
//  Created by Stojce Slavkovski on 12/22/13.
//
//

#ifndef hifi_FileLogger_h
#define hifi_FileLogger_h

#include "AbstractLoggerInterface.h"

class FileLogger : public AbstractLoggerInterface {
    Q_OBJECT

public:
    FileLogger();

    virtual void addMessage(QString);
    virtual QStringList getLogData() { return _logData; };
    virtual void locateLog();

private:
    QStringList _logData;
    QString _fileName;
    QMutex _mutex;

};

#endif
