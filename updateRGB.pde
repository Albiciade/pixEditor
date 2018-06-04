PImage updateRGB(PImage imgt) {
  for (int x = 0; x < imgt.width; x++) {
    for (int y = 0; y < imgt.height; y++) {
      int c = img_edit_v.get(x, y);
      imgt.set(x, y, color(red(c)*coeff_r, green(c)*coeff_g, blue(c)*coeff_b));
    }
  }
  imgt.updatePixels();
  return imgt;
}