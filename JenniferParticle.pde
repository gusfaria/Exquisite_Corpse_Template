class JenniferParticle {
  float xPos;
  float yPos;
  float diameter;

  float alpha;
  float maxDiameter;

  float r, g, b;

  boolean isVisible;

  JenniferParticle() {
    diameter = 0;
    maxDiameter = 300;
    r = 0;
    g = 0;
    b = 0;
    isVisible = false;
    alpha = 255;
    xPos = 0;
    yPos = 0;
  }
  
  void reset() {
    diameter = 0;
    r = random(255);
    g = random(255);
    b = random(255);
    isVisible = true;
    alpha = 255;
    xPos = random(width/3.0 * 2.0, width);
    yPos = random(0, height);
  }

  void update() {
    if ( isVisible && diameter < maxDiameter ) {
      if (diameter < maxDiameter) {
        diameter += 2;
//        alpha = map(diameter, 0, maxDiameter, 255, 0);
      }
    } else if (diameter >= maxDiameter) {
      isVisible = false;
      reset();
    }
  }

  void display() {
    fill(r, g, b, alpha);
    ellipse(xPos, yPos, diameter, diameter);
  }
}

