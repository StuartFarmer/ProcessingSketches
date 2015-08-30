Mover m;

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  Mover() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    velocity.limit(10);
    acceleration = new PVector(-0.001, 0.01);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration = PVector.random2D();
    acceleration.mult(random(2));
  }
  
  void display() {
    noStroke();
    fill(175);
    ellipse(location.x, location.y, 20, 20);
  }
  
  void checkBoundaries() {
    if (location.x > width) location.x = 0;
    else if (location.x < 0) location.x = width;
    
    if (location.y > height) location.y = 0;
    else if (location.y < 0) location.y = height;
  }
}

void setup() {
  size(500, 250);
  m = new Mover();
}

void draw() {
  background(255);
  m.update();
  m.checkBoundaries();
  m.display();
}