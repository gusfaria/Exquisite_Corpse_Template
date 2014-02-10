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
    isVisible = false;
    xPos = random(width/3.0 * 2.0, width);
    yPos = random(0, height);  
  }
  
  void setNew() {
    diameter = 0;
    r = random(255);
    g = random(255);
    b = random(255);
  }
  
  void update() {
    
    if ( isVisible ) {
      if (diameter < maxDiameter) {
        diameter += 3;
      }
      
    }
  }
  
  void display() {
    
  }
  
}
