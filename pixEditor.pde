// import processing.video.*;

/* Déclaration des variables --- Début */

// Capture cam;

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

boolean infos = false; // Affichage de la fenêtre des informations qui est fermée par défaut, donc 'false'
boolean histogrammes = false; // Affichage de la fenêtre des histogrammes qui est fermée par défaut, donc 'false'
boolean contraste = false; // Affichage de la fenêtre du contraste qui est fermée par défaut, donc 'false'
boolean symmetry_e = false; // Savoir si l'image est retournée, ce qui n'est pas le cas par défaut, donc 'false'
boolean rgb_e = false; // Affichage de la fenêtre des composantes RGB qui est fermée par défaut, donc 'false'
boolean bw = false; // Affichage de la fenêtre des l'image noire et blanche qui est fermée par défaut, donc 'false'
boolean rgb_gris = false; // Affichage de la fenêtre des l'image noire et blanche qui est fermée par défaut, donc 'false'

boolean capture = false;

/* Déclaration des variables --- Fin */


void setup() { // setup() : Code qui ne s'exécute qu'une seule fois
  size(1280, 680); // Taille de la fenêtre
  background(51); // Fond en gris 51
  loadIcons(); // Chargement des icônes

  img = createImage(width-height/20 * 4, height - height/20 * 3, RGB); // Création de l'image principale, de la taille maximale à laquelle une image pourra être affichée
  img_edit = createImage(0, 0, RGB); // Création de l'image allant être éditée, qui n'existe pas au début (mais qui existera après, à notre plus grand plaisir)

  for (int i = 0; i < img.width * img.height; i++) { // On boucle autant de fois qu'il y a de pixels dans l'image 'img'
    img.pixels[i] = color(255); // On définit ces pixels en blanc (esthétique)
  }

  width_c = width-height/20 * 4; // Largeur du 'plan de travail'
  height_c = height - height/20 * 4; // Hauteur du 'plan de travail'
}



void draw() { // draw() : Code qui s'éxécute en boucle
  drawCanvas(); // On dessine toute la fenêtre (voir 'Canvas.pde')

  if (keyPressed) {
    if (bw) {
      if (key == '-') {
        coeff_bw -= 0.01;
      }

      if (key == '+') {
        coeff_bw += 0.01;
      }
    }

    if (contraste) {
      if (key == '-') {
        coeff_contraste -= 0.1;
      }

      if (key == '+') {
        coeff_contraste += 0.1;
      }
    }
  }
}



void mousePressed() { // mousePressed() : Déclenché si l'utilisateur clique avec sa souris

  if (mouseX > 2 && mouseX < folder.width + 2 && mouseY < folder.height) { // Si l'utilisateur clique sur l'icône du fichier pour importer une image
    println("Ouverture de fichier : " + millis() + " ms"); // Information système pour un éventuel débugging
    selectInput("Sélectionnez votre image", "selectionImage"); // Ouverture de la fenêtre de séléction de fichier, méthode de retour étant selectionImage(fichier), voir 'selectionImage.pde'
  }


  if (mouseX > folder.width + 5 && mouseX < folder.width + save.width + 7 && mouseY < save.height) { // Si l'utilisateur clique sur l'icône de sauvegarde pour sauvegarder une image
    println("Enregistrement : " + millis() + " ms"); // Information système pour un éventuel débugging

    selectOutput("Choisissez où enregistrer votre image", "saveImage");
  }


  if (mouseX > folder.width + save.width + 10 && mouseX < folder.width + save.width + info.width + 14 && mouseY < info.height) {
    println("Infos : " + millis() + " ms"); // Information système pour un éventuel débugging
    infos = !infos; // La variable infos est inversée (true -> false ou false -> true)
  }


  if (mouseX > folder.width + save.width + info.width + 15 && mouseX < folder.width + save.width + info.width + reset.width + 21 && mouseY < reset.height) { // Si l'utilisateur clique sur l'icône de réinitialisation pour réinitialiser l'image
    println("Reset : " + millis() + " ms"); // Information système pour un éventuel débugging
    resetImage(img_edit); // On réinitialise l'image à éditer, 'img_edit', voir 'resetImage.pde'
  }


  if (mouseX > width-height/20*2 + 20 && mouseX < width-height/20*2 + 20 + chart.width && mouseY > height/20 && mouseY < height/20 + chart.height + 7) { // Si l'utilisateur clique sur l'icône des histogrammes
    println("Histogrammes : " + millis() + " ms"); // Information système pour un éventuel débugging
    histogrammes = !histogrammes; // La variable histogrammes est inversée (true -> false ou false -> true)
  }


  if (mouseX > width-height/20*2 + 20 && mouseX < width-height/20*2 + 20 + contrast.width && mouseY > height/20 * 2 && mouseY < height/20 + chart.height + contrast.height + 7) { // Si l'utilisateur clique sur l'icône de contraste
    println("Contraste : " + millis() + " ms"); // Information système pour un éventuel débugging
    contraste = !contraste; // La variable contraste est inversée (true -> false ou false -> true)
  }


  if (contraste) { // Si la variable contraste est vraie, ce qui revient à vérifier si la fenêtre de contraste est ouverte
    if (mouseX > 5*width/6 + width/11 && mouseX < 5*width/6 + width/11 + plus.width && mouseY > height/20 * 3 && mouseY < height/20 * 3 + plus.height) { // Si l'utilisateur appuie sur le bouton '+' de la fenêtre de contraste
      coeff_contraste += 0.1; // On augmente le coefficient de contraste ('coeff_contraste') de 0.1
    }
    if (mouseX > 5*width/6 + width/68 && mouseX < 5*width/6 + width/68 + minus.width && mouseY > height/20 * 3 && mouseY < height/20 * 3 + minus.height) { // Si l'utilisateur appuie sur le bouton '-' de la fenêtre de contraste
      coeff_contraste -= 0.1; // On diminue le coefficient de contraste ('coeff_contraste') de 0.1
    }
  }


  if (mouseX > width-height/20*2 + 20 && mouseX < width-height/20*2 + 20 + symmetry.width && mouseY > height/20 * 3 && mouseY < height/20 + chart.height + contrast.height + symmetry.height + 7) { // Si l'utilisateur clique sur l'icône de symétrie
    println("Symétrie : " + millis() + " ms"); // Information système pour un éventuel débugging
    reverseImage(img_edit); // On retourne l'image (voir 'reverseImage.pde')
    symmetry_e = !symmetry_e; // La variable symmetry_e est inversée (true -> false ou false -> true)
  }


  if (mouseX > width-height/20*2 + 20 && mouseX < width-height/20*2 + 20 + symmetry.width && mouseY > height/20 * 4 + 14 && mouseY < height/20 + chart.height + contrast.height + symmetry.height + rgb.height + 14) { // Si l'utilisateur clique sur l'icône de composantes RGB
    println("RGB : " + millis() + " ms"); // Information système pour un éventuel débugging
    rgb_e = !rgb_e; // La variable rgb_e est inversée (true -> false ou false -> true)
  }


  if (rgb_e) { // Si la variable rgb_e est vraie, ce qui revient à vérifier si la fenêtre des composantes RGB est ouverte
    if (mouseX > 5*width/6 + width/68 && mouseX < 5*width/6 + width/68 + minus.width && mouseY > height/20 * 5 && mouseY < height/20 * 5 + minus.height ) { // Si l'utilisateur appuie sur le bouton '-' de la fenêtre de composante Rouge
      coeff_r -= 0.05; // On diminue le coefficient de rouge de 0.05
    }
    if (mouseX > 5*width/6 + width/11 && mouseX < 5*width/6 + width/11 + minus.width && mouseY > height/20 * 5 && mouseY < height/20 * 5 + plus.height ) { // Si l'utilisateur appuie sur le bouton '+' de la fenêtre de composante Rouge
      coeff_r += 0.05; // On augmente le coefficient de rouge de 0.05
    }

    if (mouseX > 5*width/6 + width/68 && mouseX < 5*width/6 + width/68 + minus.width && mouseY > height/20 * 6.5 && mouseY < height/20 * 6.5 + minus.height ) { // Si l'utilisateur appuie sur le bouton '-' de la fenêtre de composante Verte
      coeff_g -= 0.05; // On diminue le coefficient de vert de 0.05
    }
    if (mouseX > 5*width/6 + width/11 && mouseX < 5*width/6 + width/11 + minus.width && mouseY > height/20 * 6.5 && mouseY < height/20 * 6.5 + plus.height ) { // Si l'utilisateur appuie sur le bouton '+' de la fenêtre de composante Verte
      coeff_g += 0.05; // On augmente le coefficient de vert de 0.05
    }

    if (mouseX > 5*width/6 + width/68 && mouseX < 5*width/6 + width/68 + minus.width && mouseY > height/20 * 8 && mouseY < height/20 * 8 + minus.height ) { // Si l'utilisateur appuie sur le bouton '-' de la fenêtre de composante Bleue
      coeff_b -= 0.05; // On diminue le coefficient de bleu de 0.05
    }
    if (mouseX > 5*width/6 + width/11 && mouseX < 5*width/6 + width/11 + minus.width && mouseY > height/20 * 8 && mouseY < height/20 * 8 + plus.height ) { // Si l'utilisateur appuie sur le bouton '+' de la fenêtre de composante Bleue
      coeff_b += 0.05; // On augmente le coefficient de bleu de 0.05
    }
  }


  if (mouseX > width-height/20*2 + 20 && mouseX < width-height/20*2 + 20 + symmetry.width && mouseY > height/20 * 5 + 21 && mouseY < height/20 + chart.height + contrast.height + symmetry.height + rgb.height + noir_blanc.height + 21) { // Si l'utilisateur clique sur l'icône de noir et blanc
    println("Noir et Blanc : " + millis() + " ms"); // Information système pour un éventuel débugging
    bw = !bw; // La variable bw est inversée (true -> false ou false -> true)
  }

  if (bw) { // Si la fen^être de noir et blanc est ouverte
    if (mouseX > 5*width/6 + width/68 && mouseX < 5*width/6 + width/68 + minus.width && mouseY > height/20 * 6 && mouseY < height/20 * 6 + minus.height ) { // Si l'utilisateur appuie sur le bouton '-' de la fenêtre de noir et blanc
      coeff_bw -= 0.01; // On diminue le coefficient de noir et blanc de 0.01
    }
    if (mouseX > 5*width/6 + width/11 && mouseX < 5*width/6 + width/11 + minus.width && mouseY > height/20 * 6 && mouseY < height/20 * 6 + plus.height ) { // Si l'utilisateur appuie sur le bouton '+' de la fenêtre de noir et blanc
      coeff_bw += 0.01; // On augmente le coefficient de noir et blanc de 0.01
    }
  }

  if (mouseX > width-height/20*2 + 20 && mouseX < width-height/20*2 + 20 + symmetry.width && mouseY > height/20 * 6 + 14 && mouseY < height/20 + chart.height + contrast.height + symmetry.height + rgb.height + noir_blanc.height + gris.height + 14) { // Si l'utilisateur clique sur l'icône de composantes RGB
    println("RGB gris : " + millis() + " ms"); // Information système pour un éventuel débugging
    rgb_gris = !rgb_gris; // La variable rgb_gris est inversée (true -> false ou false -> true)
  }


  if (rgb_gris) { // Si la variable rgb_gris est vraie, ce qui revient à vérifier si la fenêtre des composantes RGB grisées est ouverte
    if (mouseX > 5*width/6 + width/68 && mouseX < 5*width/6 + width/68 + minus.width && mouseY > height/20 * 9 && mouseY < height/20 * 9 + minus.height ) { // Si l'utilisateur appuie sur le bouton '-' de la fenêtre de composante Rouge
      coeffr_g -= 0.05; // On diminue le coefficient de rouge de 0.05
    }
    if (mouseX > 5*width/6 + width/11 && mouseX < 5*width/6 + width/11 + minus.width && mouseY > height/20 * 9 && mouseY < height/20 * 9 + plus.height ) { // Si l'utilisateur appuie sur le bouton '+' de la fenêtre de composante Rouge
      coeffr_g += 0.05; // On augmente le coefficient de rouge de 0.05
    }

    if (mouseX > 5*width/6 + width/68 && mouseX < 5*width/6 + width/68 + minus.width && mouseY > height/20 * 10.5 && mouseY < height/20 * 10.5 + minus.height ) { // Si l'utilisateur appuie sur le bouton '-' de la fenêtre de composante Verte
      coeffg_g -= 0.05; // On diminue le coefficient de vert de 0.05
    }
    if (mouseX > 5*width/6 + width/11 && mouseX < 5*width/6 + width/11 + minus.width && mouseY > height/20 * 10.5 && mouseY < height/20 * 10.5 + plus.height ) { // Si l'utilisateur appuie sur le bouton '+' de la fenêtre de composante Verte
      coeffg_g += 0.05; // On augmente le coefficient de vert de 0.05
    }

    if (mouseX > 5*width/6 + width/68 && mouseX < 5*width/6 + width/68 + minus.width && mouseY > height/20 * 12 && mouseY < height/20 * 12 + minus.height ) { // Si l'utilisateur appuie sur le bouton '-' de la fenêtre de composante Bleue
      coeffb_g -= 0.05; // On diminue le coefficient de bleu de 0.05
    }
    if (mouseX > 5*width/6 + width/11 && mouseX < 5*width/6 + width/11 + minus.width && mouseY > height/20 * 12 && mouseY < height/20 * 12 + plus.height ) { // Si l'utilisateur appuie sur le bouton '+' de la fenêtre de composante Bleue
      coeffb_g += 0.05; // On augmente le coefficient de bleu de 0.05
    }
  }
}