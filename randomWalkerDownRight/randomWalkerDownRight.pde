class Walker {
  int x;
  int y;
  Walker() {
    x = width/2;
    y = height/2;
  }
  
  void display() {
    stroke(0);
    point(x, y);
  }
  
  void step() {
    float r = random(1);
    
    // Walker has a 20% chance of moving right or up and a 30% chance of moving down or left
    if (r < 0.2) x--;
    else if (r > 0.2 && r <= 0.5) x++;
    else if (r > 0.5 && r <= 0.7) y--;
    else if (r > 0.7 && r <= 1) y++;

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