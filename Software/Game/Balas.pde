class Bala{
  
  float x, y;
  float y2 ;
  Bala(float _x, float _y){
    
    x = _x;
    y = _y;
  }
  
  void pintarBala(){
    
    push();
    strokeWeight(3);
    line(x+7, y-5, x+7, y-10);
    y = y - 10;
    pop();
    
    
  }
  
  
}
