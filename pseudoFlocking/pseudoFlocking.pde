class Vehicle {
 
  PVector location;
  PVector velocity;
  PVector acceleration;

  float r;
  float maxforce;
  float maxspeed;
  
  float seperationStrength = random(0.25, 1.5);
  float seekStrength = random(0.25, 1.5);
 
  float wanderTheta;
 
  Vehicle(float x, float y) {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    location = new PVector(x,y);
    r = 3.0;

    maxspeed = 4;
    maxforce = 0.1;
    
    wanderTheta = 0;

  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
    checkEdges();
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
    if (location.x < 25) {
      PVector desired = new PVector(maxspeed, velocity.y);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxspeed);
      applyForce(steer);
    } else if (location.x > width-25) {
      PVector desired = new PVector(-maxspeed, velocity.y);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxspeed);
      applyForce(steer);
    }
    if (location.y < 25) {
      PVector desired = new PVector(maxspeed, velocity.x);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxspeed);
      applyForce(steer);
    }
    else if (location.y > height-25) {
      PVector desired = new PVector(-maxspeed, velocity.x);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxspeed);
      applyForce(steer);
    }
  }
  
  PVector seperate(ArrayList<Vehicle> vehicles) {
    PVector steer = new PVector();
    for (Vehicle v : vehicles) {
      float seperation = 20;
      
      PVector sum = new PVector();
      float count = 0;
      
      float d = PVector.dist(location, v.location);
      if ((d > 0) && (d < seperation)) {
        PVector diff = PVector.sub(location, v.location);
        diff.normalize();
        sum.add(diff);
        count++;
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
      
      if (d >= maximumDistance) {
        PVector difference = PVector.sub(location, v.location);
        difference.normalize();
        difference.mult(-1);
        sum.add(difference);
        count++;
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
    PVector seek = seek(new PVector(mouseX, mouseY));
    PVector attract = attract(vehicles);
    
    seperate.mult(seperationStrength);
    seek.mult(seekStrength);
    wander();
    
    applyForce(seperate);
    //applyForce(seek);
    applyForce(attract);
    
  }
}

ArrayList<Vehicle> vehicles;

void setup() {
  size(500, 500);
  background(255);
  vehicles = new ArrayList<Vehicle>();
}

void draw() {
  background(255);
  for (Vehicle v : vehicles) {
    v.applyBehaviors(vehicles);
    v.update();
    //v.display();
  }
  if (vehicles.size() > 0) {
    stroke(0);
    strokeWeight(16);
    fill(0);
    beginShape();
      vertex(vehicles.get(0).location.x, vehicles.get(0).location.y);
      for (int i = 1; i < vehicles.size(); i++) {
        vertex(vehicles.get(i).location.x, vehicles.get(i).location.y);
      }
      vertex(vehicles.get(0).location.x, vehicles.get(0).location.y);
    endShape();
  }
}

void mousePressed() {
  Vehicle v = new Vehicle(mouseX, mouseY);
  vehicles.add(v);
}