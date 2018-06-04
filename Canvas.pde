void drawCanvas() { // Fonction pour dessiner la fenêtre et les images (basiquement tout)

  float taille = height/20; // La taille d'une icône est de la hauteur de la fenêtre divisée par 20
  float l_droit = width-taille*2; // La coordonnée x de la colonne à droite de l'écran est de la largeur de la fenêtre moins la taille fois deux

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

  if (pinceau) {
    noFill();
    stroke(255, 0, 0);
    rect(iconsv[6].x, iconsv[6].y, iconsv[6].t, iconsv[6].t);
  }
  if (rubber) {
    noFill();
    stroke(255, 0, 0);
    rect(iconsv[7].x, iconsv[7].y, iconsv[7].t, iconsv[7].t);
  }
  if (picker) {
    noFill();
    stroke(255, 0, 0);
    rect(iconsv[8].x, iconsv[8].y, iconsv[8].t, iconsv[8].t);
  }
  if (flou) {
    noFill();
    stroke(255, 0, 0);
    rect(iconsv[9].x, iconsv[9].y, iconsv[9].t, iconsv[9].t);
  }

  color c = color(cr, cg, cb);
  fill(c);
  stroke(255);
  rect(taille*9.5, 1, taille, taille);

  for (int i = 0; i<256; i++) { //3 barres de couleurs pour sélectionner précisement sa couleur
    float m = map(i, 0, 257, 0, taille*6);

    stroke(i, 0, 0);
    line(m + taille*11, taille/4, m + taille*11, taille/1.2);

    stroke(0, i, 0);
    line(m + taille*19, taille/4, m + taille*19, taille/1.2);

    stroke(0, 0, i);
    line(m + taille*27, taille/4, m + taille*27, taille/1.2);
  }

  stroke(255); // Couleur du curseur : blanche
  mCr = map(cr, 0, 255, 0, taille*6);
  mCg = map(cg, 0, 255, 0, taille*6);
  mCb = map(cb, 0, 255, 0, taille*6);

  line(taille*11+mCr, taille/4, taille*11+mCr, taille/1.2); // Curseur composante rouge
  line(taille*19+mCg, taille/4, taille*19+mCg, taille/1.2); // Curseur composante verte
  line(taille*27+mCb, taille/4, taille*27+mCb, taille/1.2); // Curseur composante bleue

  image(minus2, taille*7, taille/4, taille/1.5, taille/1.5);
  fill(255);
  text(nf(tpinceau, 3), taille*7.75, taille/1.4);
  image(plus2, taille*8.5, taille/4, taille/1.5, taille/1.5);


  pushMatrix(); // On 'sauvegarde' l'emplacement actuel avant des translate();
  translate(taille, 2* taille); // On se décale de la taille d'une icône en abscisse et de 2 icônes en ordonnée

  if (img_edit.width != 0) { // On vérifie si la largeur de l'image à éditer est différente de 0 (si l'image à éditer existe)

    img_edit.updatePixels();
    image(img_edit_v, 0, 0);
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
    textSize(13);  // Taille du texte : 13

    fill(0); // Couleur noire
    text(nf(coeff_contraste, 1, 2), 5*width/6 + width/15, taille * 3.65);
    image(minus, 5*width/6 + width/68, taille * 3); // Affichage du bouton '-'
    image(plus, 5*width/6 + width/11, taille * 3); // Affichage du bouton '+'  

    textAlign(LEFT); // Texte aligné à partir de la gauche
  }

  if (rgb_e) { // Si la fenêtre des composantes RGB est ouverte
    noStroke(); // Pas de contour
    fill(91, 170, 183, 210); // Couleur bleue transparente
    rect(5*width/6, taille * 4.75, l_droit/7.25, taille * 3.5); // Affichage du rectangle de la fenêtre

    textAlign(CENTER); // Texte aligné à partir du centre
    fill(255, 0, 0); // Couleur rouge
    textSize(13); // Taille du texte : 13

    for (int i = 0; i < slidersRVB.length; i++) {
      slidersRVB[i].isDisplayed = true;
      slidersRVB[i].display();
    }
    coeff_r = slidersRVB[0].getCurValue();
    coeff_g = slidersRVB[1].getCurValue();
    coeff_b = slidersRVB[2].getCurValue();

    img_edit = updateRGB(img_edit);

    fill(255, 0, 0);
    text(nf(coeff_r, 1, 2), 5*width/6 + width/15, slidersRVB[0].y + taille * 0.5); // Affichage du coefficient rouge avec 2 chiffres après la virgule avec la fonction nf()

    fill(0, 255, 0);  
    text(nf(coeff_g, 1, 2), 5*width/6 + width/15, slidersRVB[1].y + taille * 0.5); // Affichage du coefficient rouge avec 2 chiffres après la virgule avec la fonction nf()

    fill(0, 0, 255);
    text(nf(coeff_b, 1, 2), 5*width/6 + width/15, slidersRVB[2].y + taille * 0.5); // Affichage du coefficient rouge avec 2 chiffres après la virgule avec la fonction nf()


    textAlign(LEFT); // Texte aligné à partir de la gauche
  } else {
    for (int i = 0; i < slidersRVB.length; i++) {
      slidersRVB[i].isDisplayed = false;
    }
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
    rect(5*width/6, taille * 7.2, l_droit/7.25, taille * 3.5); // Affichage du rectangle de la fenêtre

    textAlign(CENTER); // Texte aligné à partir du centre
    fill(255, 0, 0); // Couleur rouge
    textSize(13); // Taille du texte : 13

    for (int i = 0; i < slidersRVB.length; i++) {
      slidersRVBG[i].isDisplayed = true;
      slidersRVBG[i].display();
    }
    coeffr_g = slidersRVBG[0].getCurValue();
    coeffg_g = slidersRVBG[1].getCurValue();
    coeffb_g = slidersRVBG[2].getCurValue();

    img_edit = updateGris(img_edit);

    fill(255, 0, 0);
    text(nf(coeffr_g, 1, 2), 5*width/6 + width/15, slidersRVBG[0].y + taille * 0.5); // Affichage du coefficient rouge avec 2 chiffres après la virgule avec la fonction nf()

    fill(0, 255, 0);  
    text(nf(coeffg_g, 1, 2), 5*width/6 + width/15, slidersRVBG[1].y + taille * 0.5); // Affichage du coefficient rouge avec 2 chiffres après la virgule avec la fonction nf()

    fill(0, 0, 255);
    text(nf(coeffb_g, 1, 2), 5*width/6 + width/15, slidersRVBG[2].y + taille * 0.5); // Affichage du coefficient rouge avec 2 chiffres après la virgule avec la fonction nf()
    
    
    /* text(nf(coeffr_g, 1, 2), 5*width/6 + width/15, taille * 9.65); // Affichage du coefficient rouge avec 2 chiffres après la virgule avec la fonction nf()
     image(minus, 5*width/6 + width/68, taille * 9);  // Affichage du bouton '-'
     image(plus, 5*width/6 + width/11, taille * 9); // Affichage du bouton '+'
     
     fill(0, 255, 0);
     text(nf(coeffg_g, 1, 2), 5*width/6 + width/15, taille * 11.15); // Affichage du coefficient vert avec 2 chiffres après la virgule avec la fonction nf()
     image(minus, 5*width/6 + width/68, taille * 10.5);  // Affichage du bouton '-'
     image(plus, 5*width/6 + width/11, taille * 10.5); // Affichage du bouton '+'
     
     fill(0, 0, 255);
     text(nf(coeffb_g, 1, 2), 5*width/6 + width/15, taille * 12.65); // Affichage du coefficient bleu avec 2 chiffres après la virgule avec la fonction nf() 
     image(minus, 5*width/6 + width/68, taille * 12);  // Affichage du bouton '-'
     image(plus, 5*width/6 + width/11, taille * 12); // Affichage du bouton '+' */

    textAlign(LEFT); // Texte aligné à partir de la gauche
  } else {
    for (int i = 0; i < slidersRVBG.length; i++) {
      slidersRVBG[i].isDisplayed = false;
    }
  }
}