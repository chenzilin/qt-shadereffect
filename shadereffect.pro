# QT Modules
QT += qml quick

# Target
TARGET = shader_effect
TEMPLATE = app

CONFIG += qtdbcommit
CONFIG += qtquickcompiler

# Sources and Headers
SOURCE_FOLDER = src
SOURCES += $$SOURCE_FOLDER/main.cpp

# Qml Files
QML_FOLDER = qml/content
OTHER_FILES += qml/mainViewer.qml \
    $$QML_FOLDER/ShaderEffectItem.qml \
    $$QML_FOLDER/Fps.qml

# Resources
RESOURCES += shadereffect.qrc
QMAKE_RESOURCE_FLAGS += -no-compress

target.path = /opt/ShaderEffect
INSTALLS += target

# Objects Pathes
DESTDIR = bin
UI_DIR = build
MOC_DIR = build
RCC_DIR = build
OBJECTS_DIR = build
