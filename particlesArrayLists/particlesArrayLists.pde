import java.util.Iterator;
import java.util.ArrayList;

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
  
  color c;
  
  Particle(PVector l) {
    pWidth = random(4, 16);
    pHeight = random(4, 16);
    
    location = new PVector(l.x, l.y);
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-1, 1));
    
    angle = PI / 4;
    aAcceleration = 0.01;
    
    lifespan = 255;
    
    int colorChoice = (int)random(0, 4);
    if (colorChoice == 0) c = color(255, 0, 0);
    else if (colorChoice == 1) c = color(0, 255, 0);
    else if (colorChoice == 2) c = color(0, 0, 255);
    else if (colorChoice == 3) c = color(255, 255, 0);
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
    aVelocity = constrain(aVelocity, 0, 0.1);
    aVelocity += aAcceleration;
    angle += aVelocity;
    
    lifespan -= 2;
  }
  
  void display() {
    noStroke();
    fill(c, lifespan);
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

int maxParticles = 25;
ArrayList<Particle> particles;

void setup() {
  size(640, 480);
  particles = new ArrayList<Particle>();
}

void draw() {
  background(255);
  
  particles.add(new Particle(new PVector(mouseX, mouseY)));
  
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.run();
    if (p.isDead()) {
      particles.remove(i);
    }
  }
  
  println(particles.size());
}