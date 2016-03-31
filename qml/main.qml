import QtQuick 2.4
import "content"

Rectangle {
    id: root
    width: 500
    height: 400
    color: "gray"

    Soc {
        id: soc
        x: 183
        y:96
        level: 1.0
        socSource: "qrc:/new/images/powerBlue.png"
    }

    Image {
        id: image
        x: 100
        y: 100
        source: "qrc:/new/images/ball.png"
    }

    SequentialAnimation {
        running: true
        NumberAnimation { target: soc; property: "level"; to: 0; duration: 2000 }
        NumberAnimation { target: soc; property: "level"; to: 1; duration: 2000 }
        loops: Animator.Infinite
    }
}
