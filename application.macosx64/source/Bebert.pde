//1) soustraction vert flux
//2) choix fond (video / image)
//3) Photographie : capture img et print

import processing.video.*;
Capture cam;
Movie[] clip = new Movie[1];
int indexClip;

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

//IMG FOND
PImage[] imgFond = new PImage[4];
int fCurseur;

//FOND
PImage fond;
////

void setup() {
  fullScreen(P2D); //size(640, 480, P2D);
  String[] cameras = Capture.list();
  cam = new Capture(this, cameras[12]);
  cam.start();
  for (int i = 0; i < clip.length; i++) {
    clip[i] = new Movie(this, "souris" + i + ".mov");
    clip[i].loop();
  }
  for(int i = 0; i < imgFond.length; i++){
    imgFond[i] = loadImage("souris" + i + ".jpg");
  }
  for (int i = 0; i < boucles.length; i++) {
    boucles[i] = new Calque(i);
  }
  hsb = loadShader("brcosa.glsl");
  background(0);
  fond = createImage(width, height, ARGB);
  frameRate(30);
}

void draw() {
  //FOND
  resetShader();
  image(clip[indexClip], 0, 0, width, height);
  //image(imgFond[fCurseur], 0, 0, width, height);
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
      boucles[i].jouer();
    }
  }
  image(cam, 0, 0, width, height);
  println(frameRate);
}