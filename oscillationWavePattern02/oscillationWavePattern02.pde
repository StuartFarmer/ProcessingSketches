float angle = 0;
float angleVel = 0.2;
float amplitude = 100;

void setup() {
  size(400, 200);
  background(255);
  
  drawWave();
}

void drawWave() {
  stroke(0);
  strokeWeight(2);
  noFill();
  
  beginShape();
    for (int x = 0; x <= width; x++) {
      float y = map(sin(angle), -1, 1, 0, height);
      vertex(x, y);
      angle += angleVel;
    }
  endShape();
}

void draw() {
  
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      angleVel += 0.01;
    }
    if (keyCode == DOWN) {
      angleVel -= 0.01;
    }
    background(255);
    drawWave();
  }
}