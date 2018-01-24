PImage folder;
PImage save;
PImage info;
PImage chart;
PImage contrast;
PImage minus;
PImage plus;
PImage symmetry;
PImage rgb;
PImage noir_blanc;
PImage reset;
PImage gris;

Icon[] iconsh;
Icon[] iconsv;

PImage[] imagesIcones = new PImage[0];
String[] listeActions = {
  "ouvertureFichier", 
  "saveImage", 
  "infosImages", 
  "resetImage", 
  "histogrammes", 
  "contraste", 
  "symmetry", 
  "rgb", 
  "noirBlanc", 
  "rgbGris"
};

void loadIcons() {
  float taille = height/20;
  float l_droit = width-taille*2;

  folder = loadImage("folder.png");
  save = loadImage("save.png");
  info = loadImage("info.png");
  chart = loadImage("bar-chart.png");
  contrast = loadImage("contrast.png");
  minus = loadImage("minus.png");
  plus = loadImage("plus.png");
  symmetry = loadImage("symmetry.png");
  rgb = loadImage("rgb.png");
  noir_blanc = loadImage("ink-drop-outline.png");
  reset = loadImage("left-arrow.png");
  gris = loadImage("rgb_gris.png");

  imagesIcones = (PImage[]) append(imagesIcones, folder); // [0]
  imagesIcones = (PImage[]) append(imagesIcones, save); // [1]
  imagesIcones = (PImage[]) append(imagesIcones, info); // [2]
  imagesIcones = (PImage[]) append(imagesIcones, reset); // [3]
  imagesIcones = (PImage[]) append(imagesIcones, chart); // [4]
  imagesIcones = (PImage[]) append(imagesIcones, contrast); // [5]
  imagesIcones = (PImage[]) append(imagesIcones, symmetry); // [6]
  imagesIcones = (PImage[]) append(imagesIcones, rgb); // [7]
  imagesIcones = (PImage[]) append(imagesIcones, noir_blanc); // [8]
  imagesIcones = (PImage[]) append(imagesIcones, gris); // [9]


  iconsh = new Icon[4];
  for (int i = 0; i < 4; i++) {
    Icon temp = new Icon(2 + (taille+5)*i, 2, taille, imagesIcones[i], listeActions[i]);
    iconsh[i] = temp;
  }


  iconsv = new Icon[imagesIcones.length-iconsh.length];
  for (int i = 0; i < iconsv.length; i++) {
    Icon temp = new Icon(l_droit+taille/2, height/18 * (i+1), taille, imagesIcones[i+iconsh.length], listeActions[i+iconsh.length]);
    iconsv[i] = temp;
  }
}