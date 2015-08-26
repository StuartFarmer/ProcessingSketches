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
    // Determine if to move towards mouse or randomly
    float m = random(1);
    
    // 50% chance of moving towards mouse
    if (m <= 0.5) {
      // Move randomly
      float r = random(1);
      if (r < 0.25) x--;
      else if (r > 0.2 && r <= 0.5) x++;
      else if (r > 0.5 && r <= 0.75) y--;
      else if (r > 0.75 && r <= 1) y++;
    } else {
      // Move towards mouse
      float q = random(1);
      if (q <= 0.5) {
        if (mouseX > x) x++;
        else x--;
      } else {
        if (mouseY > y) y++;
        else y--;
      }
    }

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