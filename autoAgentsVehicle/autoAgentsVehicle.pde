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
    desired.normalize();
    desired.mult(maxSpeed);
  
    // find the steering velocity
    PVector steering = PVector.sub(desired, velocity);
    steering.normalize();
    steering.limit(maxSteer);
    applyForce(steering);
  }
  
  void applyForce(PVector force) {
    PVector f = new PVector(force.x, force.y);
    acceleration.add(f);
  }
  
}

ArrayList <Vehicle> vehicles = new ArrayList<Vehicle>();
Vehicle v;

void setup() {
  size(displayWidth, displayHeight);
  v = new Vehicle(width, height); 
  vehicles.add(v);
}

void draw() {
  background(255);
  for (Vehicle veh : vehicles) {
    veh.seek(new PVector(mouseX, mouseY));
    veh.update();
    veh.display();
  } 
}

void mousePressed() {
  Vehicle v = new Vehicle(mouseX, mouseY);
  vehicles.add(v);
}