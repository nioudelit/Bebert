import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Bebert extends PApplet {

//1) soustraction vert flux
//2) choix fond (video / image)
//3) Photographie : capture img et print


Capture cam;
Movie[] clip = new Movie[1];
int indexClip;

//EFFETS **************************
PShader hsb;
float ptdr = 0.5f;
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

public void setup() {
   //size(640, 480, P2D);
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

public void draw() {
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
class Calque {
  PImage images[] = new PImage[50];
  int curseur, compteur;
  int identifiant;

  Calque(int id) {
    id = identifiant;
    for (int i = 0; i < images.length; i++) {
      images[i] = createImage(width, height, ARGB);
    }
  }

  public void capturer() {
    if(curseur < 50){
      images[curseur].copy(cam, 0, 0, width, height, 0, 0, width, height);
      //capturerT();
      curseur += 1;
    }
  }
  
  public void capturerT(){
    images[curseur].save(identifiant + str(curseur) + "souris.jpg");
  }
  
  public void jouerT(){
    if(compteur < curseur){
      compteur++;
    }
    if (compteur == curseur) {
      compteur = 0;
    }
    delay(vitesse);
    //image(str(identifiant) + compteur + "souris.jpg", 0, 0);
  }

  public void jouer() {
    if(compteur < curseur){
      compteur++;
    }
    if (compteur == curseur) {
      compteur = 0;
    }
    delay(vitesse);
    image(images[compteur], 0, 0);
  }

  public void effacer() {
    curseur = 0;
    compteur = 0;
  }
}
public void mouseReleased() {
  if (seuil) {
    parametres[0] = map(mouseY, 0, height, 0, 5);
    parametres[1] = map(mouseX, 0, width, 0, 5);
  }
}

public void keyReleased() {
  if (key == ' ') {
    seuil =! seuil;
  }
  if (key == 'b') {
    bri+=0.1f;
  }
  if (key == 'n') {
    bri-=0.1f;
  }
  if (key == 'c') {
    parametres[0] = 0;
    parametres[1] = 0;
    bri = 1.0f;
  }
  if (key == 's' || key =='S') {
    sh =! sh;
  }
  if (keyCode == UP) {
    seuil = true;
    ptdr+=0.05f;
    hsb.set("ptdr", constrain(ptdr, 0.0f, 1.0f));
  }
  if (keyCode == DOWN) {
    seuil = true;
    ptdr-=0.05f;
    hsb.set("ptdr", constrain(ptdr, 0.0f, 1.0f));
  }
  if (keyCode == LEFT) {
    if (indexClip > 0 && indexClip <= clip.length-1) {
      indexClip--;
    }
  }
  if (keyCode == RIGHT) {
    if (indexClip >= 0 && indexClip < clip.length-1) {
      indexClip++;
    }
  }
  //BOUCLE 1
  if (key == 'a' || key =='z' || key =='q') {
    boucleCourante = 0;
    if (key == 'a') {
      boucles[boucleCourante].capturer();
    }
    if (key == 'z') {
      bcl[0] =! bcl[0];
    }
    if (key == 'q') {
      boucles[boucleCourante].effacer();
    }
  }

  if (key == 'e' || key =='r' || key =='d') {
    boucleCourante = 1;
    if (key == 'e') {
      boucles[boucleCourante].capturer();
    }
    if (key == 'r') {
      bcl[1] =! bcl[1];
    }
    if (key == 'd') {
      boucles[boucleCourante].effacer();
    }
  }

  if (key == 't' || key =='y' || key =='g') {
    boucleCourante = 2;
    if (key == 't') {
      boucles[boucleCourante].capturer();
    }
    if (key == 'y') {
      bcl[2] =! bcl[2];
    }
    if (key == 'g') {
      boucles[boucleCourante].effacer();
    }
  }
  if (key == '<') {
    resetShader();
    //imgFond[fCruseur].copy(cam, 0,
  }
  if (key == 'w') {
    //fCurseur = 0;
    fond.copy(cam, 0, 0, width, height, 0, 0, width, height);
  }
  if (key == 'x') {
    fCurseur = 1;
  }
  if (key == 'c') {
    fCurseur = 2;
  }
  if (key == 'v') {
    fCurseur = 3;
  }
}

public void keyPressed() {
  if (key == 'i') {
    vitesse+=10;
  }
  if (key == 'k') {
    if (vitesse >= 10) {
      vitesse -=10;
    }
  }
}

public void captureEvent(Capture c) {
  c.read();
}

public void movieEvent(Movie m) {
  m.read();
}
  public void settings() {  fullScreen(P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Bebert" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
