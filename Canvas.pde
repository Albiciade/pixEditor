void drawCanvas() { // Fonction pour dessiner la fenêtre et les images (basiquement tout)

  float taille = height/20; // La taille d'une icône est de la hauteur de la fenêtre divisée par 20
  float l_droit = width-taille*2; // La coordonnée x de la colonne à droite de l'écran est de la largeur de la fenêtre moins la taille fois deux

  folder.resize(int(taille), int(taille)); // On redimensionne toutes les icônes pour qu'elles fassent précisément la taille demandée (variable taille)
  save.resize(int(taille), int(taille)); // Idem
  info.resize(int(taille), int(taille)); // Idem
  chart.resize(int(taille), int(taille)); // Idem 
  contrast.resize(int(taille), int(taille)); // Idem
  plus.resize(int(taille), int(taille)); // Idem 
  minus.resize(int(taille), int(taille)); // Idem 
  symmetry.resize(int(taille), int(taille)); // Idem
  rgb.resize(int(taille), int(taille)); // Idem 
  noir_blanc.resize(int(taille), int(taille)); // Idem
  reset.resize(int(taille), int(taille)); // Idem
  gris.resize(int(taille), int(taille)); // Idem

  background(51); // Fond en gris 51

  stroke(255); // Couleur des lignes : blanche
  line(0, height/18, l_droit, height/18); // Ligne délimitant les icônes du reste du plan de travail
  line(l_droit, height/18, l_droit, height); // Ligne à droite de l'écran, séparant d'autres icônes

  for (int i = 0; i < iconsh.length; i++) {
    iconsh[i].display();
  }
  for (int i = 0; i < iconsv.length; i++) {
    iconsv[i].display();
  }


  pushMatrix(); // On 'sauvegarde' l'emplacement actuel avant des translate();
  translate(taille, 2* taille); // On se décale de la taille d'une icône en abscisse et de 2 icônes en ordonnée

  if (img_edit.width != 0) { // On vérifie si la largeur de l'image à éditer est différente de 0 (si l'image à éditer existe)
    if (contraste) { // Si la fenêtre de contraste est ouverte
      updateContrast(img_edit); // On met à jour le contraste, voir 'Contraste.pde'
    }
    if (rgb_e) { // Si la fenêtre des composantes RGB est ouverte
      updateRGB(img_edit); // On met à jour les composantes RGB, voir 'updateRGB.pde'
    }
    if (bw) { // Si la fenêtre du mode noir et blanc est ouverte
      updateNB(img_edit); // On met à jour les composantes noir / blanc, voir 'updateNB.pde'
    }

    if (rgb_gris) {
      updateGris(img_edit);
    }

    image(img_edit, 0, 0); // On affiche l'image éditée
  } else { // Sinon (si l'image à éditer n'existe pas)
    image(img, 0, 0); // On affiche l'image par défaut
  }
  popMatrix(); // On revient à l'état précédant les translate(), au moment du pushMatrix() ligne 60

  if (infos) { // Si la fenêtre des informations est ouverte
    noStroke(); // Pas de contour
    fill(91, 170, 183, 210); // Couleur bleue transparente
    textSize(13); // Taille du texte : 13
    rect(0, taille + 5, max(textWidth("Nom de l'image : " + img_name), textWidth("Taille (originale) : " + img.width + "x" + img.height + "px")) + 10, 6 * taille); // Rectangle de la fenêtre, avec la largeur adaptée à la taille du nom du fichier ou de la taille
    fill(0); // Couleur noire
    text("Nom de l'image : " + img_name, 5, taille + 25); // Affichage du nom de l'image
    text("Taille (originale) : " + img.width + "x" + img.height + "px", 5, taille + 45); // Affichage de sa taille originale
    text("Taille (adaptée) : " + img_edit.width + "x" + img_edit.height + "px", 5, taille + 65); // Affichage de sa tailel recadrée pour rentrer dans la fenêtre
    text("Coefficient de contraste : " + nf(coeff_contraste, 1, 1), 5, taille + 85); // Affichage du coefficient de contraste
    text("Coefficient R : " + nf(coeff_r, 1, 2), 5, taille + 105); // Affichage du coefficient Rouge
    text("Coefficient V : " + nf(coeff_g, 1, 2), 5, taille + 125); // Affichage du coefficient Vert
    text("Coefficient B : " + nf(coeff_b, 1, 2), 5, taille + 145); // Affichage du coefficient Bleu
    text("Coefficient Noir / Blanc : " + nf(coeff_bw, 1, 2), 5, taille + 165); // Affichage du coefficient Noir et Blanc
  }

  if (histogrammes) { // Si la fenêtre des histogrammes est ouverte
    noStroke(); // Pas de contour
    fill(91, 170, 183, 120); // Couleur bleue transparente
    rect(width/2+width/6, taille * 1.5, l_droit/3.5, taille * 18); // Affichage du rectangle de la fenêtre

    creerHistogrammes(img_edit); // Génération des histogrammes (voir 'Histogrammes.pde')
    dessinerHistogrammes(width/2 + width/5, taille * 5, 255, 150); // Affichage des histogrammes (voir 'Histogrammes.pde')
  }

  if (contraste) { // Si la fenêtre du contraste est ouverte
    noStroke(); // Pas de contour
    textAlign(CENTER); // Texte aligné à partir du centre
    fill(91, 170, 183, 210); // Couleur bleue transparente
    rect(5*width/6, taille * 2.75, l_droit/7.25, taille * 1.5); // Affichage du rectangle de la fenêtre
    textSize(13); 
    ; // Taille du texte : 13

    fill(0); // Couleur noire
    text(nf(coeff_contraste, 1, 1), 5*width/6 + width/15, taille * 3.65);
    image(minus, 5*width/6 + width/68, taille * 3); // Affichage du bouton '-'
    image(plus, 5*width/6 + width/11, taille * 3); // Affichage du bouton '+'  

    textAlign(LEFT); // Texte aligné à partir de la gauche
  }

  if (rgb_e) { // Si la fenêtre des composantes RGB est ouverte
    noStroke(); // Pas de contour
    fill(91, 170, 183, 210); // Couleur bleue transparente
    rect(5*width/6, taille * 4.75, l_droit/7.25, taille * 4.5); // Affichage du rectangle de la fenêtre

    textAlign(CENTER); // Texte aligné à partir du centre
    fill(255, 0, 0); // Couleur rouge
    textSize(13); // Taille du texte : 13

    text(nf(coeff_r, 1, 2), 5*width/6 + width/15, taille * 5.65); // Affichage du coefficient rouge avec 2 chiffres après la virgule avec la fonction nf()
    image(minus, 5*width/6 + width/68, taille * 5);  // Affichage du bouton '-'
    image(plus, 5*width/6 + width/11, taille * 5); // Affichage du bouton '+'

    fill(0, 255, 0);
    text(nf(coeff_g, 1, 2), 5*width/6 + width/15, taille * 7.15); // Affichage du coefficient vert avec 2 chiffres après la virgule avec la fonction nf()
    image(minus, 5*width/6 + width/68, taille * 6.5);  // Affichage du bouton '-'
    image(plus, 5*width/6 + width/11, taille * 6.5); // Affichage du bouton '+'

    fill(0, 0, 255);
    text(nf(coeff_b, 1, 2), 5*width/6 + width/15, taille * 8.65); // Affichage du coefficient bleu avec 2 chiffres après la virgule avec la fonction nf() 
    image(minus, 5*width/6 + width/68, taille * 8);  // Affichage du bouton '-'
    image(plus, 5*width/6 + width/11, taille * 8); // Affichage du bouton '+'

    textAlign(LEFT); // Texte aligné à partir de la gauche
  }

  if (bw) { // Si la fenêtre du mode noir et blanc est ouverte
    noStroke(); // Pas de contour
    fill(91, 170, 183, 210); // Couleur bleue transparente
    rect(5*width/6, taille * 6, l_droit/7.25, taille * 1.5); // Affichage du rectangle de la fenêtre

    textAlign(CENTER); // Texte aligné à partir du centre
    fill(0); // Couleur noire
    textSize(13); // Taille du texte : 13

    text(nf(coeff_bw, 1, 2), 5*width/6 + width/15, taille * 6.90); // Affichage du coefficient noir et blanc avec 2 chiffres après la virgule avec la fonction nf()
    image(minus, 5*width/6 + width/68, taille * 6.25);  // Affichage du bouton '-'
    image(plus, 5*width/6 + width/11, taille * 6.25);  // Affichage du bouton '+'

    textAlign(LEFT); // Texte aligné à partir de la gauche
  }

  if (rgb_gris) {
    noStroke(); // Pas de contour
    fill(91, 170, 183, 210); // Couleur bleue transparente
    rect(5*width/6, taille * 8.75, l_droit/7.25, taille * 4.5); // Affichage du rectangle de la fenêtre

    textAlign(CENTER); // Texte aligné à partir du centre
    fill(255, 0, 0); // Couleur rouge
    textSize(13); // Taille du texte : 13

    text(nf(coeffr_g, 1, 2), 5*width/6 + width/15, taille * 9.65); // Affichage du coefficient rouge avec 2 chiffres après la virgule avec la fonction nf()
    image(minus, 5*width/6 + width/68, taille * 9);  // Affichage du bouton '-'
    image(plus, 5*width/6 + width/11, taille * 9); // Affichage du bouton '+'

    fill(0, 255, 0);
    text(nf(coeffg_g, 1, 2), 5*width/6 + width/15, taille * 11.15); // Affichage du coefficient vert avec 2 chiffres après la virgule avec la fonction nf()
    image(minus, 5*width/6 + width/68, taille * 10.5);  // Affichage du bouton '-'
    image(plus, 5*width/6 + width/11, taille * 10.5); // Affichage du bouton '+'

    fill(0, 0, 255);
    text(nf(coeffb_g, 1, 2), 5*width/6 + width/15, taille * 12.65); // Affichage du coefficient bleu avec 2 chiffres après la virgule avec la fonction nf() 
    image(minus, 5*width/6 + width/68, taille * 12);  // Affichage du bouton '-'
    image(plus, 5*width/6 + width/11, taille * 12); // Affichage du bouton '+'

    textAlign(LEFT); // Texte aligné à partir de la gauche
  }
}