class Attractor {
  float mass;
  PVector location;
  
  Attractor() {
    mass = 20;
    location = new PVector(width/2, height/2);
  }
  
  void display() {
    noStroke();
    fill(100, 100, 255);
    ellipse(location.x, location.y, 32, 32);
  }
  
  PVector attract(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    force.normalize();
    distance = constrain(distance, 5, 25);
    float strength = (1 * mass * m.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }
}

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float mass;
  Mover(float m, float x, float y, PVector v) {
    location = new PVector(x, y);
    velocity = v;
    acceleration = new PVector(0, 0);
    
    mass = m;
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display() {
    noStroke();
    fill(255);
    ellipse(location.x, location.y, mass*8, mass*8);
  }
  
  void checkEdges() {
    // if a mover hits the edges of the width, reverse it's direction (via velocity) and place it at the width
    // same for the other edge
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    }
    else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1;
    }
    
    // mover will reverse direction and 'bounce' off the floor as well
    if (location.y > height) {
      location.y = height;
      velocity.y *= -1;
    }
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
}

Mover[] moons = new Mover[100];
Attractor earth;

void setup() {
  size(500,500);
  background(0);
  
  for (int i = 0; i < moons.length; i++) {
    PVector moonInitialVelocity = new PVector(random(-1, 1), random(-1, 1));
    moons[i] = new Mover(random(0.1, 2), random(width), random(height), moonInitialVelocity);
  }
  
  earth = new Attractor();
}

void draw() {
  background(0);
  
  for (int i = 0; i < moons.length; i++) {
    PVector force = earth.attract(moons[i]);
    moons[i].applyForce(force);
    moons[i].update();
    moons[i].display();
  }
  
  earth.display();
}