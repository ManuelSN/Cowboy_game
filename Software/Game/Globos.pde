class Globo {
  
  float x,y,velocidad;
  float angulo;
  PImage img; 
  float angoffset;
  Globo(float _x, float _y, float _velocidad, PImage _img)
  {
    angulo = 0;
    x = _x;
    y = _y; 
    velocidad = _velocidad;
    img = _img;
    angoffset = random(-1,1);
  }
  void dibujate()
  {
    x = x + velocidad; 
    velocidad = velocidad + 0.01;
    angulo=angulo + 0.015;
    push(); // push = pushStyle + pushMatrix
      fill(255,255,0); 
      strokeWeight(4);
      translate(x,y);
      rotate(angoffset+cos(angulo));
      ellipse(0,0,60,80);
      image(img,-140,-67,170,170);
      translate(0,45);
      triangle(0,-5,-5,0,5,0);
    pop(); // popStyle + popMatrix
  }
}
