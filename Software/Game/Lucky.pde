class Lucky{
  
  float x, y;
  float gravedad;
  PImage jugador;
  float velocidad;
  Lucky(float _x, float _y, PImage _jugador){
    
    x = _x;
    y = _y;
    jugador = _jugador;
  }
  
  void pintarJugador(){
    
      distancia(); // Miro la distancia al cursor
      if (x > width - 80){
        x = width-80;
      }
      image(jugador, x, y);
  }
  
  void distancia(){
    
      if (x < mouseX){
          velocidad = mouseX - x;
          velocidad = velocidad/8;
          if (velocidad < 1){
              velocidad = 0;
          }
          x = x + velocidad;
      } else if(x > mouseX){
          velocidad = x - mouseX;
          velocidad = velocidad/8;
          if (velocidad < 1){
              velocidad = 0;
          }
          x = x-velocidad;
      }
    }
    
    
}


  
  
