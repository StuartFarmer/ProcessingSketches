void setup() {
  size(700, 200);
  background(255);
  stroke(0);
  float lx = 0;
  float ly = 0;
  for (float i = 0; i <= width; i+=10) {
    float x = i;
    float y = noise(i) * height;
    line(lx, ly, x, y);
    lx = x;
    ly = y;
  }
}

float t = 0;

void draw() {
  float n = noise(t); 
  println(n);
  t += 0.01;
}