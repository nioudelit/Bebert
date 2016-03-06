void mouseReleased() {
  if (seuil) {
    parametres[0] = map(mouseY, 0, height, 0, 5);
    parametres[1] = map(mouseX, 0, width, 0, 5);
  }
}

void keyReleased() {
  if (key == ' ') {
    seuil =! seuil;
  }
  if (key == 'b') {
    bri+=0.1;
  }
  if (key == 'n') {
    bri-=0.1;
  }
  if (key == 'c') {
    parametres[0] = 0;
    parametres[1] = 0;
    bri = 1.0;
  }
  if (key == 's' || key =='S') {
    sh =! sh;
  }
  if (keyCode == UP) {
    seuil = true;
    ptdr+=0.05;
    hsb.set("ptdr", constrain(ptdr, 0.0, 1.0));
  }
  if (keyCode == DOWN) {
    seuil = true;
    ptdr-=0.05;
    hsb.set("ptdr", constrain(ptdr, 0.0, 1.0));
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

void keyPressed() {
  if (key == 'i') {
    vitesse+=10;
  }
  if (key == 'k') {
    if (vitesse >= 10) {
      vitesse -=10;
    }
  }
}

void captureEvent(Capture c) {
  c.read();
}

void movieEvent(Movie m) {
  m.read();
}