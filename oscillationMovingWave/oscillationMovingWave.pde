float startAngle = 0;
float angleVel = 0.1;

float lastX = 0;
float lastY = 0;

float freq = 1;

void setup() {
  size(500, 200);
}

void draw() {
  background(200, 200, 255);
  float angle = startAngle;
  for (int x = 0; x <= width; x += 12) {
    float y = map(sin(angle*freq), -1, 1, 0, height);
    if (x == 0) {
      noStroke();
      fill(map(y, 0, height, 0, 255),255);
      ellipse(x, y, 8, 8);
    }
    else {
      stroke(map(y, 0, height, 0, 255),255);
      strokeWeight(8);
      line(x, y, lastX, lastY);
    }
    angle += angleVel;
    lastX = x;
    lastY = y;
  }
  
  startAngle += 0.02;
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      freq += 0.1;
    }
    if (keyCode == DOWN) {
      freq -= 0.1;
    }
    println("Frequency: ", freq);
  }
}