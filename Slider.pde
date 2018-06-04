class Slider {
  float x, y;
  float a = 0;
  float b = 255;
  float xCur;
  float yCur;
  float vCur;
  int len = 100;
  boolean isDisplayed = false;

  Slider(float xpos, float ypos) {
    x = xpos;
    y = ypos;
    xCur = xpos;
    yCur = ypos;
  }

  void setLength(int l) {
    len = l;
  }

  void setRange(float bR, float eR) {
    a = bR;
    b = eR;
  }

  void setDefaultValue(float dv) {
    if (dv > a && dv < b) {
      float dvMap = map(dv, a, b, 0, len);
      xCur = x + dvMap;
    }
  }

  void setCursorPos(float xp) {
    xCur = xp;
  }

  float getCurValue() {
    vCur = xCur - x;
    float v = map(vCur, 0, len, a, b);
    return v;
  }

  void display() {
    if (isDisplayed) {
      strokeWeight(2);
      stroke(0);
      line(x, y, x + len, y);
      strokeWeight(1);
      fill(92);
      noStroke();
      ellipse(xCur, yCur, 15, 15);
    }
  }
}