class Walker {
  
  float x, y;
  float tx, ty;
  
  Walker() {
    x = width/2;
    y = height/2;
    tx = 0;
    ty = 10000;
  }
  
  void step() {
    x += map(noise(tx), 0, 1, -1, 1);
    y += map(noise(ty), 0, 1, -1, 1);
    
    tx += 0.01;
    ty += 0.01;
    
  }
  
  void display() {
    point(x, y);
  }
}

Walker w;

void setup() {
  size(500,500);
  background(255);
  w = new Walker();
}

void draw() {
  w.step();
  w.display();
}