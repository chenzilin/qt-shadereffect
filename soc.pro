# QT Modules
QT += qml quick

# Target
TARGET = soc
TEMPLATE = app

SOURCES += \
    src/main.cpp

# Qml Files
OTHER_FILES += \
    qml/main.qml \
    qml/content/*.qml \
    qml/content/qmldir

# Resources
RESOURCES += soc.qrc
QMAKE_RESOURCE_FLAGS += -no-compress

# Objects Pathes
DESTDIR = bin
UI_DIR = build
MOC_DIR = build
RCC_DIR = build
OBJECTS_DIR = build
