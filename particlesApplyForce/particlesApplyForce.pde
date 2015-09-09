class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float mass;
  
  float lifespan;
  
  Particle(PVector location_) {
    location = new PVector(location_.x, location_.y);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    acceleration = new PVector(0, 0);
    mass = 1;
    lifespan = 255;
  }
  
  void run() {
    update();
    display();
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    lifespan -= 2;
  }
  
  void display() {
    fill(0, lifespan);
    ellipse(location.x, location.y, 8, 8);
  }
  
  boolean isDead() {
    if (lifespan > 0) return false;
    else return true;
  }
}

class Confetti extends Particle {
  float angle;
  float aVelocity;
  float aAcceleration;
  
  Confetti(PVector location_) {
    super(location_);
    
    angle = PI / 4;
    aAcceleration = 0.01;
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    
    aVelocity = constrain(aVelocity, 0, 0.1);
    aVelocity += aAcceleration;
    angle += aVelocity;
  }
  
  void display() {
    rectMode(CENTER);
    fill(175, lifespan);
    stroke(0);
    pushMatrix();
      translate(location.x, location.y);
      rotate(angle);
      rect(0, 0, 8, 8);
    popMatrix();
  }
}

class Funfetti extends Particle {
  float angle;
  float aVelocity;
  float aAcceleration;
  
  float fWidth = random(2, 16);
  float fHeight = random(2, 16);
  
  color c;
  
  Funfetti(PVector location_) {
    super(location_);
    
    angle = PI / 4;
    aAcceleration = 0.01;
    
    int colorChoice = (int)random(0, 4);
    if (colorChoice == 0) c = color(255, 0, 0);
    else if (colorChoice == 1) c = color(0, 255, 0);
    else if (colorChoice == 2) c = color(0, 0, 255);
    else if (colorChoice == 3) c = color(255, 255, 0);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    
    aVelocity = constrain(aVelocity, 0, 0.1);
    aVelocity += aAcceleration;
    angle += aVelocity;
  }
  
  void display() {
    rectMode(CENTER);
    noStroke();
    fill(c, lifespan);
    pushMatrix();
      translate(location.x, location.y);
      rotate(angle);
      rect(0, 0, 8, 8);
    popMatrix();
  }
}

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  
  float startAngle = 0;
  float angleVel = 0.1;
  
  float lifespan;
  boolean kill;
  
  ParticleSystem(PVector location) {
    origin = new PVector(location.x, location.y);
    particles = new ArrayList<Particle>();
    lifespan = 90;
    kill = false;
  }
  
  void addParticle() {
    int type = (int)random(0, 3);
    if (type == 0) particles.add(new Particle(origin));
    else if (type == 1) particles.add(new Confetti(origin));
    else if (type == 2) particles.add(new Funfetti(origin));
  }
  
  void update() {
    
    if (!kill) {
      addParticle();
    }
    
    lifespan--;
    
    for (int i = 0; i < particles.size(); i++) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
  
  void applyForce(PVector force) {
    for (Particle p : particles) {
      PVector f = new PVector(force.x, force.y);
      f.div(p.mass);
      p.acceleration.add(f);
    }
  }
}

ParticleSystem ps;

void setup() {
  size(500, 500);
  ps = new ParticleSystem(new PVector(width/2, height/2));
}

void draw() {
  background(255);
  PVector f = new PVector(0, 0.01);
  ps.applyForce(f);
  ps.update();
}