void updateNB(PImage imgt) {
  for (int x = 0; x < imgt.width; x++) {
    for (int y = 0; y < imgt.height; y++) {
      int c = img_edit_v.get(x, y);
      imgt.set(x, y, color(int(red(c) * coeff_bw + green(c) * coeff_bw + blue(c) * coeff_bw / 3)));
      imgt.updatePixels();
    }
  }
}