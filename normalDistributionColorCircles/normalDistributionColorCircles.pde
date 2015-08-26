void setup() {
  size (640, 640);
  background(0);
}

void draw() {
  // set up standard deviation and mean for normal distribution of circles
  float num;
  float sd = 60;
  float m = 320;
  
  // generate a random x cor
  num = randomGaussian();
  float x = sd * num + m;
  
  // generate a random y cor
  num = randomGaussian();
  float y = sd * num + m;
  
  // generate a random color
  float r = random(1) * 255;
  float g = random(1) * 255;
  float b = random(1) * 255;
  
  // draw the circle
  noStroke();
  fill(color(r, g, b), 10);
  ellipse(x, y, 16, 16);
}
  