class Icon {
  float x, y, t;
  PImage img;
  String fct;

  Icon(float xpos, float ypos, float taille, PImage image, String action) {
    x = xpos;
    y = ypos;
    t = taille;
    img = image;
    fct = action;
  }


  void display() {
    image(img, x, y, t, t);
  }

  void executeAction() {
    switch(fct) {

    case "ouvertureFichier":
      println("Ouverture de fichier : " + millis() + " ms");
      selectInput("Sélectionnez votre image", "selectionImage");
      break;

    case "saveImage":
      println("Enregistrement : " + millis() + " ms");
      selectOutput("Choisissez où enregistrer votre image", "saveImage");
      break;

    case "infosImages":
      println("Infos : " + millis() + " ms");
      infos = !infos;
      break;

    case "resetImage":
      println("Reset : " + millis() + " ms");
      resetImage(img_edit);
      break;

    case "histogrammes":
      println("Histogrammes : " + millis() + " ms");
      histogrammes = !histogrammes;
      break;

    case "contraste":
      println("Contraste : " + millis() + " ms");
      contraste = !contraste;
      break;

    case "symmetry":
      println("Symétrie : " + millis() + " ms");
      reverseImage(img_edit);
      symmetry_e = !symmetry_e;
      break;

    case "rgb":
      println("RGB : " + millis() + " ms");
      rgb_e = !rgb_e;
      break;

    case "noirBlanc":
      println("Noir et Blanc : " + millis() + " ms");
      bw = !bw;
      break;

    case "rgbGris":
      println("RGB gris : " + millis() + " ms");
      img_edit = updateGris(img_edit);
      rgb_gris = !rgb_gris;
      break;
      
    case "useBrush":
      println("Pinceau : " + millis() + " ms");
      pinceau = !pinceau;
      rubber = false;
      picker = false;
      break;
      
    case "useRubber":
      println("Gomme : " + millis() + " ms");
      rubber = !rubber;
      pinceau = false;
      picker = false;
      break;
    
    case "usePicker":
      println("Pipette : " + millis() + " ms");
      picker = !picker;
      pinceau = false;
      rubber = false;
      break;
      
    case "useBlur":
      println("Flou : " + millis() + " ms");
      flou = !flou;
      pinceau = false;
      rubber = false;
      picker = false;
      break;
      
    default:
      println("Action inconnue : " + millis() + " ms");
      break;
    }
  }
}