void resetImage(PImage imgt) {
  for (int i = 0; i < imgt.width * imgt.height; i++) {
    imgt.pixels[i] = img_edit_v.pixels[i];
  }

  for (int i = 0; i < slidersRVB.length; i++) {
    slidersRVB[i].setDefaultValue(1);
    slidersRVBG[i].setDefaultValue(1);
  }
  
  coeff_contraste = 1;
  coeff_r = 1;
  coeff_g = 1;
  coeff_b = 1;
  coeff_bw = 0.3;
  coeffr_g = 1;
  coeffg_g = 1;
  coeffb_g = 1;

  infos = false;
  histogrammes = false;
  contraste = false;
  symmetry_e = false;
  rgb_e = false;
  bw = false;
  rgb_gris = false;
  imgt.updatePixels();
}