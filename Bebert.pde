//A FAIRE: 
//1) Portée de effets.
//2) Ergonomie, interface graphique avec Arduino

import processing.video.*;
Capture cam;
PrintWriter periph;
String[] lignes;

//EFFETS **************************
PShader hsb;
float ptdr = 0.5;
float bri = 1;
//ACTIVATION EFFETS
boolean seuil = true;
boolean sh = false;
float[] parametres = new float[2];

//BOUCLES *************************
int boucleCourante;
boolean[] bcl = new boolean[3];
Calque[] boucles = new Calque[3];
int vitesse;
int vit = 1;

//FOND
PImage fond;

void setup() {
  fullScreen(P2D); //size(640, 480, P2D);
  String[] cameras = Capture.list();
  
  lignes = loadStrings("config.txt");
  int config = int(lignes[0]);
  periph = createWriter("peripheriques.txt");
  for(int i = 0; i < cameras.length; i++){
    periph.println(i + " " + cameras[i]);
  }
  periph.flush();
  periph.close();
  
  cam = new Capture(this, cameras[config]);
  cam.start();
  for (int i = 0; i < boucles.length; i++) {
    boucles[i] = new Calque(i);
  }
  hsb = loadShader("traitement.glsl");
  fond = createImage(width, height, ARGB);
  background(0);
}

void draw() {
  //FOND
  resetShader();
  image(fond, 0, 0);
  //FLUX
  hsb.set("brightness", bri);
  hsb.set("saturation", parametres[0]);
  hsb.set("contrast", parametres[1]);
  if (sh) { 
    shader(hsb);
  }
  for (int i = 0; i < 3; i++) {
    if (bcl[i]) {
      /*if (frameCount % boucles[i].idid() == 0) {
        boucles[i].capturer();
      }*/
      boucles[i].jouer();
    }
  }
  image(cam, 0, 0, width, height);
  println(frameRate);
}