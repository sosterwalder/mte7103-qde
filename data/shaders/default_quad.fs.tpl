// #version 330 core

// out / varying
varying vec2 v_texCoords;

// uniforms
uniform vec4 u_color;
uniform sampler2D u_texture;

void main(void)
{
  gl_FragColor = texture2D(u_texture, v_texCoords);
}
