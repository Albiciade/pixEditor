int[] rouge = new int[256];
int[] vert = new int[256];
int[] bleu = new int[256];
int[] lumi = new int[256];

int r, g, b, l;

void creerHistogrammes(PImage image) {
  for (int i = 0; i < rouge.length; i++) {
    rouge[i] = 0;
    vert[i] = 0;
    bleu[i] = 0;
    lumi[i] = 0;
  }

  for (int i = 0; i < image.width; i++) {
    for (int j = 0; j < image.height; j++) {
      int a = image.get(i, j);

      r = int(red(a));
      g = int(green(a));
      b = int(blue(a));
      l = int(brightness(a));

      rouge[r]++;
      vert[g]++;
      bleu[b]++;
      lumi[l]++;
    }
  }
}

void dessinerHistogrammes(float x, float y, int alpha, int ecart) {

  int rmax = max(rouge);
  int vmax = max(vert);
  int bmax = max(bleu);
  int lmax = max(lumi);


  pushMatrix();
  translate(x, y);
  stroke(255, 0, 0, alpha);
  for (int r = 0; r < rouge.length; r++) {
    rouge[r] = int(map(rouge[r], 0, rmax, 0, 100));
    line(r, 0, r, -rouge[r]);
  }

  translate(0, ecart);
  stroke(0, 255, 0, alpha);

  for (int r = 0; r < vert.length; r++) {
    vert[r] = int(map(vert[r], 0, vmax, 0, 100));
    line(r, 0, r, -vert[r]);
  }

  translate(0, ecart);
  stroke(0, 0, 255, alpha);
  for (int r = 0; r < bleu.length; r++) {
    bleu[r] = int(map(bleu[r], 0, bmax, 0, 100));
    line(r, 0, r, -bleu[r]);
  }

  translate(0, ecart);
  stroke(255, 255, 255, alpha);
  for (int r = 0; r < lumi.length; r++) {
    lumi[r] = int(map(lumi[r], 0, lmax, 0, 100));
    line(r, 0, r, -lumi[r]);
  }
  popMatrix();
}