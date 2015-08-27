PVector speed;

class Walker {
  
  PVector location;
  PVector noiseTimer;
  
  Walker() {
    location = new PVector(width/2, height/2);
    noiseTimer = new PVector(0, 10000);
  }
  
  void step() {
    location.x += map(noise(noiseTimer.x), 0, 1, -speed.x, speed.x);
    location.y += map(noise(noiseTimer.y), 0, 1, -speed.y, speed.y);
    
    noiseTimer.x += 0.01;
    noiseTimer.y += 0.01;
    
    // Create boundaries
    if (location.x >= width) location.x += -speed.x;
    else if (location.x < 0) location.x += speed.x;
    
    if (location.y >= height) location.y += -speed.y;
    else if (location.y < 0) location.y += speed.y;
    
  }
  
  void display() {
    ellipse(location.x, location.y, 24, 24);
  }
}

Walker w;

void setup() {
  
  speed = new PVector(5, 5);
  size(500,500);
  background(255);
  w = new Walker();
}

void draw() {
  w.step();
  w.display();
}