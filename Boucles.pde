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

  void capturer() {
    if (curseur < 50) {
      images[curseur].copy(cam, 0, 0, width, height, 0, 0, width, height);
      curseur += 1;
    } 
    /*if (curseur == 49) {
      effacer();
    }*/
  }

  void jouer() {
    if (compteur < curseur) {
      if (frameCount % vit == 0) {
        compteur++;
      }
    }
    if (compteur == curseur) {
      compteur = 0;
    }
    //delay(vitesse);
    image(images[compteur], 0, 0);
  }

  void effacer() {
    curseur = 0;
    compteur = 0;
  }

  int idid() {
    return (identifiant + 1) * 10;
  }
}