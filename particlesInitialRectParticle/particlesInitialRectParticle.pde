class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float angle;
  float aVelocity;
  float aAcceleration;
  
  float pWidth;
  float pHeight;
  
  float lifespan;
  
  Particle(PVector l) {
    pWidth = random(4, 16);
    pHeight = random(4, 16);
    
    location = new PVector(l.x, l.y);
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-1, 1));
    
    angle = PI / 4;
    aAcceleration = 0.01;
    
    lifespan = 255;
  }
  
  void run() {
    update();
    display();
  }
  
  void update() {
    // motion
    velocity.add(acceleration);
    location.add(velocity);
    
    // angular motion
    aVelocity += aAcceleration;
    angle += aVelocity;
    
    lifespan -= 2;
  }
  
  void display() {
    stroke(0, lifespan);
    fill(175, lifespan);
    pushMatrix();
      translate(location.x, location.y);
      rotate(angle);
      rect(-pWidth/2, -pHeight/2, pWidth, pHeight);
    popMatrix();
  }
  
  void applyForce(PVector force) {
    PVector f = force.get();
    acceleration.add(f);
  }
  
  boolean isDead() {
    if (lifespan > 0) return false;
    else return true;
  }
}

Particle p;

void setup() {
  size(640, 480);
  p = new Particle(new PVector(width/2, 10));
}

void draw() {
  background(255);
  p.run();
  if (p.isDead()) println("iz kill");
}