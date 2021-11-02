/***************************

GISE - Electrónica Creativa

Manuel Sánchez Natera

*Disparos del juego manejados con piezoelectrico o con boton izquierdo del ratón.
* Movimiento del personaje con el ratón.

**************************/

// Importamos libreria del puerto serie
import processing.serial.*;

// Imagenes
PImage fondo;
PImage jugador;
PImage inicio;
PImage objeto;
PImage casa;
PImage lucky;
PImage mira;
PImage dalton;

// Variables del juego
int estado;
int aumenta = 1;
int opacidad = 50;
int textoNivel;
int cambiaNivel = 0;
int numGlobos;
int contGlobos = 0;
int startTimer = millis();
int tiempoEntreGlobos = 10000;
int tiempoMatojo = 10000000;
float ancho[] = {0, width};
int numGlobosVictoria;
int globosExplotados  = 0;
int nivel = 1;
int globosEliminados = 0;
int antirrebote = 300;
int tiempoAnt = millis();
float velocidad;

// Puerto Serie
Serial miPuerto;

// Listas de objetos
ArrayList<Cactus> listaCactus;
ArrayList<Bala> listaBalas;
ArrayList<Globo> listaGlobos; 
ArrayList<Lucky> listaLuckys; 

// Objetos de clases
Cactus c;
Bala bala;
Lucky luke;


void setup() {
  
  // Ajustamos a tamaño de la pantalla
  size(1252, 780);
  
  
  // Cargamos imagenes en el juego y las ajustamos
  fondo = loadImage("oeste.jpg");
  dalton = loadImage("dalton.png");
  objeto = loadImage("cactus.png");
  casa = loadImage("casa.png");
  lucky = loadImage("lucky.png");
  mira = loadImage("mira.png");
  mira.resize(50,30);
  image(fondo, 0, 0, width, height);
  image(casa, width - 1100, 420, 211, 158);
  inicio = loadImage("start.png");
  inicio.resize(265, 133);
  jugador = loadImage("jugador_inicio.png");
  image(jugador, 0, 600);
  
  // Inicializamos listas de objetos
  listaCactus = new ArrayList<Cactus>();
  listaBalas = new ArrayList<Bala>();
  listaGlobos = new ArrayList<Globo>();
  listaLuckys = new ArrayList<Lucky>();
  
  // ponemos una mira como cursor
  cursor(mira);
  
  // Preparamos puerto serie
  printArray(Serial.list());  //Lista de posibles comunicaciones serie
  miPuerto = new Serial(this, Serial.list()[1], 9600); // Inicialización del puerto serie 
  
  // Inicializamos variables del juego
  estado = 0;
  velocidad = 2;
  numGlobos = 10;
  
  // Creamos y colocamos los distintos cactus en el paisaje
  c = new Cactus(width - 385, 500, 30, 40,objeto);
  listaCactus.add(c);
  c = new Cactus(width - 290, 500, 30, 60, objeto);
  listaCactus.add(c);
  c = new Cactus(width - 400, 500, 30, 60, objeto);
  listaCactus.add(c);
  c = new Cactus(width - 800, 580, 50, 100, objeto);
  listaCactus.add(c);
  c = new Cactus(width - 800, 500, 30, 60, objeto);
  listaCactus.add(c);
  c = new Cactus(width - 810, 530, 25, 30, objeto);
  listaCactus.add(c);
  c = new Cactus(width - 775, 480, 25, 80, objeto);
  listaCactus.add(c);
    
  for(int i = 0; i < listaCactus.size(); i++){
      c = listaCactus.get(i);
      c.pintarCactus();
  }
  
}

void draw() {
  
  // comprueba que haya datos que leer en el puerto serie
  while(miPuerto.available()>0){
    
    // Entra en la funcion del piezoelectrico si los hay
    piezoelectricoPressed(miPuerto.read());
  }
  
  // Usado para depurar excepciones
  try {
  
  // Maquina de estados del juego
  switch(estado){
  case 0: // Estado de inicializacion
    // Llamamos a procedimiento que inicia el juego
    iniciarJuego();
    nivel = 1;
    startTimer = millis();
    break;
   case 1: // Nivel 1
       pintarFondo();
       velocidad = 16;
       numGlobos = 10;
       numGlobosVictoria = 5;
       moverGlobos();
       luke = listaLuckys.get(0);
       luke.pintarJugador(); 
       disparar();
       generarGlobos();
       eliminarBalasPerdidas();
       eliminarGlobosPerdidos();
       colisionesBalayGlobo();
       if (cambiaNivel == 1){
         textoNivel(nivel);
         if (millis()-textoNivel >= 1000){
            cambiaNivel = 0;
            estado++;
         } 
       }
       informacionPartida();
       comprobarGameOver();
    break;
   case 2: // Nivel 2
         pintarFondo();
         velocidad = 16;
         tiempoEntreGlobos = 8000;
         numGlobos = 15;
         numGlobosVictoria = 10;
         moverGlobos();
         luke = listaLuckys.get(0);
         luke.pintarJugador(); 
         disparar();
         generarGlobos();
         eliminarBalasPerdidas();
         eliminarGlobosPerdidos();
         colisionesBalayGlobo();
         if (cambiaNivel == 1){
           textoNivel(nivel);
           if (millis()-textoNivel >= 1000){
              cambiaNivel = 0;
              estado++;
           } 
         }
         informacionPartida();
         comprobarGameOver();
         break;
   case 3: // Nivel 3
         pintarFondo();
         velocidad = 16;
         tiempoEntreGlobos = 7000;
         numGlobos = 15;
         numGlobosVictoria = 12;
         moverGlobos();
         luke = listaLuckys.get(0);
         luke.pintarJugador();  
         disparar();
         generarGlobos();
         eliminarBalasPerdidas();
         eliminarGlobosPerdidos();
         colisionesBalayGlobo();
         if (cambiaNivel == 1){
             textoNivel(nivel);
             if (millis()-textoNivel >= 1000){
                cambiaNivel = 0;
                estado++;
             } 
         }
         informacionPartida();
         comprobarGameOver();
         break;
   case 4: // Nivel 4
         pintarFondo();
         velocidad = 16;
         tiempoEntreGlobos = 6000;
         numGlobos = 15;
         numGlobosVictoria = 15;
         moverGlobos();
         luke = listaLuckys.get(0);
         luke.pintarJugador(); 
         disparar();
         generarGlobos();
         eliminarBalasPerdidas();
         eliminarGlobosPerdidos();
         colisionesBalayGlobo();
         if (nivel != 5){
           informacionPartida();
         }
         comprobarGameOver();
         break;
  case 5: // WINNER
        textoWinner();
        break;
  case 6: // GAME OVER
        textoGameOver();
        break;
     
  }
  
   }catch(Exception ex){
    print(ex); //<>//
  }
}

// Procedimiento que detecta una tecla pulsada, se usa para volver a iniciar el juego cuando este acaba o se arranca por primera vez
void keyPressed() {
  
  if (estado == 0) {

    estado = 1;
    listaLuckys.add(new Lucky(width/2, height - 200, lucky));
    Lucky luke = listaLuckys.get(0);
    luke.pintarJugador();
    contGlobos = 0;
  } else if ((estado == 6) || (estado == 5)){
    
     estado = 0;
  }
}

// Procedimiento que implementa los disparos con el raton
void mousePressed(){
  
  if ((estado != 0) && (estado != 6) && (estado != 5)){
    
     float x;
     float y = height - 154;
     Lucky lu = listaLuckys.get(0);
     x = lu.x + 1;
     listaBalas.add(new Bala(x, y));
    
  }
  
}

// Procedimiento que implementa los disparos con el piezoelectrico
void piezoelectricoPressed(int valor){
  
  if (valor > 50){
    // Antirrebotes del piezo electrico. espera 300ms para volver a 'disparar'
    if (millis() >= tiempoAnt + antirrebote){
      tiempoAnt = millis();
      if ((estado != 0) && (estado != 6) && (estado != 5)){
    
         float x;
         float y = height - 154;
         Lucky lu = listaLuckys.get(0);
         x = lu.x + 1;
         listaBalas.add(new Bala(x, y));
    
      }
      
    }
         
  } 
}

// Procedimiento que inicializa el juego
void iniciarJuego() {

  
  tint(255,255);
  pintarFondo();
  image(jugador, 0, 600);
  push();
  imageMode(CENTER);
  tint(255, opacidad); // Para darle opacidad sin cambiar colores
  image(inicio, width/2, height/2);
  pop();
  textSize(30);
  if (aumenta == 1) {
    opacidad = opacidad + 10;
    if (opacidad >=255)
    {
      aumenta = 0;
    }
  } else if (aumenta == 0) 
  {
    opacidad = opacidad - 10;
    if (opacidad <=0)
    {
      aumenta = 1;
    }
  }
  fill(255, opacidad); // Da opacidad al texto sin cambiar color.
  text("Press any key to start...", (width/2) - 160, (height/2) + 78);
}

void pintarFondo(){
  
  image(fondo, 0, 0, width, height);
  
  for (int i = 0; i < listaCactus.size(); i++){  
      c = listaCactus.get(i);
      c.pintarCactus();
  }
  image(casa, width - 1100, 420, 211, 158);
  //<>//
}
 //<>//

// Procedimiento que pinta las balas
void disparar(){
   
    for (int i = 0; i < listaBalas.size(); i++){
        
        Bala bala = listaBalas.get(i);
        bala.pintarBala();
    }
}

// Procedimiento que se encarga de crear globos
void generarGlobos(){
  
  //print("He entrado en generar globos");
  //print('\n');
  if (contGlobos < numGlobos){
    if ((millis()-startTimer) > (tiempoEntreGlobos)){
      
       listaGlobos.add(new Globo(0, random(0, height/2 - 70), velocidad, dalton));
       contGlobos++;
       startTimer = millis();
       
    }         
  } 
  
    //print("Salgo de generar globos");
    //print('\n');
}

// Procedimiento que se encarga de mover los globos creados
void moverGlobos(){
  
  for (int i=0; i<listaGlobos.size(); i++) {
        
            
      Globo g = listaGlobos.get(i);
      g.dibujate();  
      
           
  }
  
  
}

// Procedimiento que elimina las balas que se salen de la pantalla
void eliminarBalasPerdidas(){
  
   for (int i = listaBalas.size()-1; i>=0; i--){
     
    Bala bala = listaBalas.get(i);
    if (bala.y < -15){
      
      listaBalas.remove(i);
    }
  }
}

// Procedimiento que elimina los globos que se salen de la pantalla
void eliminarGlobosPerdidos(){
  
  //print("He entrado en eliminar globos y balas");
  //print('\n');
  for (int i = listaGlobos.size()-1; i>=0; i--){
    
    Globo g = listaGlobos.get(i);
    if (g.x > width+40){
      listaGlobos.remove(i);
      globosEliminados++;
      comprobarGameOver();
    }
  }
  //print("Salgo de eliminar globos y balas");
  //print('\n');
}

// Cuando se acaba un nivel o el juego se borran todos los globos y balas del juego que quedan sin pintarse.
void vaciarBalasyGlobos(){
  
  for (int i = listaBalas.size()-1; i>=0; i--){
     
    listaBalas.remove(i);
    
  }
  
  for (int j = listaGlobos.size()-1; j>=0; j--){
     
    listaGlobos.remove(j);
    
  }
  
  
}

// Procedimiento que detecta las colisiones entre balas y globos, además si se llega al numero de globos por nivel cambia de nivel.
void colisionesBalayGlobo(){
  
  //print("He entrado en colisiones");
  //print('\n');
  for (int i = listaGlobos.size()-1; i>=0; i--){
    
    Globo globo = listaGlobos.get(i);
    for (int j = listaBalas.size()-1; j>=0; j--){
      Bala bala = listaBalas.get(j);
      // Suponemos que globo es un circulo con centro en (globo.x, globo,y) y radio 10
      // Suponemos que bala es un circulo con centro en (bala.x, bala.y) y radio 2
      // El radio de estos será el menor radio que cubra cada objeto respectivamente
      float distancia = sqrt((globo.x - bala.x)*(globo.x - bala.x)
        +(globo.y - bala.y)*(globo.y - bala.y));
      // Calculamos la distancia entre todos las balas dibujadas y todos los globos
     
      //Calculamos la suma de los radios de las bala y los globos
      float sumaRadios = 5 + 32;
      // Si se cumple es que hay colision
      if (distancia < sumaRadios){
        
        if ((listaGlobos.size() > 0) && (listaBalas.size() > 0)){
            listaGlobos.remove(i);
            listaBalas.remove(j);
            globosExplotados++;
        }
        if (globosExplotados == numGlobosVictoria){
           nivel++;
           globosExplotados = 0;
           globosEliminados = 0;
           contGlobos = 0;
           if (nivel != 5){
             cambiaNivel = 1;
             textoNivel = millis();
           }
           
           // Borro el resto de globos que queden sin explotar y balas dibujadas
           if (listaGlobos.size() > 0){
               vaciarBalasyGlobos();
           }
        } 
      }
    }
  }
  
   
  
 // print("Salgo de colisiones");
  //print('\n');
}

// Procedimiento que comprueba si el juego ha terminado.
void comprobarGameOver(){
  
  if ((globosEliminados > (numGlobos - numGlobosVictoria)) && (globosExplotados != numGlobosVictoria)){
    
           estado = 6;
           globosExplotados = 0;
           globosEliminados = 0;
           vaciarBalasyGlobos();
    
  } 
  
}

// Procedimiento que muestra el nivel al que avanzamos
void textoNivel(int nivel){
               
    push();
    textSize(width/20);
    fill(255, 255, 0);
    textAlign(CENTER);
    text("NIVEL", width/2 - 40, height/2);
    text(nivel, width/2 + 100, height/2);
    pop();
}

// Procedimiento que muestra el texto game over cuando perdemos
void textoGameOver(){
    
  
    push();
    textAlign(CENTER);
    textSize(height/20);
    text("GAME OVER", width/2, height/2);
    textSize(height/20);
    textSize(height/30);
    text("Press any key", width/2, height/2 + height/4);
    pop();
  
}

// Procedimiento que muestra la informacion de la partida en cada nivel
void informacionPartida(){
  
  
   push();
   fill(0);
   textAlign(CENTER);
   textSize(height/40);
   text("Globos explotados ", width-150, 70);
   text(globosExplotados,width-40, 70);
   text("Nivel ", width-88, 40);
   text(nivel, width-40, 40);
   pop();
    
}

// Procedimiento que muestra el texto cuando se gana el juego
void textoWinner(){
  
    push();
    textAlign(CENTER);
    textSize(height/20);
    text("LUCKY WIN", width/2, height/2);
    textSize(height/20);
    textSize(height/30);
    text("Press any key to restart", width/2, height/2 + height/4);
    pop();
  
  
}
