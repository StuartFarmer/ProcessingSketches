class Mover {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float mass;
  
  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    
    mass = random(5);
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
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
}

Mover m1;
Mover m2;

void setup() {
  size(500, 500);
  background(255);
  m1 = new Mover();
  m2 = new Mover();
}

void draw() {
  background(255);
  PVector wind = PVector.random2D();
  m1.applyForce(wind);
  m2.applyForce(wind);
  
  m1.update();
  m1.checkEdges();
  m1.display();
  
  m2.update();
  m2.checkEdges();
  m2.display();
}

void mousePressed() {
  PVector wind = PVector.random2D();
  m1.applyForce(wind);
  m2.applyForce(wind);
}