void updateContrast(PImage tempImage) { // Fonction updateContrast avec argument une image à modifier
  for (int x = 0; x < img_edit_v.width; x++) {
    for (int y = 0; y < img_edit_v.height; y++) {
      int c = img_edit_v.get(x, y);
      tempImage.set(x, y, color( (127+(red(c)-127)*coeff_contraste), (127+(green(c)-127)*coeff_contraste), (127+(blue(c)-127)*coeff_contraste)));
    }
  }
  tempImage.updatePixels();
}