class Wave {
  float startAngle;
  float angleVel;
  
  float wWidth;
  float wHeight;
  
  float lastX;
  float lastY;
  
  Wave() {
    startAngle = 0;
    angleVel = random(0.05, 0.3);
    wWidth = random(0, width);
    wHeight = random(0, height);
    lastX = 0;
    lastY = 0;
  }
  
  void update() {
    float angle = startAngle;
    for (int x = 0; x <= wWidth; x += 12) {
      float y = map(sin(angle), -1, 1, 0, wHeight);
      if (x == 0) {
        noStroke();
        fill(map(y, 0, wHeight, 0, 255),255);
        ellipse(x, y, 8, 8);
      }
      else {
        stroke(map(y, 0, wHeight, 0, 255),255);
        strokeWeight(8);
        line(x, y, lastX, lastY);
      }
      angle += angleVel;
      lastX = x;
      lastY = y;
    }
    startAngle += 0.02;
  }
}

Wave[] waves = new Wave[10];

void setup() {
  size(500, 500);
  for (int i = 0; i < 10; i++) {
    waves[i] = new Wave();
  }
}

void draw() {
  background(200, 200, 255);
  for (int i = 0; i < 10; i++) {
    waves[i].update();
  }
}