class Pendulum {
  PVector location;
  PVector origin;
  
  float r;     // arm length
  float angle; // pendulum arm angle
  float aVelocity;
  float aAcceleration;
  
  float damping;
  
  Pendulum(PVector origin_, float r_) {
    location = new PVector();
    
    origin = origin_.get();
    r = r_;
    angle = PI/4;
    
    aVelocity = 0.0;
    aAcceleration = 0.0;
    damping = 0.999;
  }
  
  void go() {
    update();
    display();
  }
  
  void update() {
    float gravity = 0.4;
    aAcceleration = (-1 * gravity / r) * sin(angle);
    aVelocity += aAcceleration;
    angle += aVelocity;
    aVelocity *= damping;
  }
  
  void display() {
    location.set(r*sin(angle), r*cos(angle));
    location.add(origin);
    
    stroke(0);
    
    line(origin.x, origin.y, location.x, location.y);
    fill(175);
    ellipse(location.x, location.y, 24, 24);
  }
}
Pendulum p;
void setup() {
  size(500, 500);
  PVector origin = new PVector(width/2, 0);
  p = new Pendulum(origin, 200);
}

void draw() {
  background(255);
  p.go();
}