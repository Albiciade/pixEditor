/* Déclaration des variables --- Début */

PImage img; // Image importée par l'utilisateur
PImage img_v; // Image importée vierge
PImage img_edit; // Image éditée (taille adaptée)
PImage img_edit_v; // Image éditée vierge (sans changement de couleurs)
PImage img_edit_vs; // Image éditée retournée, référence pour la symétrie
String img_name = "Image par défaut"; // Nom de l'image importée, par défaut 'Image par défaut'


float width_c; // Largeur du 'plan de travail' pour ajuster la taille de l'image importée
float height_c; // Hauteur du 'plan de travail' pour ajuster la taille de l'image importée
float coeff_contraste = 1; // Coefficient pour le contraste de l'image
float coeff_r = 1; // Coefficient pour la composante rouge
float coeff_g = 1; // Coefficient pour la composante verte
float coeff_b = 1; // Coefficient pour la composante bleue
float coeff_bw = 0.3; // Coefficient 'noir et blanc' (gris) pour l'image en noir et blanc
float coeffr_g = 1;
float coeffg_g = 1;
float coeffb_g = 1;

Slider[] slidersRVB = new Slider[3];
Slider[] slidersRVBG = new Slider[3];

int cr = 0; // Composante rouge, cr
int cg = 0; // Composante verte, cg
int cb = 0; // Composante bleue, cb
int alpha = 60;
int tpinceau = 1; // Taille du pinceau
color c;
boolean infos = false; // Affichage de la fenêtre des informations qui est fermée par défaut, donc 'false'
boolean histogrammes = false; // Affichage de la fenêtre des histogrammes qui est fermée par défaut, donc 'false'
boolean contraste = false; // Affichage de la fenêtre du contraste qui est fermée par défaut, donc 'false'
boolean symmetry_e = false; // Savoir si l'image est retournée, ce qui n'est pas le cas par défaut, donc 'false'
boolean rgb_e = false; // Affichage de la fenêtre des composantes RGB qui est fermée par défaut, donc 'false'
boolean bw = false; // Affichage de la fenêtre des l'image noire et blanche qui est fermée par défaut, donc 'false'
boolean rgb_gris = false; // Affichage de la fenêtre des l'image noire et blanche qui est fermée par défaut, donc 'false'
boolean pinceau = false; 
boolean rubber = false;
boolean picker = false;
boolean flou = false;

boolean capture = false;
float taille, l_droit;

float mCr;
float mCg;
float mCb;

int bTime;
boolean bOn;
String[] keys;
String myText = "Clé";
boolean val = false;
boolean ent = false;

String appData = System.getenv("AppData") + "\\";
String path = appData + "pixEditor\\activation.txt";

boolean activation = false;

String[] isAct;
int oui;

File f = new File(path);

/* Déclaration des variables --- Fin */

void setup() { // setup() : Code qui ne s'exécute qu'une seule fois

  if (!f.exists()) {
    String[] zero = {"0"};
    saveStrings(path, zero);
  }

  isAct = loadStrings(path);
  oui = int(isAct[0]);

  surface.setSize(int(displayWidth*0.8), int(displayHeight*0.8)); // Taille de la fenêtre
  surface.setResizable(true);
  background(51); // Fond en gris 51
  frameRate(200);
  loadIcons(); // Chargement des icônes

  img = createImage(width-height/20 * 4, height - height/20 * 3, RGB); // Création de l'image principale, de la taille maximale à laquelle une image pourra être affichée
  img_edit = createImage(img.width, img.height, ARGB); // Création de l'image allant être éditée, qui n'existe pas au début (mais qui existera après, à notre plus grand plaisir)
  img_edit_v = createImage(img.width, img.height, ARGB);

  for (int i = 0; i < img.width * img.height; i++) { // On boucle autant de fois qu'il y a de pixels dans l'image 'img'
    img.pixels[i] = color(255); // On définit ces pixels en blanc
    img_edit.pixels[i] = color(255);
    img_edit_v.pixels[i] = color(255);
  }

  img.updatePixels();
  img_edit.updatePixels();

  width_c = width-height/20 * 4; // Largeur du 'plan de travail'
  height_c = height - height/20 * 4; // Hauteur du 'plan de travail'

  taille = height/20;
  l_droit = width-taille*2;

  for (int i = 0; i < slidersRVB.length; i++) {
    slidersRVB[i] = new Slider(5*width/6 + width/68, taille * 5.5 + i* taille);
    slidersRVB[i].setLength(int(l_droit/10));
    slidersRVB[i].setRange(0, 2);
    slidersRVB[i].setDefaultValue(1);

    slidersRVBG[i] = new Slider(5*width/6 + width/68, taille * 8 + i*taille);
    slidersRVBG[i].setLength(int(l_droit/10));
    slidersRVBG[i].setRange(0, 2);
    slidersRVBG[i].setDefaultValue(1);
  }

  bTime = millis();
  bOn = true;
  smooth();
  loadIcons();
  drawCanvas();
}



void draw() { // draw() : Code qui s'éxécute en boucle
  if (oui == 1) {
    drawCanvas();
    // --------------------------------------- [ TOUCHE SOURIS CONTINUE ] ---------------------------------------
    if (mousePressed) {
      mCr = map(cr, 0, 255, 0, taille*6);
      mCg = map(cg, 0, 255, 0, taille*6);
      mCb = map(cb, 0, 255, 0, taille*6);

      // ------------------------[ CURSEURS SELECTION DE COULEUR RGB ]------------------------

      if (mouseX > taille*11 && mouseY > taille/4 && mouseY < taille/1.2) {
        if (mouseX < taille*11+taille*6) {
          cr = int(mouseX-taille*11);
          cr = constrain(cr, 0, 255);
        } else if (mouseX > taille*19 && mouseX < taille*19+taille*6) {
          cg = int(mouseX-taille*19);
          cg = constrain(cg, 0, 255);
        } else if (mouseX > taille*27 && mouseX < taille*27+taille*6) {
          cb = int(mouseX-taille*27);
          cb = constrain(cb, 0, 255);
        }
      }

      // ------------------------[ BOUTONS SELECTION TAILLE DU PINCEAU ]------------------------

      if (mouseX > taille*7 && mouseX < taille*7 + taille/1.5 && mouseY > taille/4 && mouseY < taille/4 + taille/1.5) {
        tpinceau -= 1;
      }

      if (mouseX > taille*8 && mouseX < taille*8.5 + taille/1.5 && mouseY > taille/4 && mouseY < taille/4 + taille/1.5) {
        tpinceau += 1;
      }

      tpinceau = constrain(tpinceau, 1, 200);

      // ------------------------[ OUTIL PINCEAU DANS PLAN DE TRAVAIL ]------------------------

      if (mouseY > height/18 && mouseX < l_droit) {
        c = color(cr, cg, cb);
        fill(c);
        noStroke();
        int x = int(mouseX - taille);
        int y = int(mouseY - taille * 2);

        /* if (flou) {
         
         for (float a = 0; a < TWO_PI; a+= 0.02) {
         for (int i = 0; i < tpinceau; i++) {
         float cx = cos(a) * i + x;
         float cy = sin(a) * i + y;
         color cPixel = get(int(cx), int(cy));
         flouRouge = (int[]) append(flouRouge, int(red(cPixel)));
         flouBleu = (int[]) append(flouBleu, int(blue(cPixel)));
         flouVert = (int[]) append(flouVert, int(green(cPixel)));
         }
         }
         
         for (int i = 0; i < flouRouge.length; i++) {
         flouRougeMoy += flouRouge[i];
         flouBleuMoy += flouBleu[i];
         flouVertMoy += flouVert[i];
         }
         
         flouRougeMoy /= flouRouge.length;
         flouBleuMoy /= flouBleu.length;
         flouVertMoy /= flouVert.length;
         
         c = color(flouRougeMoy, flouBleuMoy, flouVertMoy, 60);
         cr = flouRougeMoy;
         cb = flouBleuMoy;
         cg = flouVertMoy;
         } */
         
             /* if (correcteur) {
         
         for (float a = 0; a < TWO_PI; a+= 0.02) {
         float cx = cos(a) * (tpinceau+1) + x;
         float cy = sin(a) * (tpinceau+1) + y;
         color cPixel = get(int(cx), int(cy));
         corRouge = (int[]) append(corRouge, int(red(cPixel)));
         corBleu = (int[]) append(corBleu, int(blue(cPixel)));
         corVert = (int[]) append(corVert, int(green(cPixel)));
         
         }
         
         for (int i = 0; i < corRouge.length; i++) {
         corRougeMoy += corRouge[i];
         corBleuMoy += corBleu[i];
         corVertMoy += corVert[i];
         }
         
         corRougeMoy /= corRouge.length;
         corBleuMoy /= corBleu.length;
         corVertMoy /= corVert.length;
         
         c = color(corRougeMoy, corBleuMoy, corVertMoy, 40);
         cr = corRougeMoy;
         cb = corBleuMoy;
         cg = corVertMoy;
         } */


        if (pinceau) {
          for (float a = 0; a < TWO_PI; a+= 0.02) {
            for (int i = 0; i < tpinceau; i++) {
              float cx = cos(a) * i + x;
              float cy = sin(a) * i + y;
              img_edit.set(int(cx), int(cy), c);
            }
          }
        }

        if (rubber) {
          for (float a = 0; a < TWO_PI; a+= 0.02) {
            for (int i = 0; i < tpinceau; i++) {
              float cx = cos(a) * i + x;
              float cy = sin(a) * i + y;
              color cPixel = img_edit_v.get(int(cx), int(cy));
              img_edit.set(int(cx), int(cy), cPixel);
            }
          }
        }

        if (picker) {
          color cPicker = get(mouseX, mouseY);
          cr = int(red(cPicker));
          cg = int(green(cPicker));
          cb = int(blue(cPicker));
        }

        /* for (int i = 1; i <= tpinceau*2; i++) {
         for (int j = 1; j <= tpinceau*2; j++) {
         img_edit.set(x-tpinceau+i, y-tpinceau+j, c);
         }
         } */

        img_edit.updatePixels();
      }
    }

    if (mouseY > height/18 && mouseX < l_droit) {
      if (pinceau || rubber || flou) {
        noFill();
        strokeWeight(4);
        stroke(152);
        ellipse(mouseX, mouseY, tpinceau * 2, tpinceau * 2);
        strokeWeight(1);
        stroke(c);
        fill(c);
      }
    }

    // --------------------------------------- [ TOUCHE CLAVIER CONTINUE] ---------------------------------------

    if (keyPressed) {

      // ------------------------[ NOIR ET BLANC ]------------------------    
      if (bw) {
        if (key == '-') {
          coeff_bw -= 0.01;
          img_edit = updateNB(img_edit);
        }

        if (key == '+') {
          coeff_bw += 0.01;
          img_edit = updateNB(img_edit);
        }
      }

      // ------------------------[ CONTRASTE ]------------------------    

      if (contraste) {
        if (key == '-') {
          coeff_contraste -= 0.1;
          img_edit = updateContrast(img_edit);
        }

        if (key == '+') {
          coeff_contraste += 0.1;
          img_edit = updateContrast(img_edit);
        }
      }

      if (pinceau || rubber ||flou) {
        if (key == '-') {
          tpinceau -= 1;
        }

        if (key == '+') {
          tpinceau += 1;
        }
      }


      tpinceau = constrain(tpinceau, 1, 200);
    }
  } else {
    activation();
  }
}

void mousePressed() { // mousePressed() : Déclenché si l'utilisateur clique avec sa souris
  for (int i = 0; i < iconsh.length; i++) {
    if (mouseX > iconsh[i].x && mouseX < iconsh[i].x + iconsh[i].t && mouseY < iconsh[i].t) { // Si l'utilisateur clique sur l'icône du fichier pour importer une image
      iconsh[i].executeAction();
    }
  }

  for (int i = 0; i < iconsv.length; i++) {
    if (mouseX > iconsv[i].x && mouseX < iconsv[i].x + iconsv[i].t && mouseY > iconsv[i].y && mouseY < iconsv[i].y + iconsv[i].t) {
      iconsv[i].executeAction();
    }
  }


  if (contraste) { // Si la variable contraste est vraie, ce qui revient à vérifier si la fenêtre de contraste est ouverte
    if (mouseX > 5*width/6 + width/11 && mouseX < 5*width/6 + width/11 + plus.width && mouseY > height/20 * 3 && mouseY < height/20 * 3 + plus.height) { // Si l'utilisateur appuie sur le bouton '+' de la fenêtre de contraste
      coeff_contraste += 0.05; // On augmente le coefficient de contraste ('coeff_contraste') de 0.1
      img_edit = updateContrast(img_edit);
    }
    if (mouseX > 5*width/6 + width/68 && mouseX < 5*width/6 + width/68 + minus.width && mouseY > height/20 * 3 && mouseY < height/20 * 3 + minus.height) { // Si l'utilisateur appuie sur le bouton '-' de la fenêtre de contraste
      coeff_contraste -= 0.05; // On diminue le coefficient de contraste ('coeff_contraste') de 0.1
      img_edit = updateContrast(img_edit);
    }
  }

  if (bw) { // Si la fenêtre de noir et blanc est ouverte
    if (mouseX > 5*width/6 + width/68 && mouseX < 5*width/6 + width/68 + minus.width && mouseY > height/20 * 6 && mouseY < height/20 * 6 + minus.height ) { // Si l'utilisateur appuie sur le bouton '-' de la fenêtre de noir et blanc
      coeff_bw -= 0.01; // On diminue le coefficient de noir et blanc de 0.01
      img_edit = updateNB(img_edit);
    }
    if (mouseX > 5*width/6 + width/11 && mouseX < 5*width/6 + width/11 + minus.width && mouseY > height/20 * 6 && mouseY < height/20 * 6 + plus.height ) { // Si l'utilisateur appuie sur le bouton '+' de la fenêtre de noir et blanc
      coeff_bw += 0.01; // On augmente le coefficient de noir et blanc de 0.01
      img_edit = updateNB(img_edit);
    }
  }
}  

void mouseDragged() {
  for (int i = 0; i < slidersRVB.length; i++) {
    if (mouseX > slidersRVB[i].x && mouseX < slidersRVB[i].x + slidersRVB[i].len && mouseY > slidersRVB[i].y - 25/2 && mouseY < slidersRVB[i].y + 25/2) {   
      if (slidersRVB[i].isDisplayed) {
        slidersRVB[i].setCursorPos(mouseX);
      }
    }
    if (mouseX > slidersRVBG[i].x && mouseX < slidersRVBG[i].x + slidersRVBG[i].len && mouseY > slidersRVBG[i].y - 25/2 && mouseY < slidersRVBG[i].y + 25/2) {   
      if (slidersRVBG[i].isDisplayed) {
        slidersRVBG[i].setCursorPos(mouseX);
      }
    }
  }
}