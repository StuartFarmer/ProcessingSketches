class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float mass;
  Mover(float m, float x, float y) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
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
    fill(0);
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
  
  boolean isInsideLiquid(Liquid l) {
    if (location.x>l.x && location.x<l.x+l.w && location.y > l.y && location.y < l.y + l.h) return true;
    else return false;
  }
  
  void drag(Liquid l) {
    float speed = velocity.mag();
    float dragMag = l.c * speed * speed;
    
    PVector drag = velocity.get();
    drag.mult(-1);
    drag.normalize();
    drag.mult(dragMag);
    
    applyForce(drag);
  }
}

class Liquid {
  // dimensions
  float x, y, w, h;
  // coefficient of drag
  float c;
  
  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }
  
  void display() {
    noStroke();
    fill(175);
    rect(x, y, w, h);
  }
}

Mover[] movers = new Mover[100];
Liquid liquid;

void setup() {
  size(500, 500);
  background(255);
  
  // Create 100 moving balls
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(map(i, 0, movers.length, 0.1, 5), 0, 0);
  }
  
  // Set up a liquid area to test drag forces in
  liquid = new Liquid(0, height/2, width, height/2, 0.01);
}

void draw() {
  background(255);
  liquid.display();
  
  for (int i = 0; i < movers.length; i++) {
    PVector wind = new PVector(0.01, 0);
    float m = movers[i].mass;
    PVector gravity = new PVector(0, 0.1*m);
    
    //friction
    if (movers[i].isInsideLiquid(liquid)) movers[i].drag(liquid);
    
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
    
    movers[i].update();
    movers[i].checkEdges();
    movers[i].display();
  }
}