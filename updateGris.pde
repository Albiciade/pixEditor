void updateGris(PImage imgt) {
  for (int x = 0; x < imgt.width; x++) {
    for (int y = 0; y < imgt.height; y++) {
      int c = img_edit_v.get(x, y);
      imgt.set(x, y, color(int((red(c) * coeffr_g + green(c) * coeffg_g + blue(c) * coeffb_g) / (coeffr_g + coeffg_g + coeffb_g))));
      imgt.updatePixels();
    }
  }
}