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
    aVelocity = constrain(aVelocity, 0, 0.1);
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

int maxParticles = 25;
ArrayList<Particle> particles = new ArrayList<Particle>();

void setup() {
  size(640, 480);
  for (int i = 0; i < maxParticles; i++) {
    particles.add(new Particle(new PVector(width/2, height/2)));
  }
}

void draw() {
  background(255);
  
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.run();
    if (p.isDead()) {
      particles.remove(i);
      particles.add(new Particle(new PVector(width/2, height/2)));
    }
  }
  
  println(particles.size());
}