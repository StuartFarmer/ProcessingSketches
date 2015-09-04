void setup() {
  size(500, 500);
}

float xPeriod = 30;
float yPeriod = 30;

float lastX;
float lastY;

void draw() {
  noStroke();
  fill(0, 25);
  rect(0, 0, width, height);
  float x = (200 * cos(TWO_PI * frameCount / xPeriod)) + width/2;
  float y = (200 * sin(TWO_PI * frameCount / yPeriod)) + height/2;
  stroke(0, 255, 0);
  line(lastX, lastY, x, y);
  lastX = x;
  lastY = y;
  
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      yPeriod++;
    }
    else if (keyCode == DOWN) {
      yPeriod--;
    }
    else if (keyCode == RIGHT) {
      xPeriod++;
    }
    else if (keyCode == LEFT) {
      xPeriod--;
    }
    println("\n");
    println("x period: ", xPeriod);
    println("y period: ", yPeriod);
  }
}