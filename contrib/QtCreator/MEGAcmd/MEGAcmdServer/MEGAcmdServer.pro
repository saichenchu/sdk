CONFIG -= qt

CONFIG(debug, debug|release) {
    CONFIG -= debug release
    CONFIG += debug
}
CONFIG(release, debug|release) {
    CONFIG -= debug release
    CONFIG += release
}

TARGET = MEGAcmd
TEMPLATE = app
CONFIG += console
CONFIG += USE_MEGAAPI


win32 {
DEFINES += USE_READLINE_STATIC
}

LIBS += -lreadline

packagesExist(libpcrecpp){
DEFINES += USE_PCRE
LIBS += -lpcrecpp
}

win32 {
    SOURCES += ../../../../src/wincurl/console.cpp
    SOURCES += ../../../../src/wincurl/consolewaiter.cpp
}
else {
    SOURCES += ../../../../src/posix/console.cpp
    SOURCES += ../../../../src/posix/consolewaiter.cpp
}

SOURCES += ../../../../examples/megacmd/megacmd.cpp \
    ../../../../examples/megacmd/listeners.cpp \
    ../../../../examples/megacmd/megacmdexecuter.cpp \
    ../../../../examples/megacmd/megacmdlogger.cpp \
    ../../../../examples/megacmd/configurationmanager.cpp \
    ../../../../examples/megacmd/comunicationsmanager.cpp \
    ../../../../examples/megacmd/megacmdutils.cpp


HEADERS += ../../../../examples/megacmd/megacmd.h \
    ../../../../examples/megacmd/megacmdexecuter.h \
    ../../../../examples/megacmd/listeners.h \
    ../../../../examples/megacmd/megacmdlogger.h \
    ../../../../examples/megacmd/configurationmanager.h \
    ../../../../examples/megacmd/comunicationsmanager.h \
    ../../../../examples/megacmd/megacmdutils.h \
    ../../../../examples/megacmd/megacmdversion.h \
    ../../../../examples/megacmd/megacmdplatform.h


    SOURCES +=../../../../examples/megacmd/comunicationsmanagerportsockets.cpp
    HEADERS +=../../../../examples/megacmd/comunicationsmanagerportsockets.h

win32 {
    LIBS += -lshell32
    RC_FILE = icon.rc
}
else {
    SOURCES +=../../../../examples/megacmd/comunicationsmanagerfilesockets.cpp
    HEADERS +=../../../../examples/megacmd/comunicationsmanagerfilesockets.h
}
include(../../../../bindings/qt/sdk.pri)
DEFINES -= USE_QT
DEFINES -= MEGA_QT_LOGGING
DEFINES += USE_FREEIMAGE
SOURCES -= src/thread/qtthread.cpp
win32{
    SOURCES += src/thread/win32thread.cpp
}
else{
    SOURCES += src/thread/posixthread.cpp
    LIBS += -lpthread
}
SOURCES -= src/gfx/qt.cpp
SOURCES += src/gfx/freeimage.cpp
SOURCES -= bindings/qt/QTMegaRequestListener.cpp
SOURCES -= bindings/qt/QTMegaTransferListener.cpp
SOURCES -= bindings/qt/QTMegaGlobalListener.cpp
SOURCES -= bindings/qt/QTMegaSyncListener.cpp
SOURCES -= bindings/qt/QTMegaListener.cpp
SOURCES -= bindings/qt/QTMegaEvent.cpp

macx {
    HEADERS += ../../../../examples/megacmd/megacmdplatform.h
    OBJECTIVE_SOURCES += ../../../../examples/megacmd/megacmdplatform.mm
    ICON = app.icns
    QMAKE_INFO_PLIST = Info_MEGA.plist
    DEFINES += USE_PTHREAD
    INCLUDEPATH += ../../../../bindings/qt/3rdparty/include/FreeImage/Source
    INCLUDEPATH += ../../../../bindings/qt/3rdparty/include/readline
    LIBS += $$PWD/../../../../bindings/qt/3rdparty/libs/libfreeimage.a
    LIBS += $$PWD/../../../../bindings/qt/3rdparty/libs/libreadline.a
    LIBS += -framework Cocoa -framework SystemConfiguration -framework CoreFoundation -framework Foundation -framework Security
    LIBS += -lncurses
}
else {
    LIBS += -lfreeimage
}
