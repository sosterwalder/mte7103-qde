// #version 330 core

// in / attributes
attribute vec4 a_position;
attribute vec2 a_texCoords;

// out / varying
varying vec2 v_texCoords;

// uniforms
uniform mat4 u_mvpMatrix;

void main(void)
{
  gl_Position = u_mvpMatrix * a_position;
  v_texCoords = a_texCoords;
}
