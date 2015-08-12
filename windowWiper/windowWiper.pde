boolean clicked;
  int xPos;
  int yPos;

void setup() {
 size(480, 480);
}

void draw() {
  noStroke();
  fill(125);
  rect(0, 0, 480, 480);
  if (mousePressed) {
    stroke(0);
    fill(255);
    rect(mouseX - 5, 0, 10, 480);
  }
}
