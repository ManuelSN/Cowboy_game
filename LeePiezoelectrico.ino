int valor;

void setup(){

  // Metodo estatico (no hace falta crear objeto) de la clase serial 
  // Inicializa velocidad del puerto serie en baudios (puerto serie virtual creado con rutina software, igual que puerto COM en un PC)
  Serial.begin(9600);
  while(!Serial); // Mientras no haya conexion correcta no entra al bucle infinito
  
  
}

void loop(){

  // Las entradas analogicas de arduino son de 10 bits, por lo que 
  // dividiremos el valor obtenido para que quepa en 1 byte
  valor = analogRead(A0);
  Serial.println(valor/5);
  Serial.write(valor/5);
  delay(100);
  
}
