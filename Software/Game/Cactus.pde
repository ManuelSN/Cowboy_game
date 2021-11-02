class Cactus{
  
  float x, y, ancho, alto;
  PImage img;
  
  Cactus(float _x, float _y, float _ancho, float _alto, PImage _objeto){
    
    x = _x;
    y = _y;
    ancho = _ancho;
    alto = _alto;
    objeto = _objeto;
  }
  
  void pintarCactus(){
    
    image(objeto, x, y, ancho, alto);
    
    
  }
  
  
}
