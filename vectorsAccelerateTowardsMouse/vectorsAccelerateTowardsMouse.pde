Mover m;

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  PVector mouse;
  PVector direction;
  
  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    mouse = new PVector(mouseX, mouseY);
    direction = new PVector(0, 0);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    
    mouse.x = mouseX;
    mouse.y = mouseY;
    
    direction = PVector.sub(mouse, location);
    direction.add(random(3), random(3));
    direction.normalize();
    direction.mult(0.05);
    
    acceleration = direction;
    
    velocity.limit(2);
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

Mover[] movers = new Mover[20];

void setup() {
  size(500, 500);
  m = new Mover();
  
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover();
  }
}

void draw() {
  background(255);
  m.update();
  m.checkBoundaries();
  m.display();
  
  for (int i = 0; i < movers.length; i++) {
    movers[i].update();
    movers[i].checkBoundaries();
    movers[i].display();
  }
}