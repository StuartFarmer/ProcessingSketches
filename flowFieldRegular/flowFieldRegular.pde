class FlowField {
  PVector [][] field; // actual vectors
  int cols, rows; // number of columns and rows
  int resolution; // detail correlated to screen dimensions
  
  FlowField() {
    resolution = 10;
    cols = width/resolution;
    rows = height/resolution;
    field = new PVector[cols][rows];
    
    // Generate field
    float xoff = random(-10000, 10000);
    float yoff = random(-10000, 10000);
    
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        float theta = map(noise(xoff, yoff), 0, 1, 0, TWO_PI);
        field[i][j] = new PVector(cos(theta), sin(theta));
        yoff += 0.1;
      }
      xoff += 0.1;
    }
  }
    PVector lookup(PVector location) {
      int column = int(constrain(location.x/resolution, 0, cols-1));
      int row = int(constrain(location.y/resolution, 0, rows-1));
      return new PVector(field[column][row].x, field[column][row].y);
    }
}

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
  
  Vehicle() {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    location = new PVector(random(width), random(height));
    size = 3.0;
    maxSpeed = 4;
    maxSteer = 0.1;
  }
  
  void follow(FlowField flow) {
    PVector desired = flow.lookup(location);
    desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxSteer);
    applyForce(steer);
  }
  
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
    checkEdges();
  }
  
  void display() {
    float theta = velocity.heading() + PI/2;
    fill(175, 90);
    stroke(175, 90);
    pushMatrix();
      translate(location.x, location.y);
      rotate(theta);
      strokeWeight(4);
      point(0,0);
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
  
  void checkEdges() {
    if (location.x > width) location.x = 0;
    else if (location.x < 0) location.x = width;
    if (location.y > height) location.y = 0;
    else if (location.y < 0) location.y = height;
  }
  
}

ArrayList <Vehicle> vehicles = new ArrayList<Vehicle>();
Vehicle v;
FlowField flow;

void setup() {
  size(displayWidth, displayHeight);
  v = new Vehicle(width, height); 
  flow = new FlowField();
  vehicles.add(v);
  background(255);
}

void draw() {
  fill(255, 10);
  noStroke();
  rect(0, 0, width, height);

  // Change flow field every ten seconds
  //if (frameCount % 600 == 0) {
  //  flow = new FlowField();
  //}

  for (Vehicle veh : vehicles) {
    veh.follow(flow);
    veh.update();
    veh.display();
  } 
}

void mousePressed() {
  Vehicle v = new Vehicle();
  vehicles.add(v);
}

void keyPressed() {
  background(255);
  flow = new FlowField();
}