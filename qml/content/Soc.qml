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
    property string ribbonSource

    Image {
        id: socImage
        opacity: 0
        source: soc.socSource
    }

    Image {
        id: ribbonImage
        opacity: 0
        source: soc.ribbonSource
    }

    ShaderEffect {

        id: socEffect
        width: soc.width
        height: soc.height

        property real level: soc.level
        property variant socShade : socImage

        property variant ribbonShade : ribbonImage

        fragmentShader: "
            uniform float qt_Opacity;
            varying highp vec2 qt_TexCoord0;

            uniform lowp float level;
            uniform sampler2D socShade;

            uniform sampler2D ribbonShade;

            void main() {

                vec2 coordRibbon = vec2(0.1, level);
                vec4 colorRibbon = texture2D(ribbonShade, coordRibbon);

                vec4 colorTargetShade = texture2D(socShade, qt_TexCoord0);

                if (qt_TexCoord0.y > level && colorTargetShade != vec4(0.0,0.0,0.0,0.0) )
                    gl_FragColor = colorRibbon * qt_Opacity;
                else
                    gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
            }"
    }
}
