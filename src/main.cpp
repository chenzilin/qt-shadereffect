#include <QQuickView>
#include <QGuiApplication>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickView viewer;
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setSource (QUrl("qrc:/qml/qml/main.qml"));
    viewer.show ();

    return app.exec();
}
