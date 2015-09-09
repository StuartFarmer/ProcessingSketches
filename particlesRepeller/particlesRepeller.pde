import java.util.*;

class Particle {
  float mass;
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float lifespan;
  
  Particle(PVector location_) {
    location = new PVector(location_.x, location_.y);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    acceleration = new PVector(0, 0);
    lifespan = 255;
    mass = 1;
  }
  
  void run() {
    update();
    display();
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    
    lifespan -= 2;
  }
  
  void display() {
    noStroke();
    fill(255, 0, 0, lifespan);
    ellipse(location.x, location.y, 8, 8);
  }
  
  boolean isDead() {
    if (lifespan > 0) return false;
    else return true;
  }
}
class Repeller {
  PVector location;
  float r = 10;
  float g = 100;
  
  Repeller(PVector origin) {
    location = new PVector(origin.x, origin.y);
    stroke(0);
    fill(0);
    ellipse(location.x, location.y, r*2, r*2);
  }
  
  void display() {
    stroke(0);
    fill(0);
    ellipse(location.x, location.y, r*2, r*2);
  }
  
  PVector repel(Particle p) {
    PVector dir = PVector.sub(location, p.location);
    float d = dir.mag();
    d = constrain(d, 5, 100);
    dir.normalize();
    float force = -1 * g / (pow(d, 2));
    dir.mult(force);
    return dir;
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
    particles.add(new Particle(origin));
  }
  
  void update() {
    
    origin = new PVector(mouseX, mouseY);
    
    if (!kill) {
      addParticle();
    }
    
    lifespan--;
    Iterator<Particle> it = particles.iterator();
    while(it.hasNext()) {
      Particle p = (Particle)it.next();
      p.run();
      if (p.isDead()) {
        it.remove();
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
  
  void applyRepeller(Repeller r) {
    for (Particle p : particles) {
      PVector force = r.repel(p);
      p.acceleration.add(force);
    }
  }
}

ParticleSystem ps;
ArrayList<Repeller> repellers;

void setup() {
  size(500, 500);
  ps = new ParticleSystem(new PVector(width/2, height/2));
  
  // Create many repellers
  repellers = new ArrayList<Repeller>();
  for (int i = 0; i < 5; i++) {
    repellers.add(new Repeller(new PVector(random(width), random(height))));
  }
}

void draw() {
  background(255);
  ps.addParticle();
  PVector gravity = new PVector(0, 0.03);
  ps.applyForce(gravity);
  Iterator<Repeller> it = repellers.iterator();
  while (it.hasNext()) {
    Repeller r = it.next();
    ps.applyRepeller(r);
    r.display();
  }
  ps.update();
}

void keyPressed() {
  for (int i = 0; i < repellers.size(); i++) {
    repellers.remove(i);
    repellers.add(new Repeller(new PVector(random(width), random(height))));
  }
}