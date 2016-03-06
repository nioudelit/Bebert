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
    if(curseur < 50){
      images[curseur].copy(cam, 0, 0, width, height, 0, 0, width, height);
      //capturerT();
      curseur += 1;
    }
  }
  
  void capturerT(){
    images[curseur].save(identifiant + str(curseur) + "souris.jpg");
  }
  
  void jouerT(){
    if(compteur < curseur){
      compteur++;
    }
    if (compteur == curseur) {
      compteur = 0;
    }
    delay(vitesse);
    //image(str(identifiant) + compteur + "souris.jpg", 0, 0);
  }

  void jouer() {
    if(compteur < curseur){
      compteur++;
    }
    if (compteur == curseur) {
      compteur = 0;
    }
    delay(vitesse);
    image(images[compteur], 0, 0);
  }

  void effacer() {
    curseur = 0;
    compteur = 0;
  }
}