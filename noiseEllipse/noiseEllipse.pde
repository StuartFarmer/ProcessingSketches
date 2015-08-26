void setup() {
  size(500,500);
  background(255);
}

float t = 3;
void draw() {
  background(255);
  float n = noise(t);
  float x = map(n, 0, 1, 0, width);
  ellipse(x, 250, 16, 16);
  t += 0.01;
}