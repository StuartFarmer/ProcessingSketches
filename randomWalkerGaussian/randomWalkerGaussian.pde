class Walker {
  int x;
  int y;
  int lastX;
  int lastY;
  Walker() {
    x = width/2;
    y = height/2;
  }
  
  void display() {
    stroke(0);
    line(lastX, lastY, x, y);
  }
  
  void step() {
    // store last coordinates for drawing the line
    lastX = x;
    lastY = y;
    
    // move randomly
    float r = random(1);
    float num = randomGaussian();
    println(num);
    if (r <= 0.5) x += randomGaussian() + 0.5;
    else y += randomGaussian() + 0.5;
  }
}

Walker w;

void setup() {
  size(500, 500);
  w = new Walker();
  background(255);
}

void draw() {
  w.step();
  w.display();
}