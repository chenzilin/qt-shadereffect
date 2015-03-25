#include <QDebug>
#include <QQuickView>
#include <QQmlEngine>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
	QGuiApplication app(argc, argv);

	QQuickView viewer;
	viewer.setSource(QUrl("qrc:/qml/qml/mainViewer.qml"));
	viewer.show();

	return app.exec();
}
