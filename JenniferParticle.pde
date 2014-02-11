class JenniferParticle {
  float xPos, yPos;
  float diameter;
  float minDiameter, maxDiameter;

  JenniferParticle() {
    diameter = 0;
    minDiameter = 30;
    maxDiameter = 400;
    xPos = random(width/3.0 * 2.0, width);
    yPos = random(0, height);
  }

  void resetPosition() {
    diameter = 0;
    xPos = random(width/3.0 * 2.0, width);
    yPos = random(0, height);
  }

  void update() {
    diameter = jenniferDiameterValue;
    if (diameter < minDiameter) {
      resetPosition();
    } 
  }

  void display() {
    if (diameter >= minDiameter) {
      // circle will get redder the louder the sound is
      fill(255, 255-jenniferRedValue, 255-jenniferRedValue);
      ellipse(xPos, yPos, diameter, diameter);
    }
  }
}

