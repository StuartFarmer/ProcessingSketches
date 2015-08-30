class Balloon {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  PVector buoyancy;
  
  Balloon() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    
    buoyancy = new PVector(0, -1);
  }
  
  void update() {
    applyForce(buoyancy);
    velocity.add(acceleration);
    location.add(velocity);
    
    acceleration.mult(0);
    velocity.mult(0);
  }
  
  void display() {
    noStroke();
    fill(0);
    ellipse(location.x, location.y, 16, 16);
    stroke(0);
    line(location.x, location.y, location.x, location.y+40);
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);
  }
  
  void checkEdges() {
    if (location.x > width) location.x = 0;
    else if (location.x < 0) location.x = width;
    
    if (location.y > height) location.y = 0;
    else if (location.y < 0) applyForce(new PVector(0, 20));
  }
}

Balloon b;

void setup() {
  size(500, 500);
  b = new Balloon();
  background(255);
}

void draw() {
  background(255);
  b.update();
  b.checkEdges();
  b.display();
}

void mousePressed() {
  PVector bounce = new PVector(0, 20);
  b.applyForce(bounce);
}