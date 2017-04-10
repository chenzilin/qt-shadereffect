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
    id: shader
    width: shaderImage.width
    height: shaderImage.height

    property real percent
    property string source

    Image {
        id: shaderImage
        visible: false
        source: shader.source
    }

    ShaderEffect {
        id: shaderEffect
        width: shader.width
        height: shader.height

        property real percent: shader.percent
        property variant sourceImage : shaderImage

        fragmentShader: "
        uniform sampler2D sourceImage;
        uniform highp float percent;
        varying highp vec2 qt_TexCoord0;

    void main() {
        vec4 color = texture2D(sourceImage, qt_TexCoord0);
        float distance = length(qt_TexCoord0 - vec2(0.5, 0.5));

        if (distance > percent)
            gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
        else
            gl_FragColor = vec4(color.rgb, percent);
    }"
    }
}
