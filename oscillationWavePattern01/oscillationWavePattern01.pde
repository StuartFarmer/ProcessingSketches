float angle = 0;
float angleVel = 0.2;
float amplitude = 100;

void drawWave() {
  float lastX = 0;
  float lastY = 0;
  for (int x = 0; x <= width; x += 24) {
    float y = amplitude * sin(angle);
    if (lastX == 0 && lastY == 0) point(x, y+height/2);
    else line(x, y+height/2, lastX, lastY);
    angle += angleVel;
    lastX = x;
    lastY = y+height/2;
  }
}

void setup() {
  size(700, 250);
  background(255);
  drawWave();
}

void draw() {
  
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      angleVel += 0.1;
    }
    if (keyCode == DOWN) {
      angleVel -= 0.1;
    }
    background(255);
    drawWave();
  }
}