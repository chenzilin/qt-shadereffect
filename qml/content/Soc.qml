/**************************
// <level> is Ruler
// 0                      1
// |——————————————————————> X (d_xCoord)
// |
// |
// |   vec4(1.0, 1.0, 1.0, 1.0): white
// |   vec4(0.0, 0.0, 0.0, 1.0): black
// |   vec4(0.0, 0.0, 0.0, 0.0): transparent
// |
// |
// |
// |
// | Y (d_yCoord)
//  1
***************************/

import QtQuick 2.4

Item {
    id: soc
    width: socImage.width
    height: socImage.height

    property real level
    property string socSource

    Image {
        id: socImage
        opacity: 0
        source: soc.socSource
    }

    ShaderEffect {

        id: socEffect
        width: soc.width
        height: soc.height

        property real level: soc.level
        property variant socShade : socImage

        property real wave:  0
        NumberAnimation on wave {
            from: 0.0; to: 2*3.141592654; loops: Animation.Infinite; duration: 1500
        }

        fragmentShader: "
            uniform float qt_Opacity;
            varying highp vec2 qt_TexCoord0;

            uniform lowp float wave;
            uniform lowp float level;
            uniform sampler2D socShade;

            void main() {
                vec4 colorTargetShade = texture2D(socShade, qt_TexCoord0);

                if (qt_TexCoord0.y > (level+0.025*sin(wave+qt_TexCoord0.x*2.0*3.141592654))
                    && colorTargetShade != vec4(0.0,0.0,0.0,0.0) ) {
                    gl_FragColor = colorTargetShade * qt_Opacity;
                }
                else
                    gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
            }"
    }
}
