void setup() {
  size(500, 500);
  background(255);
  
  colorMode(HSB);
}

void draw() {
  strokeWeight(12);
  for (int j = 0; j < height/10; j++) {
    stroke(mouseX/2, j*10, mouseY/2);
    float lastX = 0;
    float lastY = 0;
    for (int i = 0; i < width/10; i++) {
      float x = i*width/25;
      float y = (cos(i)*20)+j*20;
      line(x, y, lastX, lastY);
      lastX = x;
      lastY = y;
    }
  }
}