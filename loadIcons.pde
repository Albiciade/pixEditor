PImage folder, save, info, chart, contrast, minus, plus, minus2, plus2, symmetry, rgb, noir_blanc, reset, gris, brush, rubberImg, pickerImg, blur;

Icon[] iconsh;
Icon[] iconsv;

PImage[] imagesIcones;

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
  "rgbGris", 
  "useBrush", 
  "useRubber", 
  "usePicker", 
  "useBlur"
};

void preLoadIcons() {
  folder = loadImage("folder.png");
  save = loadImage("save.png");
  info = loadImage("info.png");
  chart = loadImage("bar-chart.png");
  contrast = loadImage("contrast.png");
  minus = loadImage("minus.png");
  plus = loadImage("plus.png");
  minus2 = loadImage("minus-2.png");
  plus2 = loadImage("plus-2.png");
  symmetry = loadImage("symmetry.png");
  rgb = loadImage("rgb.png");
  noir_blanc = loadImage("ink-drop-outline.png");
  reset = loadImage("left-arrow.png");
  gris = loadImage("rgb_gris.png");
  brush = loadImage("paint-brush.png");
  rubberImg = loadImage("rubber.png");
  pickerImg = loadImage("picker.png");
  blur = loadImage("blur.png");
}

void loadIcons() {
  preLoadIcons();
  imagesIcones = new PImage[0];
  float taille = height/20;
  float l_droit = width-taille*2;

  folder.resize(int(taille), int(taille)); // On redimensionne toutes les icônes pour qu'elles fassent précisément la taille demandée (variable taille)
  save.resize(int(taille), int(taille)); // Idem
  info.resize(int(taille), int(taille)); // Idem
  chart.resize(int(taille), int(taille)); // Idem 
  contrast.resize(int(taille), int(taille)); // Idem
  plus.resize(int(taille), int(taille)); // Idem 
  minus.resize(int(taille), int(taille)); // Idem 
  plus2.resize(int(taille), int(taille)); // Idem 
  minus2.resize(int(taille), int(taille)); // Idem 
  symmetry.resize(int(taille), int(taille)); // Idem
  rgb.resize(int(taille), int(taille)); // Idem 
  noir_blanc.resize(int(taille), int(taille)); // Idem
  reset.resize(int(taille), int(taille)); // Idem
  gris.resize(int(taille), int(taille)); // Idem
  rubberImg.resize(int(taille), int(taille)); // Idem
  brush.resize(int(taille), int(taille)); // Idem
  pickerImg.resize(int(taille), int(taille)); // Idem
  blur.resize(int(taille), int(taille)); // Idem


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
  imagesIcones = (PImage[]) append(imagesIcones, brush); // [10]
  imagesIcones = (PImage[]) append(imagesIcones, rubberImg); // [11]
  imagesIcones = (PImage[]) append(imagesIcones, pickerImg); // [12]
  imagesIcones = (PImage[]) append(imagesIcones, blur); // [12]


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