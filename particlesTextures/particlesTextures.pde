import java.util.*;

class Particle {
  PImage texture;
  float mass;
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float angle;
  
  float lifespan;
  
  Particle(PVector location_) {
    float vx = (float)randomGaussian()*0.3;
    float vy = (float)randomGaussian()*0.3 - 1;
    location = new PVector(location_.x, location_.y);
    velocity = new PVector(vx, vy);
    acceleration = new PVector(0, 0);
    lifespan = 255;
    mass = 1;
    angle = random(-2*PI, 2*PI);
    texture = loadImage("texture.png");
    texture.resize(0,(int)random(16, 128));
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
    pushMatrix();
      translate(location.x, location.y);
      rotate(angle);
      imageMode(CENTER);
      tint(255, lifespan);
      image(texture, 0, 0);
    popMatrix();
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
    stroke(255);
    fill(0);
    ellipse(location.x, location.y, r*2, r*2);
  }
  
  void display() {
    stroke(255);
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
    
    origin = new PVector(mouseX+(randomGaussian()*2), mouseY+(randomGaussian()*2));
    
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
  size(500, 500, P2D);
  // keypress index to change blend modes
  index = 0;
  ps = new ParticleSystem(new PVector(width/2, height/2));
  println("Press any key to cycle through blend modes.");
  blendMode(ADD);
}

void draw() {
  
  background(0);
  ps.addParticle();
  PVector gravity = new PVector(0, -0.003);
  ps.applyForce(gravity);
  ps.update();
}

int index;
void keyPressed() {
  index++;
  if (index >= 7) {
    index = 0;
    blendMode(ADD);
    println("Blend Mode: Add");
  }
  else if (index == 1) {
    blendMode(SUBTRACT);
    println("Blend Mode: Subtract");
  }
  else if (index == 2) {
    blendMode(LIGHTEST);
    println("Blend Mode: Lightest");
  }
  else if (index == 3) {
    blendMode(DARKEST);
    println("Blend Mode: Darkest");
  }
  else if (index == 4) {
    blendMode(DIFFERENCE);
    println("Blend Mode: Difference");
  }
  else if (index == 5) {
    blendMode(EXCLUSION);
    println("Blend Mode: Exclusion");
  }
  else if (index == 6) {
    blendMode(MULTIPLY);
    println("Blend Mode: Multiply");
  }
}