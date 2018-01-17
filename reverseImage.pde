void reverseImage(PImage image) {
  for (int x = 0; x < image.width; x++) {
    for (int y = 0; y < image.height; y++) {
      if (!symmetry_e) {
        image.pixels[y * image.width + x] = img_edit.pixels[(img_edit_v.width - x - 1) + y * img_edit.width];
        image.updatePixels();
      } else {
        image.pixels[y * image.width + x] = img_edit_vs.pixels[(img_edit_vs.width - x - 1) + y * img_edit_vs.width];
        image.updatePixels();
      }
    }
  }
}