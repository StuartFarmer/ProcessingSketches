PVector a;
PVector b;

PFont f;

float theta;

void setup() {
  size(500, 500);
  background(255);
  newVector();
  b = new PVector(1, 0);
  b.mult(100);
  b.add(width/2, height/2);
  f = loadFont("Serif-48.vlw");
  textFont(f, 24);
}

void draw() {
  stroke(0);
  background(255);
  newVector();
  
  // Draw lines
  line(width/2, height/2, a.x, a.y);
  line(width/2, height/2, b.x, b.y);
  
  // Calc angle
  theta = PVector.angleBetween(a, b);
  println("Theta:" + theta);
  // Draw text
  fill(0);
  text("Angle Calculator", 10, 30);
  text(theta, 10, height-20);
}

void keyPressed() {
  background(255);
  newVector();
}

void newVector() {
  a = new PVector(map(mouseX, 0, width, -1, 1), map(mouseY, 0, height, -1, 1));
  a.normalize();
  a.mult(100);
  a.add(new PVector(width/2, height/2));
}