class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
 
  boolean direction;
  
  Mover() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(5, 5);
    acceleration = new PVector(0.1, 0.1);
    direction = true;
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
  }
  
  void display() {
    noStroke();
    fill(175);
    ellipse(location.x, location.y, 20, 20);
  }
  
  void checkBoundaries() {
    // update for boundaries
    if (location.x > width) location.x = 0;
    else if (location.x < 0) location.x = width;
    
    if (location.y > height) location.y = 0;
    else if (location.y < 0) location.y = height;
  }
  
  void updateAcceleration() {
    // update acceleration
    if (direction == true) {
      acceleration.x = 0.1;
      acceleration.y = 0.1;
    }
    else {
      acceleration.x = -0.1;
      acceleration.y = -0.1;
    }
    
    if (velocity.x >= 10) direction = false;
    else if (velocity.x <= 0) direction = true;
  }

}

Mover m;

void setup() {
  size(500,250);
  m = new Mover();
}

void draw() {
  background(255);
  m.update();
  m.checkBoundaries();
  m.updateAcceleration();
  m.display();
}