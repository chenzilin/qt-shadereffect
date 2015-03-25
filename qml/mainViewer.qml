import QtQuick 2.2
import "content"

Rectangle {

	id: shaderEffect
	width: 1280
	height: 422
	color: "black"

	//only for testing, please comment these two items under release version!
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

	ShaderEffectItem {
		id: waterScale
		x: 20
		y: 10
		width:400
		height: 400
		iGlobalTime: 0

		NumberAnimation on iGlobalTime {
			loops: Animation.Infinite; from: 0; to: Math.PI * 2; duration: 6914
		}

	}
}
