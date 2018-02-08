#ifdef GL_ES
precision mediump float;
varying mediump vec2 v_texCoord;
#else
varying vec2 v_texCoord;
#endif
attribute vec2 a_texCoord;
attribute vec4 a_color;
attribute vec4 a_position;
varying vec4 v_fragmentColor;

void main()
{
    gl_Position = CC_PMatrix * a_position;
    v_fragmentColor = a_color;
    v_texCoord = a_texCoord;
}
