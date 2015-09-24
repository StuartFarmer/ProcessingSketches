class Vehicle {
 
  PVector location;
  PVector velocity;
  PVector acceleration;

  float r;
  float maxforce;
  float maxspeed;
  
  float seperationStrength = 3;
  float seekStrength = 0.5;
 
  float wanderTheta;
  
  float x;
  float y;
  float z;
 
  Vehicle(float x, float y) {
    acceleration = new PVector(0,0);
    velocity = new PVector(random(-1, 1), random(-1, 1));
    location = new PVector(x,y);
    r = 3.0;

    maxspeed = 4;
    maxforce = 0.1;
    
    wanderTheta = 0;
    
    x = random(100000);
    y = random(100000);
    z = random(100000);

  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
    checkEdges();
    x++;
    y++;
    z++;
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  PVector seek(PVector target) {
    PVector desired = PVector.sub(target,location);
    desired.normalize();
    
    float mult = 0;
    desired.mult(map(mult, 0, maxspeed, 0, PVector.dist(target, location)));
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);
    return steer;
  }
 
  void display() {

    float theta = velocity.heading() + PI/2;
    fill(175);
    stroke(0);
    pushMatrix();
    translate(location.x,location.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }
  
  void checkEdges() {
    if (location.x > width) location.x = 0;
    else if (location.x < 0) location.x = width;
    
    if (location.y > height) location.y = 0;
    else if (location.y < 0) location.y = height;
  }
  
  PVector seperate(ArrayList<Vehicle> vehicles) {
    PVector steer = new PVector();
    for (Vehicle v : vehicles) {
      float seperation = 20;
      
      PVector sum = new PVector();
      float count = 0;
      
      float d = PVector.dist(location, v.location);
      if ((d > 0) && (d < seperation)) {
        // check if vehicle is in sight
        PVector distanceVector = PVector.sub(v.location, location);
        float theta = PVector.angleBetween(distanceVector, velocity);
        theta = degrees(theta);
        
        if (abs(theta) < 45) {
          PVector diff = PVector.sub(location, v.location);
          diff.normalize();
          
          sum.add(diff);
          count++;
        }
      }
      if (count > 0) {
        sum.div(count);
        sum.setMag(maxspeed);
        steer = PVector.sub(sum, velocity);
        steer.limit(maxforce);
        
      }
    }
    return steer;
  }
  
  PVector attract(ArrayList<Vehicle> vehicles) {
    PVector steer = new PVector();
    float maximumDistance = 100;
    
    PVector sum = new PVector();
    int count = 0;
    
    for (Vehicle v : vehicles) {
      float d = PVector.dist(location, v.location); 
      
      if ((d > 0) && (d < maximumDistance)) {
        // check if vehicle is in sight
        PVector distanceVector = PVector.sub(v.location, location);
        float theta = PVector.angleBetween(distanceVector, velocity);
        theta = degrees(theta);
        
        if (abs(theta) < 45) {
          PVector difference = PVector.sub(location, v.location);
          difference.normalize();
          difference.mult(-1);
          sum.add(difference);
          count++;
        }
      }
    }
    if (count > 0) {
      sum.div(count);
      sum.setMag(maxspeed);
      steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      
    }
    return steer;
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

  void applyBehaviors(ArrayList<Vehicle> vehicles) {
    PVector seperate = seperate(vehicles);
    //PVector seek = seek(new PVector(mouseX, mouseY));
    PVector attract = attract(vehicles);
    
    seperate.mult(seperationStrength);
    //seek.mult(seekStrength);
    
    
    applyForce(seperate);
    //applyForce(seek);
    applyForce(attract);
    wander();
  }
  
  PVector align(ArrayList<Vehicle> vehicles) {
    PVector sum = new PVector(0, 0);
    for (Vehicle v : vehicles) {
      sum.add(v.velocity);
    }
    sum.div(vehicles.size());
    sum.setMag(maxspeed);
    
    PVector steer = PVector.sub(sum, velocity);
    
    steer.limit(maxforce);
    
    return steer;
  }
  
  void flock(ArrayList<Vehicle> vehicles) {
    PVector seperate = seperate(vehicles);
    PVector align = align(vehicles);
    PVector attract = attract(vehicles);
    
    
    
    seperate.mult(random(-1, 1) * noise(x));
    align.mult(random(0, 2) * noise(y));
    attract.mult(random(0, 2) * noise(z));
    
    applyForce(seperate);
    applyForce(align);
    applyForce(attract);
    
  }
}

ArrayList<Vehicle> vehicles;

void setup() {
  size(500, 500);
  background(255);
  vehicles = new ArrayList<Vehicle>();
  for (int i = 0; i < 100; i++) {
    vehicles.add(new Vehicle(random(0, width), random(0, height)));
  }
}

void draw() {
  background(255);
  for (Vehicle v : vehicles) {
    v.update();
    v.flock(vehicles);
    v.wander();
    v.display();
  }
}

void mousePressed() {
  Vehicle v = new Vehicle(mouseX, mouseY);
  vehicles.add(v);
}