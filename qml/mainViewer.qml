import QtQuick 2.2
import "content"

Rectangle {

    id: shaderEffect
    width: 800
    height: 800
    color: "black"

    // only for testing, please comment these two items under release version!
    Loader {
        id: fps
        x: 500
        y: 20
        width: 110
        height: 10
        active: true
        asynchronous: true
        source: "qrc:/qml/qml/content/Fps.qml"
    }

    Image {
        x: 10
        y: 10
        width: 300
        height: 300
        source: "qrc:/images/images/sample.png"
    }

    ShaderEffectItem {
        x: 310
        y: 310
        width:400
        height: 400

        percent: 0.0
        source: "qrc:/images/images/sample.png"

        NumberAnimation on percent {
            from: 0
            to: 1
            duration: 4000
            loops: 1200
        }
    }
}
