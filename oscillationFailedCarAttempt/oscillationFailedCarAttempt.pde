class Car {
  float carHeight;
  float carWidth;
  
  float mass;
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float angle = 0;
  
  Car(float x, float y, float m) {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    
    carWidth = x;
    carHeight = y;
    mass = m;
  }
  
  void update() {
    velocity.add(acceleration);
    velocity.x = constrain(velocity.x, -20, 20);
    velocity.y = constrain(velocity.y, -20, 20);
    location.add(velocity);
    
    angle = velocity.heading();
    
    acceleration.mult(0);
  }
  
  void display() {
    noStroke();
    fill(0);
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    rect(-carWidth, -carHeight, carWidth, carHeight);
    popMatrix();
  }
  
  void checkEdges() {
    if (location.x > width) location.x = 0;
    else if (location.x < 0) location.x = width;
    
    if (location.y > height) location.y = 0;
    else if (location.y < 0) location.y = height;
  }
}

Car c;

void setup() {
  size(500, 500);
  c = new Car(5, 20, 12);
}

void draw() {
  background(255);
  c.update();
  c.checkEdges();
  c.display();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      PVector force = new PVector(0, -1);
      c.acceleration.add(force);
    }
    else if (keyCode == DOWN) {
      PVector force = new PVector(0, 1);
      c.acceleration.add(force);
    }
    else if (keyCode == RIGHT) {
      PVector force = new PVector(1, 0);
      c.acceleration.add(force);
    }
    else if (keyCode == LEFT) {
      PVector force = new PVector(-1, 0);
      c.acceleration.add(force);
    }
  }
  else if (key == 'Z' || key == 'z') {
    c.velocity.normalize();
    println("working");
  }
}

void keyReleased() {
  c.acceleration.x = 0;
  c.acceleration.y = 0;
}