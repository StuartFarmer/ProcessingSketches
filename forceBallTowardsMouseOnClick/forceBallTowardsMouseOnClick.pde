class Mover {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
    
  Mover() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display() {
    noStroke();
    fill(0);
    ellipse(location.x, location.y, 16, 16);
  }
  
  void checkEdges() {
    if (location.x > width) location.x = 0;
    else if (location.x < 0) location.x = width;
    
    if (location.y > height) location.y = 0;
    else if (location.y < 0) location.y = height;
  }
  
  void applyForce(PVector force) {
    // Assume mass = 1
    acceleration.add(force);
  }
  
}

Mover m;

void setup() {
  size(500, 500);
  background(255);
  m = new Mover();
  m.applyForce(PVector.random2D());
}

void draw() {
  background(255);
  m.update();
  m.checkEdges();
  m.display();
}

void mousePressed() {
  PVector mouse = new PVector(mouseX, mouseY);
  PVector direction = PVector.sub(mouse, m.location);
  direction.normalize();
  direction.mult(0.5);
  m.applyForce(direction);
}