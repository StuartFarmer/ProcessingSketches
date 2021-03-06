class Vehicle {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float size;
  
  float maxSpeed;
  float maxSteer;
  
  Vehicle(float x, float y) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    location = new PVector(x, y);
    size = 3.0;
    maxSpeed = 4;
    maxSteer = 0.1;
  }
  
  void update() {
    checkEdges();
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display() {
    float theta = velocity.heading() + PI/2;
    fill(175);
    stroke(0);
    pushMatrix();
      translate(location.x, location.y);
      rotate(theta);
      beginShape();
        vertex(0, -size*2);
        vertex(-size, size*2);
        vertex(size, size*2);
      endShape(CLOSE);
    popMatrix();
  }
  
  // steering velocity = desired - velocity
  void seek(PVector target) {
    
    // find the desired velocity by pointing from the
    // vehicle's current location to the target
    PVector desired = PVector.sub(target, location);
    float dMag = desired.mag();
    desired.normalize();
    if (dMag < 100) {
      desired.mult(map(dMag, 0, 100, 0, maxSpeed));
    } else {
      desired.mult(maxSpeed);
    }
  
    // find the steering velocity
    PVector steering = PVector.sub(desired, velocity);
    steering.normalize();
    steering.mult(-1);
    steering.limit(maxSteer);
    if (dMag > 10) applyForce(steering);
  }
  
  void applyForce(PVector force) {
    PVector f = new PVector(force.x, force.y);
    acceleration.add(f);
  }
  
  void checkEdges() {
    if (location.x > width) location.x = 0;
    else if (location.x < 0) location.x = width;
    if (location.y > height) location.y = 0;
    else if (location.y < 0) location. y = height;
  }
}

Vehicle v;

void setup() {
  size(500, 500);
  v = new Vehicle(width, height); 
}

void draw() {
  background(255);
  v.seek(new PVector(mouseX, mouseY));
  v.update();
  v.display();
}