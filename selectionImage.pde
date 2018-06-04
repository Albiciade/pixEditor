void selectionImage(File image) {
  infos = false;
  histogrammes = false;
  contraste = false;
  symmetry_e = false;
  rgb_e = false;
  bw = false;
  rgb_gris = false;
  pinceau = false;
  
  coeff_contraste = 1;
  coeff_r = 1;
  coeff_g = 1;
  coeff_b = 1;
  coeff_bw = 0.3;
  coeffr_g = 1;
  coeffg_g = 1;
  coeffb_g = 1;

  if (image == null) {
    println("La fenêtre a été fermée.");
  } else {
    String p = image.getAbsolutePath();
    if (p.endsWith(".jpg") || p.endsWith(".jpeg") || p.endsWith(".png") || p.endsWith(".JPG") || p.endsWith(".PNG") || p.endsWith(".gif")) {
      println("Le fichier est une image.");

      img = loadImage(p);
      img_edit = loadImage(p);
      String[] name = split(p, '\\');
      img_name = name[name.length-1];
      println(img_name);

      img_v = img;
      float dx = img.width / width_c;
      float dy = img.height / height_c;

      println(dx, dy);
      if (img_edit.width > width_c) {
        img_edit.resize(int(width_c), 0);
      }
      if (img_edit.height > height_c) {
        img_edit.resize(0, int(height_c));
      }

      img_edit_v = createImage(img_edit.width, img_edit.height, RGB);
      img_edit_vs = createImage(img_edit.width, img_edit.height, RGB);
      creerHistogrammes(img);

      for (int k = 0; k < img_edit.width * img_edit.height; k++) {
        img_edit_v.pixels[k] = img_edit.pixels[k];
        img_edit_vs.pixels[k] = img_edit.pixels[k];
      }

      for (int x = 0; x < img_edit_vs.width; x++) {
        for (int y = 0; y < img_edit_vs.height; y++) {
          img_edit_vs.pixels[y * img_edit_vs.width + x] = img_edit_v.pixels[(img_edit_v.width - x - 1) + y * img_edit_v.width];
        }
      }
      img_edit_vs.updatePixels();
      surface.setTitle(img_name + " - " + img.width + "x" + img.height + "px");
    }
  }
}