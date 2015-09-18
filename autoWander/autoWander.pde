class Vehicle {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float size;
  
  float maxSpeed;
  float maxSteer;
  
  float wanderTheta;
  
  PImage img;
  
  float tintOffset;
  
  Vehicle(float x, float y) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    location = new PVector(x, y);
    size = 3.0;
    maxSpeed = 4;
    maxSteer = 0.1;
    wanderTheta = 0;
    img = loadImage("texture.png");
    tintOffset = random(-100000, 100000);
  }
  
  Vehicle() {
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-1, 1), random(-1, 1));
    location = new PVector(random(width), random(height));
    size = 3.0;
    maxSpeed = 4;
    maxSteer = 0.1;
    wanderTheta = 0;
    img = loadImage("texture.png");
    tintOffset = random(-100000, 100000);
  }
  
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
    checkEdges();
  }
  
  void display() {
    float angle = random(-2*PI, 2*PI);
    
    pushMatrix();
      translate(location.x, location.y);
      rotate(angle);
      imageMode(CENTER);
      tint(255, map(noise((frameCount/25)+tintOffset), 0, 1, 0, 255));
      image(img, 0, 0);
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
  
  void wander() {
    float wanderRadius = 25;
    float wanderDistance = 100;
    float change = 0.3;
    
    wanderTheta += random(-change, change);
    
    PVector ahead = velocity.get();
    ahead.normalize();
    ahead.mult(wanderDistance);
    ahead.add(location);
    
    float h = velocity.heading();
    PVector altered = new PVector(wanderRadius * cos(wanderTheta+h), wanderRadius * sin(wanderTheta+h));
    
    PVector target = PVector.add(ahead, altered);
    
    seek(target);
  }
  
  void applyForce(PVector force) {
    PVector f = new PVector(force.x, force.y);
    acceleration.add(f);
  }
  
  void checkEdges() {
    if (location.x < 25) {
      PVector desired = new PVector(maxSpeed, velocity.y);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxSteer);
      applyForce(steer);
    } else if (location.x > width-25) {
      PVector desired = new PVector(-maxSpeed, velocity.y);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxSteer);
      applyForce(steer);
    }
    if (location.y < 25) {
      PVector desired = new PVector(maxSpeed, velocity.x);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxSteer);
      applyForce(steer);
    }
    else if (location.y > height-25) {
      PVector desired = new PVector(-maxSpeed, velocity.x);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxSteer);
      applyForce(steer);
    }
  }
  
}

ArrayList <Vehicle> vehicles = new ArrayList<Vehicle>();
Vehicle v;

void setup() {
  size(displayWidth, displayHeight);
  v = new Vehicle(width, height); 
  vehicles.add(v);
  background(0);
}

void draw() {
  fill(0, 10);
  rect(0, 0, width, height);
  for (Vehicle veh : vehicles) {
    float r = random(1);
    if (r < 0.55) veh.seek(new PVector(mouseX, mouseY));
    else veh.wander();
    veh.update();
    veh.display();
  } 
}

void mousePressed() {
  Vehicle v = new Vehicle();
  vehicles.add(v);
}